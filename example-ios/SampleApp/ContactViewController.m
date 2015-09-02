#import <Foundation/Foundation.h>

#include "ContactViewController.h"
#include "MasterViewController.h"
#include "ContactDetailRecord.h"
#include "ContactEditViewController.h"
#import "NIKApiInvoker.h"
#import "AppDelegate.h"

@interface ContactViewController ()

// holds contactinfo records
@property(nonatomic, retain) NSMutableArray* contactDetails;

@property(nonatomic, retain) NSMutableArray* contactGroups;

@property(nonatomic, retain) dispatch_queue_t queue;

@property(nonatomic, retain) NSCondition* groupLock;
@property(nonatomic) BOOL groupReady;

@property(nonatomic, retain) NSCondition* viewLock;
@property(nonatomic) BOOL viewReady;

@property(nonatomic, retain) NSCondition* waitLock;
@property(nonatomic) BOOL waitReady;

@property(nonatomic) BOOL cancled;
@end

static NSString* baseUrl = @"";

@implementation ContactViewController

// when adding view controller, need to calc how big it has to be ahead of time
// need to create all the records and such first
- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.contactDetailScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.contactDetailScrollView.backgroundColor = [UIColor colorWithRed:254/255.0f green:254/255.0f blue:254/255.0f alpha:1.0f];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.editButton removeTarget:self action:@selector(hitEditContactButton) forControlEvents:UIControlEventTouchDown];
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.viewReady == NO){
        // only unlock the view if it is locked
        self.viewReady = YES;
        [self.viewLock signal];
        [self.viewLock unlock];
    }
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.editButton addTarget:self action:@selector(hitEditContactButton) forControlEvents:UIControlEventTouchDown];
    [navBar showEdit];
    [navBar enableAllTouch];
    self.didPrecall = NO;
}

- (void) prefetch {
    // since there are a bunch of bigger calls (download and relational) needed for this
    // view, run the gets at the same time and do the calls asynchronously
    // prefetch -> waitLock lock blocks showVC -> contactInfo call finished + unlocks showVC
    // view gets pushed, unlocks viewLock -> first page of view gets built as animation comes in
    // group list gets added once its done -> picture comes in
    // TODO: double check that deadlock can't happen here
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    baseUrl=baseDSPUrl;
    
    self.contactDetails = [[NSMutableArray alloc] init];
    self.contactGroups = [[NSMutableArray alloc] init];
    
    
    self.groupLock = [[NSCondition alloc] init];
    self.waitLock = [[NSCondition alloc] init];
    self.viewLock = [[NSCondition alloc] init];
    
    self.waitReady = NO;
    self.groupReady = NO;
    self.viewReady = NO;
    self.cancled = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.waitLock lock];
        [self.viewLock lock];
        [self.groupLock lock];
    });
    
    self.queue = dispatch_queue_create("contactViewQueue", NULL);
    dispatch_async(self.queue, ^ (void){
        [self getContactInfoFromServer:self.contactRecord];
    });
    dispatch_async(self.queue, ^ (void){
        [self getContactsListFromServerWithRelation];
    });
    
    dispatch_async(self.queue, ^ (void){
        [self buildContactView];
    });
}

- (void) waitToReady {
    [self.waitLock lock];
    while(self.waitReady == NO){
        [self.waitLock wait];
    }
    [self.waitLock signal];
    [self.waitLock unlock];
}

- (void) canclePrefetch{
    self.cancled = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.viewReady = YES;
        [self.viewLock signal];
        [self.viewLock unlock];
    });
}

- (void) hitEditContactButton{
    ContactEditViewController* contactEditViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactEditViewController"];
    // tell the contact list what group it is looking at
    contactEditViewController.contactRecord = self.contactRecord;
    contactEditViewController.contactViewController = self;
    contactEditViewController.contactDetails = self.contactDetails;
    [self.navigationController pushViewController:contactEditViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// build the address boxes
- (UIView*) buildAddressView:(ContactDetailRecord*)record y:(NSNumber*)y buffer:(NSNumber*)buffer {
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, [y doubleValue] + [buffer doubleValue], self.view.frame.size.width, 20)];
    
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel* type_label = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, subview.frame.size.width - 25, 30)];
    type_label.text = record.Type;
    type_label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 23.0];
    [type_label setTextColor:[UIColor colorWithRed:253/255.0f green:253/255.0f blue:250/255.0f alpha:1.0f]];
    [subview addSubview:type_label];
    
    int next_y = 40; // track where the lowest item is
    
    if([record.Email length] > 0){
        UILabel* email_label = [[UILabel alloc] initWithFrame:CGRectMake(75, 40, subview.frame.size.width - 75, 30)];
        email_label.text = record.Email;
        email_label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 20.0];
        [email_label setTextColor:[UIColor colorWithRed:249/255.0f green:249/255.0f blue:249/255.0f alpha:1.0f]];
        
        UIImageView* email_image = [[UIImageView alloc] initWithFrame:CGRectMake(50, 45, 20, 20)];
        [email_image setImage:[UIImage imageNamed:@"mail.png"]];
        [email_image setContentMode:UIViewContentModeScaleAspectFit];
        
        [subview addSubview:email_label];
        [subview addSubview:email_image];
        next_y += 60;
    }
    
    if([record.Phone length] > 0){
        UILabel* phone_label = [[UILabel alloc] initWithFrame:CGRectMake(75, next_y, subview.frame.size.width - 75, 20)];
        phone_label.text = record.Phone;
        phone_label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 20.0];
        [phone_label setTextColor:[UIColor colorWithRed:253/255.0f green:253/255.0f blue:250/255.0f alpha:1.0f]];
        
        UIImageView* phone_image = [[UIImageView alloc] initWithFrame:CGRectMake(50, next_y, 20, 20)];
        [phone_image setImage:[UIImage imageNamed:@"phone1.png"]];
        [phone_image setContentMode:UIViewContentModeScaleAspectFit];
        
        [subview addSubview:phone_label];
        [subview addSubview:phone_image];
        
        next_y += 60;
    }
    
    if( [record.Address length] > 0 && [record.City length] > 0 && [record.State length] > 0 && [record.Zipcode length] > 0){
        
        UILabel* address_label = [[UILabel alloc] initWithFrame:CGRectMake(75, next_y, subview.frame.size.width - 75, 20)];
        [address_label setTextColor:[UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1.0f]];
        
        if([record.Country length] > 0){
            address_label.text = [NSString stringWithFormat:@"%@\n%@, %@ %@\n%@", record.Address, record.City, record.State, record.Zipcode, record.Country];
        }
        else{
            address_label.text = [NSString stringWithFormat:@"%@\n%@, %@ %@", record.Address, record.City, record.State, record.Zipcode];
        }
        
        address_label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 19.0];
        address_label.numberOfLines = 0;
        [address_label sizeToFit];
        
        UIImageView* address_image = [[UIImageView alloc] initWithFrame:CGRectMake(50, next_y, 20, 20)];
        [address_image setImage:[UIImage imageNamed:@"home.png"]];
        [address_image setContentMode:UIViewContentModeScaleAspectFit];
        
        [subview addSubview:address_label];
        [subview addSubview:address_image];
        
        next_y += address_label.frame.size.height;
    }
    
    // resize the subview
    CGRect viewFrame = subview.frame;
    viewFrame.size.height = next_y + 20;
    viewFrame.origin.x = self.view.frame.size.width * 0.06;
    viewFrame.size.width = self.view.frame.size.width * 0.88;
    subview.frame = viewFrame;
    return subview;
}

- (UIView*) makeListOfGroupsContactBelongsTo {
    UIView* subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    UILabel* type_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, subview.frame.size.width - 25, 30)];
    
    type_label.text = @"Groups:";
    type_label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 23.0];
    [subview addSubview:type_label];
    
    int y = 50;
    for(NSString* groupName in self.contactGroups){
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(25, y, subview.frame.size.width - 75, 30)];
        label.text = groupName;
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 20.0];
        y += 30;
        
        [subview addSubview:label];
    }
    
    // resize the subview
    CGRect viewFrame = subview.frame;
    viewFrame.size.height = y + 20;
    viewFrame.origin.x = self.view.frame.size.width * 0.06;
    viewFrame.size.width = self.view.frame.size.width * 0.88;
    subview.frame = viewFrame;
    return subview;
}

- (void) buildContactView {
    // clear out the view
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.contactDetailScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    });
    
    // go get the profile image
    
    UIImageView* profile_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * .6, self.view.frame.size.width * .5)];
    [self getProfilePictureFromServer:profile_image];
    
    // view lock dependent on
    [self.viewLock lock];
    while(self.viewReady == NO){
        // so we don't burn the CPU
        [NSThread sleepForTimeInterval:0.0001];
        [self.viewLock wait];
    }
    
    [self.viewLock unlock];
    
    if(self.cancled){
        return;
    }
    
    // track the y of the furthest item down in the view
    __block int y = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [profile_image setCenter:CGPointMake(self.view.frame.size.width * 0.5, profile_image.frame.size.height * 0.5 )];
        
        y = profile_image.frame.size.height + 5;
        
        // add the name label
        UILabel* name_label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, 35)];
        name_label.text = [NSString stringWithFormat:@"%@ %@", self.contactRecord.FirstName, self.contactRecord.LastName];
        name_label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 25.0];
        name_label.textAlignment = NSTextAlignmentCenter;
        [self.contactDetailScrollView addSubview:name_label];
        y += 40;
        
        if([self.contactRecord.Twitter length] > 0){
            UILabel* twitter_label = [[UILabel alloc] initWithFrame:CGRectMake(40, y, self.view.frame.size.width - 40, 20)];
            [twitter_label setFont:[UIFont fontWithName:@"Helvetica Neue" size: 17.0]];
            twitter_label.text = self.contactRecord.Twitter;
            
            UIImageView* twitter_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, y, 20, 20)];
            
            
            [twitter_image setImage:[UIImage imageNamed:@"twitter2.png"]];
            [twitter_image setContentMode:UIViewContentModeScaleAspectFit];
            [self.contactDetailScrollView addSubview:twitter_label];
            [self.contactDetailScrollView addSubview:twitter_image];
            
            y += 30;
        }
        
        if([self.contactRecord.Skype length] > 0){
            UILabel* skype_label = [[UILabel alloc] initWithFrame:CGRectMake(40, y, self.view.frame.size.width - 40, 20)];
            skype_label.text = self.contactRecord.Skype;
            [skype_label setFont:[UIFont fontWithName:@"Helvetica Neue" size: 17.0]];
            
            UIImageView* skype_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, y, 20, 20)];
            
            [skype_image setImage:[UIImage imageNamed:@"skype.png"]];
            [skype_image setContentMode:UIViewContentModeScaleAspectFit];
            [self.contactDetailScrollView addSubview:skype_label];
            [self.contactDetailScrollView addSubview:skype_image];
            y += 30;
        }
        
        // add the notes
        if([self.contactRecord.Notes length ] > 0){
            UILabel* note_title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, 80, 25)];
            note_title_label.text = @"Notes";
            [note_title_label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size: 19.0]];
            y += 20;
            
            UILabel* notes_label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * .05, y, self.view.frame.size.width * .9, 80)];
            [notes_label setAutoresizesSubviews:YES];
            
            [notes_label setFont:[UIFont fontWithName:@"Helvetica Neue" size: 16.0]];
            notes_label.text = self.contactRecord.Notes;
            notes_label.numberOfLines = 0;
            [notes_label sizeToFit];
            
            [self.contactDetailScrollView addSubview:note_title_label];
            [self.contactDetailScrollView addSubview:notes_label];
            
            y += notes_label.frame.size.height + 10;
        }
    });
    // add all the addresses
    UIColor* backgroundColor = [UIColor colorWithRed:112/255.0f green:147/255.0f blue:181/255.0f alpha:1.0f];
    
    // don't need to have a lock here because the view lock is dependent on this data loading
    dispatch_async(dispatch_get_main_queue(), ^{
        for(ContactDetailRecord* record in self.contactDetails){
            UIView* toAdd = [self buildAddressView:record y:[NSNumber numberWithInt:y] buffer:[NSNumber numberWithInt:25]];
            toAdd.backgroundColor = backgroundColor;
            y += toAdd.frame.size.height + 25;
            [self.contactDetailScrollView addSubview:toAdd];
        }
    });
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.contactDetailScrollView reloadInputViews];
    });
    
    // wait until the group is ready to build group list subviews
    [self.groupLock lock];
    while(self.groupReady == NO){
        [self.groupLock wait];
    }
    [self.groupLock unlock];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIView* toAdd = [self makeListOfGroupsContactBelongsTo];
        CGRect frame = toAdd.frame;
        frame.origin.y = y + 20;
        toAdd.frame = frame;
        [self.contactDetailScrollView addSubview:toAdd];
    });
    
    // resize the scroll view content
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect contentRect = CGRectZero;
        for (UIView *view in self.contactDetailScrollView.subviews) {
            contentRect = CGRectUnion(contentRect, view.frame);
        }
        self.contactDetailScrollView.contentSize = contentRect.size;
        [self.contactDetailScrollView reloadInputViews];
    });
    
}

- (NSString*) removeNull:(id) input{
    if(input == [NSNull null]){
        return @"";
    }
    return (NSString*) input;
}

- (void) getContactInfoFromServer:(ContactRecord*)contact_record {
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact_info"; // rest path
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        // get the contact records
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        NSString *filter = [NSString stringWithFormat:@"contact_id=%@", contact_record.Id];
        queryParams[@"filter"] = filter;
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        NSString* contentType = @"application/json";
        id requestBody = nil;
        
        [_api restPath:restApiPath
                method:@"GET"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
           if (error) {
               NSLog(@"Error getting contact info: %@",error);
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.navigationController popToRootViewControllerAnimated:YES];
               });
           }
           else{
               NSMutableArray* array = [[NSMutableArray alloc] init];
               // put the contact ids into an array
               
               // double check we don't fetch any repeats
               NSMutableArray* existingIds = [[NSMutableArray alloc] init];
               for (NSDictionary *recordInfo in [responseDict objectForKey:@"record"]) {
                   @autoreleasepool {
                       NSNumber* recordId = [recordInfo objectForKey:@"id"];
                       if([existingIds containsObject:recordId]){
                           continue;
                       }
                       ContactDetailRecord* new_record = [[ContactDetailRecord alloc] init];
                       [new_record setId:[recordInfo objectForKey:@"id"]];
                       [new_record setAddress:[self removeNull:[recordInfo objectForKey:@"address"]]];
                       [new_record setCity :[self removeNull:[recordInfo objectForKey:@"city"]]];
                       [new_record setCountry:[self removeNull:[recordInfo objectForKey:@"country"]]];
                       [new_record setEmail:[self removeNull:[recordInfo objectForKey:@"email"]]];
                       [new_record setType:[self removeNull:[recordInfo objectForKey:@"info_type"]]];
                       [new_record setPhone:[self removeNull:[recordInfo objectForKey:@"phone"]]];
                       [new_record setState:[self removeNull:[recordInfo objectForKey:@"state"]]];
                       [new_record setZipcode:[self removeNull:[recordInfo objectForKey:@"zip"]]];
                       [new_record setContactId:[recordInfo objectForKey:@"contact_id"]];
                       [array addObject:new_record];
                   }
               }
               // tell the contact list what group it is looking at
               self.contactDetails = array;
               
               
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   self.waitReady = YES;
                   [self.waitLock signal];
                   [self.waitLock unlock];
               });
           }
       }];
    }
}

- (void) getProfilePictureFromServer:(UIImageView*) image_display{
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    if(self.contactRecord.ImageUrl == nil ||[self.contactRecord.ImageUrl isEqual:@""]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [image_display setImage:[UIImage imageNamed:@"default_portrait.png"]];
            [image_display setContentMode:UIViewContentModeScaleAspectFit];
            [self.contactDetailScrollView addSubview:image_display];
        });
        return;
    }
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/files/container/application/<folder path>/filename
        // here the folder path is profile_images/contactId/
        // the file path does not end in a '/' because we are targeting a file not a folder
        NSString* container_name = @"applications";
        NSString* folder_path = [NSString stringWithFormat:@"profile_images/%@", [self.contactRecord.Id stringValue]];
        NSString* file_name = self.contactRecord.ImageUrl;
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/files/%@/%@/%@/%@",baseUrl,container_name, kApplicationName, folder_path, file_name];
        NSLog(@"\nAPI path: %@\n", restApiPath);
        
        // request a download from the file
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        queryParams[@"include_properties"] = [NSNumber numberWithBool:YES];
        queryParams[@"content"] = [NSNumber numberWithBool:YES];
        queryParams[@"download"] = [NSNumber numberWithBool:YES];
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        NSString* contentType = @"application/json";
        id requestBody = nil;
        [_api restPath:restApiPath
                method:@"GET"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
           NSLog(@"Error getting profile image data from server: %@",error);
           
           dispatch_async(dispatch_get_main_queue(),^ (void){
               UIImage* image = nil;
               
               @try {
                   NSData *fileData = [[NSData alloc] initWithBase64EncodedString:[responseDict objectForKey:@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                   image = [UIImage imageWithData:fileData];
               }
               @catch (NSException *exception) {
                   NSLog(@"\nWARN: Could not load image off of server, loading default\n");
                   image = [UIImage imageNamed:@"default_portrait.png"];
                   
               }
               @finally {
                   if(image == nil || image.CGImage == nil){
                       NSLog(@"\nERROR: Could not make a profile image\n");
                   }
               }
               
               if(error || image == nil || image.CGImage == nil){
                   image = [UIImage imageNamed:@"default_portrait.png"];
               }
               
               [image_display setImage:image];
               [image_display setContentMode:UIViewContentModeScaleAspectFit];
               
               [self.contactDetailScrollView addSubview:image_display];
           });
       }];
    }
}

- (void) getContactsListFromServerWithRelation{
    // get all the group the contact is in using relational queries
    
    // get the base URL
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    baseUrl=baseDSPUrl;
    
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact_group_relationship"; // table name
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        // only get contactrelationships for this contact
        NSString *filter = [NSString stringWithFormat:@"contact_id=%@", self.contactRecord.Id];
        queryParams[@"filter"] = filter;
        
        // request without related would return just {id, groupId, contactId}
        // set the related field to go get the group records referenced by
        // each contactrelationships record
        queryParams[@"related"] = @"contact_group_by_contact_group_id";
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        NSString* contentType = @"application/json";
        id requestBody = nil;
        [_api restPath:restApiPath
                method:@"GET"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
           if (error) {
               NSLog(@"Error getting groups with relation: %@",error);
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.navigationController popToRootViewControllerAnimated:YES];
               });
           }
           else{
               [self.contactGroups removeAllObjects];
               
               // handle repeat contact-group relationships
               NSMutableArray* tmpGroupIdList = [[NSMutableArray alloc] init];
               
               /*
                *  Structure of reply is:
                *  {
                *      record:[
                *          {
                *              <relation info>,
                *              contact_group_by_contactGroupId:{
                *                  <group info>
                *              }
                *          },
                *          ...
                *      ]
                *  }
                */
               for (NSDictionary *relationRecord in [responseDict objectForKey:@"record"]) {
                   NSDictionary* recordInfo = [relationRecord objectForKey:@"contact_group_by_contact_group_id"];
                   NSNumber* contactId = [recordInfo objectForKey:@"id"];
                   if([tmpGroupIdList containsObject:contactId]){
                       // a different record already related the group-contact pair
                       continue;
                   }
                   [tmpGroupIdList addObject:contactId];
                   NSString* groupName = [recordInfo objectForKey:@"name"];
                   [self.contactGroups addObject:groupName];
               }
               
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   self.groupReady = YES;
                   [self.groupLock signal];
                   [self.groupLock unlock];
               });
           }
       }];
    }
}

@end
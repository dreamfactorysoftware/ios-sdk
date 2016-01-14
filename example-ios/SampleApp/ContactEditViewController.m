#import <Foundation/Foundation.h>
#include "ContactEditViewController.h"
#include "ContactDetailRecord.h"
#include "ContactInfoView.h"
#include "ProfileImagePickerViewController.h"
#import "RESTEngine.h"
#import "AppDelegate.h"

@interface ContactEditViewController ()<UITextFieldDelegate>

// all the text fields we programmatically create
@property(nonatomic, retain) NSMutableDictionary* textFields;

// holds all new contact info fields
@property(nonatomic, retain) NSMutableArray* addedContactInfo;

// for handling a profile image set up for a new user
@property(nonatomic, retain) NSString* imageUrl;
@property(nonatomic, retain) UIImage* profileImage;

@end


@implementation ContactEditViewController

// when adding view controller, need to calc how big it has to be ahead of time
// need to create all the records and such first
- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Build the view programmatically
    self.contactEditScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.contactEditScrollView.backgroundColor = [UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1.0f];
    
    self.textFields = [[NSMutableDictionary alloc] init];
    self.addedContactInfo = [[NSMutableArray alloc] init];
    
    [self buildContactFields];
    
    // resize
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.contactEditScrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.contactEditScrollView.contentSize = contentRect.size;
    
    self.imageUrl = @"";
    self.profileImage = nil;
    
    [self.view reloadInputViews];
    [self.contactEditScrollView reloadInputViews];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.doneButton removeTarget:self action:@selector(hitSaveButton) forControlEvents:UIControlEventTouchDown];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar showDone];
    [navBar.doneButton addTarget:self action:@selector(hitSaveButton) forControlEvents:UIControlEventTouchDown];
    [navBar enableAllTouch];
}

- (void) addItemViewController:(ProfileImagePickerViewController *)controller didFinishEnteringItem:(NSString *)item {
    // gets info passed back up from the image picker
    self.contactRecord.ImageUrl = item;
}

- (void) addItemWithoutContactViewController:(ProfileImagePickerViewController *)controller didFinishEnteringItem:(NSString *)item didChooseImageFromPicker:(UIImage*) image {
    // gets info passed back up from the image picker
    self.imageUrl = item;
    self.profileImage = image;
}

- (void) hitSaveButton{
    // check that a legal contact name was entered
    NSNumber* contactTextFieldId = [NSNumber numberWithInt:-1];
    NSString* firstName = [self getTextValue:@"First Name" recordId:contactTextFieldId];
    NSString* lastName = [self getTextValue:@"Last Name" recordId:contactTextFieldId];
    
    if([firstName length] == 0 || [lastName length] == 0){
        UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter a first and last name for the contact." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [message show];
        return;
    }
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar disableAllTouch];
    
    if(self.contactRecord != nil){
        // if we are editing an existing contact
        if(![self.imageUrl  isEqual: @""] && self.profileImage != nil){
            [self putLocalImageOnServer:self.profileImage];
        }
        else {
            [self UpdateContactWithServer];
        }
    }
    else{
        // need to create the contact before creating addresses or adding
        // the contact to any groups
        [self addContactToServer];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) putValueInTextfield:(NSString*)value key:(NSString*)key record:(NSNumber*)record {
    if([value length] > 0){
        NSMutableDictionary* dict = [self.textFields objectForKey:record];
        ((UITextField*)[dict objectForKey:key]).text = value;
    }
}

-(void) addNewFieldClicked {
    // make room for a new view and insert it
    int height = 345; // approximate height of a new info field
    CGRect translation;
    UIButton* button;
    
    for(UIView* view in [self.contactEditScrollView subviews]){
        if([view isKindOfClass:[UIButton class]]){
            // find the button from the views
            if([((UIButton*) view).titleLabel.text isEqualToString:@"add new address"]){
                button = (UIButton*) view;
            }
        }
        
        if([view isKindOfClass:[ContactInfoView class]]){
            if(view.frame.size.height > height){
                // find the size of other contact info views
                height = view.frame.size.height;
            }
        }
    }
    
    int yToInsert = button.frame.origin.y;
    
    translation.origin.y = yToInsert + height + 30;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25f];
    
    // move the button down
    button.center = CGPointMake(self.contactEditScrollView.frame.size.width / 2.0f, translation.origin.y + (button.frame.size.height * 0.5));
    
    // make the view scroll move down too
    CGSize contentRect = self.contactEditScrollView.contentSize;
    contentRect.height = button.frame.origin.y + button.frame.size.height;
    self.contactEditScrollView.contentSize = contentRect;
    CGPoint bottomOffset = CGPointMake(0, translation.origin.y + button.frame.size.height - self.contactEditScrollView.frame.size.height);
    
    [self.contactEditScrollView setContentOffset:bottomOffset animated:YES];
    [UIView commitAnimations];
    
    // build new view
    ContactInfoView* contactInfoView = [[ContactInfoView alloc] initWithFrame:CGRectMake(0, yToInsert, self.contactEditScrollView.frame.size.width, 0)];
    ContactDetailRecord* record = [[ContactDetailRecord alloc] init];
    record.ContactId = nil;
    
    [self.addedContactInfo addObject:record];
    contactInfoView.record = record;
    
    [contactInfoView setNeedsDisplay];
    [self.contactEditScrollView addSubview:contactInfoView];
    [self.contactEditScrollView reloadInputViews];
}

- (void) changeImageClicked {
    ProfileImagePickerViewController* profileImagePickerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileImagePickerViewController"];
    
    // tell the contact list what image it is looking at
    profileImagePickerViewController.delegate = self;
    
    profileImagePickerViewController.record = self.contactRecord;
    [self.navigationController pushViewController:profileImagePickerViewController animated:YES];
}

- (void) buildContactTextFields: (int)recordId title:(NSString*)title names:(NSArray*)names y:(int)y {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithCapacity:[names count]+2];
    
    for(NSString* field in names){
        UITextField* textfield = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.05, y, self.view.frame.size.width * .9, 35)];
        [textfield setPlaceholder:field];
        [textfield setFont:[UIFont fontWithName:@"Helvetica Neue" size: 20.0]];
        textfield.backgroundColor = [UIColor whiteColor];
        
        textfield.layer.cornerRadius = 5;
        textfield.delegate = self;
        
        [self.contactEditScrollView addSubview:textfield];
        
        [dict setObject:textfield forKey:field];
        
        y += 40;
    }
    [self.textFields setObject:dict forKey:[NSNumber numberWithInt:recordId]];
}

// build ui programmatically
- (void) buildContactFields {
    
    NSNumber* contactTextfieldId = [NSNumber numberWithInt:-1]; // id for the contact fields that we know could never happen
    [self buildContactTextFields:(int)[contactTextfieldId integerValue] title:@"Contact Details" names:@[@"First Name", @"Last Name", @"Twitter", @"Skype", @"Notes"] y:30];
    
    // populate the contact fields
    if(self.contactRecord != nil){
        [self putValueInTextfield:self.contactRecord.FirstName key:@"First Name" record:contactTextfieldId];
        [self putValueInTextfield:self.contactRecord.LastName key:@"Last Name" record:contactTextfieldId];
        [self putValueInTextfield:self.contactRecord.Twitter key:@"Twitter" record:contactTextfieldId];
        [self putValueInTextfield:self.contactRecord.Skype key:@"Skype" record:contactTextfieldId];
        [self putValueInTextfield:self.contactRecord.Notes key:@"Notes" record:contactTextfieldId];
    }
    
    //UIButton* changeImageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //int y = CGRectGetMaxY(((UIView*)[self.contactEditScrollView.subviews lastObject]).frame);
    //changeImageButton.frame = CGRectMake(0, y + 10, self.view.frame.size.width, 40);
    
    //changeImageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    //[changeImageButton setTitle:@"change image" forState:UIControlStateNormal];
    //[changeImageButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size: 20.0]];
    //[changeImageButton setTitleColor:[UIColor colorWithRed:107/255.0f green:170/255.0f blue:178/255.0f alpha:1] forState:UIControlStateNormal];
    
    //[changeImageButton addTarget:self action:@selector(changeImageClicked) forControlEvents:UIControlEventTouchDown];
    
    //[changeImageButton setNeedsDisplay];
    
    //[self.contactEditScrollView addSubview:changeImageButton];
    
    // add all the contact info views
    if(self.contactRecord != nil){
        // if we are not creating a new contact
        for(ContactDetailRecord* record in self.contactDetails){
            int y = CGRectGetMaxY(((UIView*)[self.contactEditScrollView.subviews lastObject]).frame);
            ContactInfoView* contactInfoView = [[ContactInfoView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.00, y, self.contactEditScrollView.frame.size.width, 40)];
            
            contactInfoView.record = record;
            [contactInfoView updateFields];
            
            [contactInfoView reloadInputViews];
            [contactInfoView setNeedsDisplay];
            
            [self.contactEditScrollView addSubview:contactInfoView];
            [self.contactEditScrollView reloadInputViews];
        }
    }
    
    // create button to add a new field
    int y = CGRectGetMaxY(((UIView*)[self.contactEditScrollView.subviews lastObject]).frame);
    UIButton* addNewFieldButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    addNewFieldButton.frame=CGRectMake(0, y + 10, self.view.frame.size.width, 40);
    addNewFieldButton.backgroundColor = [UIColor colorWithRed:107/255.0f green:170/255.0f blue:178/255.0f alpha:1];
    
    addNewFieldButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    addNewFieldButton.titleLabel.font =[UIFont fontWithName:@"Helvetica Neue" size: 20.0];
    [addNewFieldButton setTitleColor:[UIColor colorWithRed:254/255.0f green:254/255.0f blue:254/255.0f alpha:1] forState:UIControlStateNormal];
    [addNewFieldButton setTitle:@"add new address" forState:UIControlStateNormal];
    
    [addNewFieldButton addTarget:self action:@selector(addNewFieldClicked) forControlEvents:UIControlEventTouchDown];
    
    [addNewFieldButton reloadInputViews];
    [addNewFieldButton setNeedsDisplay];
    
    [self.contactEditScrollView addSubview:addNewFieldButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSString*) getTextValue:(NSString*)name recordId:(NSNumber*)recordId {
    return ((UITextField*)([[self.textFields objectForKey:recordId] objectForKey:name])).text;
}

- (void) addContactToServer {
    // set up the contact name
    NSString* filename = @"";
    if([self.imageUrl length] > 0){
        filename = [NSString stringWithFormat:@"%@.jpg", self.imageUrl];
    }
    
    // id given to object holding contact info
    NSNumber* contactTextfieldId = [NSNumber numberWithInt:-1];
    
    // build request body
    NSDictionary *requestBody = @{@"first_name": [self getTextValue:@"First Name" recordId:contactTextfieldId],
                                  @"last_name":[self getTextValue:@"Last Name" recordId:contactTextfieldId],
                                  @"image_url":filename,
                                  @"notes":[self getTextValue:@"Notes" recordId:contactTextfieldId],
                                  @"twitter":[self getTextValue:@"Twitter" recordId:contactTextfieldId],
                                  @"skype":[self getTextValue:@"Skype" recordId:contactTextfieldId]};
    
    
    [[RESTEngine sharedEngine] addContactToServerWithDetails:requestBody success:^(NSDictionary *response) {
        
        for (NSDictionary *recordInfo in response[@"resource"]) {
            [self.contactRecord setId:[recordInfo objectForKey:@"id"]];
        }
        
        if(![self.imageUrl  isEqual: @""] && self.profileImage != nil){
            [self createProfileImageFolderOnServer];
        } else {
            [self addContactGroupRelationToServer];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"Error adding new contact to server: %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) addContactGroupRelationToServer {
    [[RESTEngine sharedEngine] addContactGroupRelationToServerWithContactId:self.contactRecord.Id groupId:self.contactGroupId success:^(NSDictionary *response) {
        
        [self addContactInfoToServer];
        
    } failure:^(NSError *error) {
        NSLog(@"Error adding contact group relation to server from contact edit: %@", error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}


- (void) addContactInfoToServer{
    // build request body
    NSMutableArray* records = [[NSMutableArray alloc] init];
    /*
     * Format is:
     *  {
     *      "resource":[
     *          {...},
     *          {...}
     *      ]
     *  }
     *
     */
    
    // fill body with contact details
    for(UIView* view in [self.contactEditScrollView subviews]){
        if([view isKindOfClass:[ContactInfoView class]]){
            ContactInfoView* contactInfoView = (ContactInfoView*) view;
            if(contactInfoView.record.Id == nil){
                contactInfoView.record.Id = [NSNumber numberWithInt:0];
                contactInfoView.record.ContactId = self.contactRecord.Id;
                [contactInfoView updateRecord];
                [records addObject: [contactInfoView buildToDictionary]];
                [self.contactDetails addObject:contactInfoView.record];
            }
        }
    }
    
    // make sure we don't try to put contact info up on the server if we don't have any
    // need to check down here because of the way they are set up
    if([records count] == 0){
        dispatch_async(dispatch_get_main_queue(), ^ (void){
            [self waitToGoBack];
        });
        return;
        
    }
    
    [[RESTEngine sharedEngine] addContactInfoToServer:records success:^(NSDictionary *response) {
        // head back up only once all the data has been loaded
        dispatch_async(dispatch_get_main_queue(), ^ (void){
            [self waitToGoBack];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error putting contact details back up on server: %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) createProfileImageFolderOnServer{
    NSString* fileName = @"UserFile1.jpg"; // default file name
    if([self.imageUrl length] > 0){
        fileName = [NSString stringWithFormat:@"%@.jpg", self.imageUrl];
    }
    
    [[RESTEngine sharedEngine] addContactImageWithContactId:self.contactRecord.Id image:self.profileImage imageName:fileName success:^(NSDictionary *response) {
        
        [self addContactGroupRelationToServer];
        
    } failure:^(NSError *error) {
        NSLog(@"Error creating new profile image folder on server: %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            // need to create a new folder for the user's images
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) putLocalImageOnServer:(UIImage*) image {
    NSString* fileName = @"UserFile1.jpg"; // default file name
    if([self.imageUrl length] > 0){
        fileName = [NSString stringWithFormat:@"%@.jpg", self.imageUrl];
    }
    
    [[RESTEngine sharedEngine] putImageToFolderWithPath:self.contactRecord.Id.stringValue image:image fileName:fileName success:^(NSDictionary *response) {
        
        self.contactRecord.ImageUrl = fileName;
        [self UpdateContactWithServer];
        
    } failure:^(NSError *error) {
        NSLog(@"Error putting profile image on server: %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) UpdateContactWithServer {
    // -1 is just a tag given to the object that holds the contact info
    NSNumber* contactTextfieldId = [NSNumber numberWithInt:-1];
    
    NSDictionary *requestBody = @{@"first_name": [self getTextValue:@"First Name" recordId:contactTextfieldId],
                                  @"last_name":[self getTextValue:@"Last Name" recordId:contactTextfieldId],
                                  //@"image_url":self.contactRecord.ImageUrl,
                                  @"notes":[self getTextValue:@"Notes" recordId:contactTextfieldId],
                                  @"twitter":[self getTextValue:@"Twitter" recordId:contactTextfieldId],
                                  @"skype":[self getTextValue:@"Skype" recordId:contactTextfieldId]};
    
    // update the contact
    self.contactRecord.FirstName = [requestBody objectForKey:@"first_name"];
    self.contactRecord.LastName = [requestBody objectForKey:@"last_name"];
    self.contactRecord.Notes = [requestBody objectForKey:@"notes"];
    self.contactRecord.Twitter = [requestBody objectForKey:@"twitter"];
    self.contactRecord.Skype = [requestBody objectForKey:@"skype"];
    
    [[RESTEngine sharedEngine] updateContactWithContactId:self.contactRecord.Id contactDetails:requestBody success:^(NSDictionary *response) {
        
        [self UpdateContactInfoWithServer];
        
    } failure:^(NSError *error) {
        NSLog(@"Error updating contact info with server: %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) UpdateContactInfoWithServer{
    // build request body
    NSMutableArray* records = [[NSMutableArray alloc] init];
    for(UIView* view in [self.contactEditScrollView subviews]){
        if([view isKindOfClass:[ContactInfoView class]]){
            ContactInfoView* contactInfoView = (ContactInfoView*) view;
            if(contactInfoView.record.ContactId != nil){
                [contactInfoView updateRecord];
                [records addObject: [contactInfoView buildToDictionary]];
            }
        }
    }
    if([records count] == 0){
        // if we have no records to update, check if we have any records to add
        [self addContactInfoToServer];
        return;
    }
    
    [[RESTEngine sharedEngine] updateContactInfo:records success:^(NSDictionary *response) {
        [self addContactInfoToServer];
    } failure:^(NSError *error) {
        NSLog(@"Error updating contact details on server: %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) waitToGoBack{
    if(self.contactViewController == nil){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    dispatch_async(dispatch_queue_create("contactListShowQueue", NULL), ^{
        self.contactViewController.didPrecall = YES;
        [self.contactViewController prefetch];

        [self.contactViewController waitToReady];
        
        self.contactViewController = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}

@end
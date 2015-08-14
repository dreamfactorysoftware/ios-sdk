#import <Foundation/Foundation.h>
#import "GroupAddViewController.h"

#import "NIKApiInvoker.h"
#import "MasterViewController.h"
#import "ContactRecord.h"
#import "AddressBookRecord.h"

#import "AppDelegate.h"

static NSString *baseUrl=@"";

@interface GroupAddViewController ()

@property(retain, nonatomic) UISearchBar* searchBar;

// if there is a search going on
@property(nonatomic) BOOL isSearch;

// holds contents of a search
@property (nonatomic, retain) NSMutableArray *displayContentArray;

// array of contacts selected to be in the group
@property(nonatomic, retain) NSMutableArray* selectedRows;

// contacts broken into groups by first letter of last name
@property(nonatomic, retain) NSMutableDictionary* contactSectionsDictionary;

// header letters
@property(nonatomic, retain) NSArray* alphabetArray;

@property(nonatomic, retain) NSCondition* waitLock;
@property(nonatomic) BOOL waitReady;

@end

@implementation GroupAddViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    // make sure we have the base URL for our DSP
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    baseUrl=baseDSPUrl;
    
    [self.groupNameTextField setValue:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    // set up the search bar programmatically
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 118, self.view.frame.size.width, 44)];
    self.searchBar.delegate = self;
    self.isSearch = NO;
    [self.view addSubview:self.searchBar];
    [self.searchBar setNeedsDisplay];
    [self.view reloadInputViews];
    
   if(self.groupRecord != nil) {
        // if we are editing a group, get any existing group members
        self.groupNameTextField.text = self.groupRecord.Name;
    }
    
    // remove header from table view
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar showDone];
    [navBar.doneButton addTarget:self action:@selector(saveButtonHit) forControlEvents:UIControlEventTouchDown];
    [navBar enableAllTouch];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.doneButton removeTarget:self action:@selector(saveButtonHit) forControlEvents:UIControlEventTouchDown];
    [navBar disableAllTouch];
}

- (void) prefetch {
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    baseUrl=baseDSPUrl;
    
    self.displayContentArray = [[NSMutableArray alloc] init];
    self.contactsAlreadyInGroupContentsArray = [[NSMutableArray alloc]init];
    self.selectedRows = [[NSMutableArray alloc] init];
    
    // for sectioned alphabetized list
    self.alphabetArray = [[NSMutableArray alloc] init];
    self.contactSectionsDictionary = [[NSMutableDictionary alloc] init];
    
    self.waitLock= [[NSCondition alloc] init];
    
    [self.waitLock lock];
    self.waitReady = NO;
    
    dispatch_async(dispatch_queue_create("contactListQueue", NULL), ^{
        [self getContactListFromServer];
        
        if(self.groupRecord != nil) {
            // if we are editing a group, get any existing group members
            [self getContactGroupRelationListFromServer];
        }
    });
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar disableAllTouch];
    
}

- (void) waitToReady {
    dispatch_sync(dispatch_queue_create("groupAddWaitQueue", NULL), ^{
        [self.waitLock lock];
        
        while (self.waitReady == NO) {
            [self.waitLock wait];
        }
        [self.waitLock unlock];
        [self.waitLock signal];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) saveButtonHit{
    if([self.groupNameTextField.text length] == 0){
        // This has a retain cycle with itself, not worth effort to fix
        UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter a group name." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [message show];
        return;
    }
    if(self.groupRecord != nil){
        // if we are editing a group, head to update
        [self buildUpdateRequest];
    }
    else{
        [self addNewGroupToServer];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.displayContentArray removeAllObjects];
    
    if([searchText length] == 0){
        // done with searching, show all the data
        self.isSearch = NO;;
        [self.groupAddTableView reloadData];
        return;
    }
    
    self.isSearch = YES;
    NSString* firstLetter = [[searchText substringToIndex:1] uppercaseString];
    NSArray* arrayAtLetter = [self.contactSectionsDictionary objectForKey:firstLetter];
    for(ContactRecord* record in arrayAtLetter){
        if([record.LastName length] < [searchText length]){
            continue;
        }
        NSString* lastNameSubstring = [record.LastName substringToIndex:[searchText length]];
        if([lastNameSubstring caseInsensitiveCompare:searchText] == 0){
            [self.displayContentArray addObject:record];
        }
    }
    [self.groupAddTableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(self.isSearch){
        NSString* searchText = self.searchBar.text;
        if([searchText length] > 0){
            return [[searchText substringToIndex:1] uppercaseString];
        }
    }
    return [self.alphabetArray objectAtIndex:section];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.isSearch){
        return 1;
    }
    return [self.alphabetArray count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.isSearch){
        return [self.displayContentArray count];
    }
    
    NSString* sectionKey = [self.alphabetArray objectAtIndex:section];
    NSArray* sectionContacts = [self.contactSectionsDictionary objectForKey:sectionKey];
    return [sectionContacts count];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // color the section headers
    view.tintColor =[UIColor colorWithRed:210/255.0f green:225/255.0f blue:239/255.0f alpha:1.0f];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // build cell for given index path
    static NSString *cellIdentifier = @"addGroupContactTableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ContactRecord* record = nil;
    
    if(self.isSearch){
        record = [self.displayContentArray objectAtIndex:indexPath.row];
    }
    else{
        NSString* sectionLetter = [self.alphabetArray objectAtIndex:indexPath.section];
        NSArray* sectionContacts = [self.contactSectionsDictionary objectForKey:sectionLetter];
        record = [sectionContacts objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",record.FirstName, record.LastName];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 17.0];
    
    // if the contact is selected to be in the group, mark it
    if([self.selectedRows containsObject:(record.Id)]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setBackgroundColor:[UIColor colorWithRed:254/255.0f green:254/255.0f blue:255/255.0f alpha:1.0f]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    ContactRecord* contact = nil;
    if(self.isSearch){
        contact = [self.displayContentArray objectAtIndex:indexPath.row];
    }
    else{
        NSString* sectionKey = [self.alphabetArray objectAtIndex:indexPath.section];
        NSArray* sectionContacts = [self.contactSectionsDictionary objectForKey:sectionKey];
        contact = [sectionContacts objectAtIndex:indexPath.row];
    }
    
    if(cell.accessoryType == UITableViewCellAccessoryNone ){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedRows addObject:contact.Id];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedRows removeObject:contact.Id];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) buildUpdateRequest {
    // if a contact is selected and was already in the group, do nothing
    // if a contact is selected and was not in the group, add it to the group
    // if a contact is not selected and was in the group, remove it from the group
    
    // removing an object mid loop messes with for-each loop
    NSMutableArray* quoToRemove = [[NSMutableArray alloc] init];
    for(NSNumber* contactId in self.selectedRows){
        for(int i = 0; i < [self.contactsAlreadyInGroupContentsArray count]; i++){
            if(contactId == [self.contactsAlreadyInGroupContentsArray objectAtIndex:i]){
                [quoToRemove addObject:contactId];
                [self.contactsAlreadyInGroupContentsArray removeObjectAtIndex:i];
                break;
            }
        }
    }
    for(NSNumber* contactId in quoToRemove){
        [self.selectedRows removeObject:contactId];
    }
    
    // remove all the contacts that were in the groups and are not now
    // remove contacts from group -> add contacts to group
    [self UpdateGroupNameWithServer];
}

- (NSString*) removeNull:(id) input{
    if(input == [NSNull null]){
        return @"";
    }
    return (NSString*) input;
}

- (void) getContactListFromServer{
    // get all the contacts in the database
    
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        
        // get shared instance
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact"; // table name
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        // only need to get the contactId and full contact name
        // set the fields param to give us just the fields we need
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        queryParams[@"fields"] = @"id,first_name,last_name";
        
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
               NSLog(@"Error getting all the contacts data: %@",error);
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.navigationController popToRootViewControllerAnimated:YES];
               });
           }
           else{
               // put the contact ids into an array
               for (NSDictionary *recordInfo in [responseDict objectForKey:@"record"]) {
                   ContactRecord* newRecord = [[ContactRecord alloc] init];
                   [newRecord setFirstName:[self removeNull:[recordInfo objectForKey:@"first_name"]]];
                   [newRecord setLastName:[self removeNull:[recordInfo objectForKey:@"last_name"]]];
                   [newRecord setId:[recordInfo objectForKey:@"id"]];
                   
                   if([newRecord.LastName length] > 0){
                       BOOL found = NO;
                       for(NSString* key in [self.contactSectionsDictionary allKeys]){
                           // want to group by last name regardless of case
                           if([key caseInsensitiveCompare:[newRecord.LastName substringToIndex:1] ] == 0 ){
                               NSMutableArray* section = [self.contactSectionsDictionary objectForKey:key];
                               [section addObject:newRecord];
                               found = YES;
                               break;
                           }
                       }
                       if(!found){
                           // contact doesn't fit in any of the other buckets, make a new one
                           NSString* key = [[newRecord.LastName substringToIndex:1] uppercaseString];
                           self.contactSectionsDictionary[key] = [[NSMutableArray alloc] initWithObjects:newRecord, nil];
                       }
                   }
               }
               
               NSMutableDictionary* tmp = [[NSMutableDictionary alloc] init];
               
               // sort the sections alphabetically by last name, first name
               for(NSString* key in [self.contactSectionsDictionary allKeys]){
                   NSMutableArray* unsorted = [self.contactSectionsDictionary objectForKey:key];
                   NSArray* sorted = [unsorted sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                       ContactRecord* one = (ContactRecord*) obj1;
                       ContactRecord* two = (ContactRecord*) obj2;
                       if([[one LastName] caseInsensitiveCompare:[two LastName]] == 0){
                           NSString* first = [one FirstName];
                           NSString* second = [two FirstName];
                           return [first compare:second];
                       }
                       NSString* first = [(ContactRecord*)obj1 LastName];
                       NSString* second = [(ContactRecord*)obj2 LastName];
                       return [first compare:second];
                   }];
                   tmp[key] = [sorted mutableCopy];
               }
               self.contactSectionsDictionary = tmp;
               
               self.alphabetArray = [[self.contactSectionsDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
               
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   self.waitReady = YES;
                   [self.waitLock unlock];
                   [self.waitLock signal];
                   
                   [self.groupAddTableView reloadData];
                   [self.groupAddTableView setNeedsDisplay];
               });
           }
       }];
    }
}

- (void) addNewGroupToServer {
    // created a new group, add it to the server
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact_group"; // rest path
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        
        NSString* contentType = @"application/json";
        // build request body, just need to post the name
        NSDictionary *requestBody = @{@"name": self.groupNameTextField.text};
        
        // the DB success response will contain the id of the new record
        [_api restPath:restApiPath
                method:@"POST"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
           if (error) {
               NSLog(@"Error adding group to server: %@",error);
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.navigationController popToRootViewControllerAnimated:YES];
               });
           }
           else{
               // get the id of the new group, then add the relations
               [self addGroupContactRelations:[responseDict objectForKey:@"id"]];
           }
       }];
    }
    
}

- (void) addGroupContactRelations:(NSNumber*) groupId {
    // create any new contact-group relations
    
    // make sure there are contacts to add
    if([self.selectedRows count] == 0){
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.navigationController popViewControllerAnimated:YES];
        });
        return;
    }
    
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact_group_relationship"; // rest path
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        NSMutableArray* records = [[NSMutableArray alloc] init];
        
        for(NSNumber* contactId in self.selectedRows){
            [records addObject:@{@"contact_group_id":groupId,
                                 @"contact_id":contactId
                                 }];
        }
        
        
        NSString* contentType = @"application/json";
        // build request body
        /*
         *  structure of request is:
         *  {
         *      "records":[
         *          {
         *             "contactGroupId":id,
         *             "contactId":id"
         *          },
         *          {...}
         *      ]
         *  }
         */
        NSDictionary *requestBody = @{@"record": records};
        
        [_api restPath:restApiPath
                method:@"POST"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
           if (error) {
               NSLog(@"Error adding contact group relation to server from group add: %@",error);
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.navigationController popToRootViewControllerAnimated:YES];
               });
               
           }else{
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   // go to the previous screen
                   [self.navigationController popViewControllerAnimated:YES];
               });
           }
       }];
    }
}

- (void) UpdateGroupNameWithServer{
    // Update a changed group name with the server
    if([self.groupNameTextField isEqual:self.groupRecord.Name]){
        [self removeContactGroupRelationsFromServer];
        return;
    }
    
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db";// your service name here
        NSString *tableName = @"contact_group";
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        // set the id of the contact we are looking at
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        queryParams[@"ids"] = [self.groupRecord.Id stringValue];
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        NSString* contentType = @"application/json";
        
        NSDictionary *requestBody = @{@"name":self.groupNameTextField.text};
        
        // update the contact
        self.groupRecord.Name = self.groupNameTextField.text;
        
        [_api restPath:restApiPath
                method:@"PATCH"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType completionBlock:^(NSDictionary *responseDict, NSError *error) {
               if (error) {
                   NSLog(@"Error updating contact info with server: %@",error);
                   dispatch_async(dispatch_get_main_queue(),^ (void){
                       [self.navigationController popToRootViewControllerAnimated:YES];
                   });
               }
               else{
                   [self removeContactGroupRelationsFromServer];
               }
           }];
    }
}


- (void) getContactGroupRelationListFromServer {
    // get the list of contacts already in the group
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact_group_relationship"; // rest path
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        // create filter to get only the contact in the group
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        NSString *filter = [NSString stringWithFormat:@"contact_group_id=%@", self.groupRecord.Id];
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
           contentType:contentType completionBlock:^(NSDictionary *responseDict, NSError *error) {
               if (error) {
                   NSLog(@"Error getting contact group relations list: %@",error);
                   dispatch_async(dispatch_get_main_queue(),^ (void){
                       [self.navigationController popToRootViewControllerAnimated:YES];
                   });
                   
               }else{
                   [self.contactsAlreadyInGroupContentsArray removeAllObjects];
                   for (NSDictionary *recordInfo in [responseDict objectForKey:@"record"]) {
                       [self.contactsAlreadyInGroupContentsArray addObject: [recordInfo objectForKey:@"contact_id"]];
                       [self.selectedRows addObject:[recordInfo objectForKey:@"contact_id"]];
                   }
                   
                   dispatch_async(dispatch_get_main_queue(),^ (void){
                       [self.groupAddTableView reloadData];
                       [self.groupAddTableView setNeedsDisplay];
                   });
               }
           }];
    }
}

- (void) removeContactGroupRelationsFromServer{
    
    // make sure we should be removing contacts
    if(self.groupRecord == nil || [self.contactsAlreadyInGroupContentsArray count] == 0){
        NSLog(@"\nDidn't remove any contacts, adding added contacts\n");
        [self addGroupContactRelations:self.groupRecord.Id];
        return;
    }
    
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact_group_relationship"; // rest path
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        // do not know the ID of the record to remove
        // one value for groupId, but many values for contactId
        // instead of making a long SQL query, change what we use as identifiers
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        queryParams[@"id_field"] = @"contact_group_id,contact_id";
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        NSString* contentType = @"application/json";
        
        NSMutableArray* requestRecordsArray = [[NSMutableArray alloc] init];
        /*
         * Form of request is:
         *  {
         *      "record":[
         *          {
         *              "contactGroupId":id,
         *              "contactId":id
         *          },
         *          {...}
         *      ]
         *  }
         */
        
        for(NSNumber* recordId in self.contactsAlreadyInGroupContentsArray){
            [requestRecordsArray addObject:@{@"contact_group_id":self.groupRecord.Id, @"contact_id":recordId}];
        }
        NSDictionary* requestBody = @{@"record":requestRecordsArray};
        
        [_api restPath:restApiPath
                method:@"DELETE"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
           
           NSLog(@"Error removing contact group relation: %@",error);
           
           // If we got an error, just keep trucking along
           // because we want to make sure the new relations get added
           [self addGroupContactRelations:self.groupRecord.Id];
       }];
    }
}
@end
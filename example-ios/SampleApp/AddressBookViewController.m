#import <Foundation/Foundation.h>

#import "AddressBookViewController.h"
#import "ContactListViewController.h"
#import "MasterViewController.h"
#import "AddressBookRecord.h"
#import "GroupAddViewController.h"
#import "NIKApiInvoker.h"
#import "AppDelegate.h"


@interface AddressBookViewController ()

// list of groups
@property (nonatomic, retain) NSMutableArray *addressBookContentArray;

// for prefetching data
@property (nonatomic, retain) ContactListViewController* contactListViewController;
@end

@implementation AddressBookViewController
static NSString *baseUrl=@"";

- (void) viewDidLoad{
    [super viewDidLoad];
    
    // get the base URL (<url to DSP>/rest)
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    baseUrl=baseDSPUrl;
    
    self.addressBookContentArray = [[NSMutableArray alloc] init];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.addButton removeTarget:self action:@selector(hitAddGroupButton) forControlEvents:UIControlEventTouchDown];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.addButton addTarget:self action:@selector(hitAddGroupButton) forControlEvents:UIControlEventTouchDown];
    [navBar showAdd];
    [navBar showBackButton:YES];
    [navBar enableAllTouch];
    
    // refresh the list of groups when the view is coming back up
    [self getAddressBookContentFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) hitAddGroupButton {
    [self showGroupAddViewController];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // allow swipe to delete
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        GroupRecord* record = [self.addressBookContentArray objectAtIndex:indexPath.row];
        
        // can not delete group until all references to it are removed
        // remove relations -> remove group
        // pass record ID so it knows what group we are removing
        [self removeContactGroupRelationWithGroupId:record.Id];
        
        [self.addressBookContentArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.addressBookContentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"addressBookTableViewCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    GroupRecord* record = [self.addressBookContentArray objectAtIndex:indexPath.row];
    cell.textLabel.text = record.Name;
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 18.0];
    [cell setBackgroundColor:[UIColor colorWithRed:254/255.0f green:254/255.0f blue:254/255.0f alpha:1.0f]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    // fetch data at start of potential press
    GroupRecord* record = [self.addressBookContentArray objectAtIndex:indexPath.row];
    self.contactListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactListViewController"];
    self.contactListViewController.groupRecord = record;
    [self.contactListViewController prefetch];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showContactListViewController];
}

- (void) getAddressBookContentFromServer{
    // get all the groups
    
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact_groups";
        
        NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",baseUrl,serviceName, tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        // passing no query params will get all the records from a table
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        
        // header has session id and application name to validate access
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
           NSLog(@"Error getting address book data: %@",error);
           
           if (error) {
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.navigationController popToRootViewControllerAnimated:YES];
               });
           }
           else{
               [self.addressBookContentArray removeAllObjects];
               
               for (NSDictionary *recordInfo in [responseDict objectForKey:@"record"]) {
                   GroupRecord *newRecord=[[GroupRecord alloc]init];
                   [newRecord setId:[recordInfo objectForKey:@"contactGroupId"]];
                   [newRecord setName:[recordInfo objectForKey:@"groupName"]];
                   [self.addressBookContentArray addObject:newRecord];
               }
               
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.addressBookTableView reloadData];
                   [self.addressBookTableView setNeedsDisplay];
               });
           }
       }];
    }
}

- (void) removeContactGroupRelationWithGroupId:(NSNumber*) groupId{
    // remove all contact-group relations for the group being deleted
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact_relationships";
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        // create filter to select all contactrelationships records that
        // reference the group being deleted
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        NSString *filter = [NSString stringWithFormat:@"contactGroupId=%@", [groupId stringValue]];
        queryParams[@"filter"] = filter;
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        NSString* contentType = @"application/json";
        id requestBody = nil;
        
        [_api restPath:restApiPath
                method:@"DELETE"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
               
               NSLog(@"Error removing contact group relation: %@",error);
               
               if (error) {
                   dispatch_async(dispatch_get_main_queue(),^ (void){
                       [self.navigationController popToRootViewControllerAnimated:YES];
                   });
               }
               else {
                   // once the references to the group are removed, can remove group record
                   [self removeGroupFromServer:groupId];
               }
           }];
    }
}

- (void) removeGroupFromServer:(NSNumber*) groupId{
    
    // Get the relation all at once
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"db"; // your service name here
        NSString *tableName = @"contact_groups";
        
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/%@/%@",baseUrl,serviceName,tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        // delete the record by the record ID
        // form is "ids":"1,2,3"
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        queryParams[@"ids"] = [groupId stringValue];
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        NSString* contentType = @"application/json";
        id requestBody = nil;
        
        [_api restPath:restApiPath
                method:@"DELETE"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
           
           NSLog(@"Error deleting group: %@",error);
           
           if (error) {
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.navigationController popToRootViewControllerAnimated:YES];
               });
           }
       }];
    }
}

- (void) showContactListViewController{
    dispatch_async(dispatch_queue_create("addressBookQueue", NULL), ^{
        // already fetching so just wait until the data gets back
        [self.contactListViewController waitToReady];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:self.contactListViewController animated:YES];

        });
    });
}

- (void) showGroupAddViewController{
    GroupAddViewController* groupAddViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GroupAddViewController"];
    // tell the viewController we are creating a new group
    groupAddViewController.groupRecord = nil;
    [groupAddViewController prefetch];
    dispatch_async(dispatch_queue_create("contactListShowQueue", NULL), ^{
        
        [groupAddViewController waitToReady];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:groupAddViewController animated:YES];
            
        });
    });
}

@end
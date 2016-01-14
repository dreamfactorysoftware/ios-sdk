#import <Foundation/Foundation.h>

#import "AddressBookViewController.h"
#import "ContactListViewController.h"
#import "AddressBookRecord.h"
#import "GroupAddViewController.h"
#import "RESTEngine.h"
#import "AppDelegate.h"


@interface AddressBookViewController ()

// list of groups
@property (nonatomic, retain) NSMutableArray *addressBookContentArray;

// for prefetching data
@property (nonatomic, retain) ContactListViewController* contactListViewController;
@end

@implementation AddressBookViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
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
        [self removeGroupFromServer:record.Id];
        
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
    
    [[RESTEngine sharedEngine] getAddressBookContentFromServerWithSuccess:^(NSDictionary *response) {
        
        [self.addressBookContentArray removeAllObjects];
        
        for (NSDictionary *recordInfo in response [@"resource"]) {
            GroupRecord *newRecord=[[GroupRecord alloc]init];
            [newRecord setId:[recordInfo objectForKey:@"id"]];
            [newRecord setName:[recordInfo objectForKey:@"name"]];
            [self.addressBookContentArray addObject:newRecord];
        }
        
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.addressBookTableView reloadData];
            [self.addressBookTableView setNeedsDisplay];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error getting address book data: %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) removeGroupFromServer:(NSNumber*) groupId{
    
   [[RESTEngine sharedEngine] removeGroupFromServerWithGroupId:groupId success:nil failure:^(NSError *error) {
       NSLog(@"Error deleting group: %@",error);
       dispatch_async(dispatch_get_main_queue(),^ (void){
           [self.navigationController popToRootViewControllerAnimated:YES];
       });
   }];
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
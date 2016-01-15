#import <Foundation/Foundation.h>

#import "ContactListViewController.h"
#import "ContactEditViewController.h"
#import "AddressBookRecord.h"
#import "ContactDetailRecord.h"
#import "ContactRecord.h"
#import "ContactViewController.h"
#import "GroupAddViewController.h"
#import "RESTEngine.h"
#import "AppDelegate.h"

@interface ContactListViewController ()

// results to be displayed during search
@property (nonatomic, retain) NSMutableArray *displayContentArray;

@property(retain, nonatomic) UISearchBar* searchBar;

// if there is a search going on
@property(nonatomic) BOOL isSearch;

// contacts broken into groups by first letter of last name
@property(nonatomic, retain) NSMutableDictionary* contactSectionsDictionary;

// list of letters
// needs to be mutable because we can delete items
@property(nonatomic, retain) NSMutableArray* alphabetArray;

// for prefetching data
@property(nonatomic, retain) ContactViewController* contactViewController;
@property(nonatomic) BOOL goingToShowContactViewController;
@property(nonatomic) BOOL didPrefetch;
@property(nonatomic, retain) NSCondition* viewLock;
@property(nonatomic) BOOL viewReady;

@property(nonatomic, retain) dispatch_queue_t queue;


@end

@implementation ContactListViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.displayContentArray = [[NSMutableArray alloc] init];
    
    // build search bar programmatically
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    self.isSearch = NO;
    
    self.contactListTableView.allowsMultipleSelectionDuringEditing = NO;
    
    [self.contactListTableView setBackgroundColor:[UIColor colorWithRed:254/255.0f green:254/255.0f blue:255/255.0f alpha:1.0f]];
    [self.view setBackgroundColor:[UIColor colorWithRed:254/255.0f green:254/255.0f blue:255/255.0f alpha:1.0f]];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.addButton removeTarget:self action:@selector(hitAddContactButton) forControlEvents:UIControlEventTouchDown];
    [navBar.editButton removeTarget:self action:@selector(hitGroupEditButton) forControlEvents:UIControlEventTouchDown];
    
    if(self.goingToShowContactViewController == NO && self.contactViewController){
        [self.contactViewController canclePrefetch];
        self.contactViewController = nil;
    }
}

- (void) viewWillAppear:(BOOL)animated{
    if(!self.didPrefetch){
        dispatch_async(self.queue, ^{
            [self getContactsListFromServerWithRelation];
        });
    }
    [super viewWillAppear:animated];
    self.contactViewController = nil;
    self.goingToShowContactViewController = NO;
    // reload the view
    self.isSearch = NO;
    self.searchBar.text = @"";
    self.didPrefetch = NO;
    
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.addButton addTarget:self action:@selector(hitAddContactButton) forControlEvents:UIControlEventTouchDown];
    [navBar.editButton addTarget:self action:@selector(hitGroupEditButton) forControlEvents:UIControlEventTouchDown];
    [navBar showEditAndAdd];
    [navBar enableAllTouch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) prefetch {
    if(self.viewLock == nil){
        self.viewLock = [[NSCondition alloc] init];
    }
    [self.viewLock lock];
    self.viewReady = NO;
    self.didPrefetch = YES;

    if(self.queue == nil){
        self.queue = dispatch_queue_create("contactListQueue", NULL);
    }
    dispatch_async(self.queue, ^{
        [self getContactsListFromServerWithRelation];
    });
}

- (void) waitToReady{
    [self.viewLock lock];
    while(self.viewReady == NO){
        [self.viewLock wait];
    }
    
    [self.viewLock unlock];
}

- (void) hitAddContactButton {
    [self showContactEditViewController];
}

- (void) hitGroupEditButton {
    [self showGroupEditViewController];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UIColor* tintColor = [UIColor colorWithRed:210/255.0f green:225/255.0f blue:239/255.0f alpha:1.0f];
    view.tintColor = tintColor;    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"contactListTableViewCell";
    
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
    
    [cell setBackgroundColor:[UIColor colorWithRed:254/255.0f green:254/255.0f blue:255/255.0f alpha:1.0f]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", record.FirstName, record.LastName];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 17.0];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactRecord* record = nil;
    
    if(self.isSearch){
        record = [self.displayContentArray objectAtIndex:indexPath.row];
    }
    else{
        NSString* sectionLetter = [self.alphabetArray objectAtIndex:indexPath.section];
        NSArray* sectionContacts = [self.contactSectionsDictionary objectForKey:sectionLetter];
        record = [sectionContacts objectAtIndex:indexPath.row];
    }
    if(self.contactViewController){
        [self.contactViewController canclePrefetch];
    }
    self.contactViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactViewController"];
    self.contactViewController.contactRecord = record;
    

    [self.contactViewController prefetch];
    self.contactViewController.didPrecall = YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactRecord* record = nil;
    
    if(self.isSearch){
        record = [self.displayContentArray objectAtIndex:indexPath.row];
    }
    else{
        NSString* sectionLetter = [self.alphabetArray objectAtIndex:indexPath.section];
        NSArray* sectionContacts = [self.contactSectionsDictionary objectForKey:sectionLetter];
        record = [sectionContacts objectAtIndex:indexPath.row];
    }
    
    // disable touch
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar disableAllTouch];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showContactViewController:record];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(self.isSearch){
            ContactRecord* record = [self.displayContentArray objectAtIndex:indexPath.row];
            NSString* index = [[record.LastName substringToIndex:1] uppercaseString];
            NSMutableArray* displayArray = [self.contactSectionsDictionary objectForKey:index];
            [displayArray removeObject:record];
            if([displayArray count] == 0){
                // remove tile header if there are no more tiles in that group
                [self.alphabetArray removeObject:index];
            }
            // need to delete everything with references to contact before
            // removing contact its self
            [self removeContactWithContactId:record.Id];
            
            [self.displayContentArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else{
            NSString* sectionLetter = [self.alphabetArray objectAtIndex:indexPath.section];
            NSMutableArray* sectionContacts = [self.contactSectionsDictionary objectForKey:sectionLetter];
            ContactRecord* record = [sectionContacts objectAtIndex:indexPath.row];
            [sectionContacts removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            if( [sectionContacts count] == 0){
                [self.alphabetArray removeObjectAtIndex:indexPath.section];
            }
            
            // need to delete everything with references to contact before we can
            // delete the contact
            // delete contact relation -> delete contact info -> delete profile images ->
            // delete contact
            [self removeContactWithContactId:record.Id];
        }
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.displayContentArray removeAllObjects];
    
    if([searchText length] == 0){
        self.isSearch = NO;
        [self.tableView reloadData];
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
    
    [self.tableView reloadData];
}

- (NSString*) removeNull:(id) input{
    if(input == [NSNull null]){
        return @"";
    }
    return (NSString*) input;
}

- (void) getContactsListFromServerWithRelation{
    [[RESTEngine sharedEngine] getContactsListFromServerWithRelationWithGroupId:self.groupRecord.Id success:^(NSDictionary *response) {
        self.alphabetArray = [[NSMutableArray alloc] init];
        self.contactSectionsDictionary = [[NSMutableDictionary alloc] init];
        
        [self.displayContentArray removeAllObjects];
        [self.contactSectionsDictionary removeAllObjects];
        [self.alphabetArray removeAllObjects];
        
        // handle repeat contact-group relationships
        NSMutableArray* tmpContactIdList = [[NSMutableArray alloc] init];
        
        /*
         *  Structure of reply is:
         *  {
         *      record:[
         *          {
         *              <relation info>,
         *              contact_by_contact_id:{
         *                  <contact info>
         *              }
         *          },
         *          ...
         *      ]
         *  }
         */
        for (NSDictionary *relationRecord in response [@"resource"]) {
            @autoreleasepool {
                NSDictionary* recordInfo = [relationRecord objectForKey:@"contact_by_contact_id"];
                NSNumber* contactId = [recordInfo objectForKey:@"id"];
                if([tmpContactIdList containsObject:contactId]){
                    // a different record already related the group-contact pair
                    continue;
                }
                [tmpContactIdList addObject:contactId];
                
                ContactRecord* newRecord = [[ContactRecord alloc] init];
                [newRecord setFirstName:[self removeNull:[recordInfo objectForKey:@"first_name"]]];
                [newRecord setLastName:[self removeNull:[recordInfo objectForKey:@"last_name"]]];
                [newRecord setId:[recordInfo objectForKey:@"id"]];
                [newRecord setNotes:[self removeNull:[recordInfo objectForKey:@"notes"]]];
                [newRecord setSkype:[self removeNull:[recordInfo objectForKey:@"skype"]]];
                [newRecord setTwitter:[self removeNull:[recordInfo objectForKey:@"twitter"]]];
                [newRecord setImageUrl:[self removeNull:[recordInfo objectForKey:@"image_url"]]];
                
                if([newRecord.LastName length] > 0){
                    [self.displayContentArray addObject:newRecord];
                    BOOL found = NO;
                    for(NSString* key in [self.contactSectionsDictionary allKeys]){
                        @autoreleasepool {
                            if([key caseInsensitiveCompare:[newRecord.LastName substringToIndex:1] ] == 0 ){
                                // contact fits in one of the buckets already in the dictionary
                                NSMutableArray* section = [self.contactSectionsDictionary objectForKey:key];
                                [section addObject:newRecord];
                                found = YES;
                                break;
                            }
                        }
                    }
                    if(!found){
                        // add new key
                        NSString* key = [[newRecord.LastName substringToIndex:1] uppercaseString];
                        self.contactSectionsDictionary[key] = [[NSMutableArray alloc] initWithObjects:newRecord, nil];
                    }
                }
            }
        }
        
        // sort the sections in the dictionary by lastName, firstName
        NSMutableDictionary* tmp = [[NSMutableDictionary alloc] init];
        
        for(NSString* key in [self.contactSectionsDictionary allKeys]){
            @autoreleasepool {
                NSMutableArray* unsorted = [self.contactSectionsDictionary objectForKey:key];
                NSArray* sorted = [unsorted sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    
                    ContactRecord* one = (ContactRecord*) obj1;
                    ContactRecord* two = (ContactRecord*) obj2;
                    if([[one LastName] isEqual:[two LastName]]){
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
        }
        
        self.contactSectionsDictionary = tmp;
        
        self.alphabetArray = [[[self.contactSectionsDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(),^ (void){
            if(!self.viewReady){
                self.viewReady = YES;
                [self.viewLock signal];
                [self.viewLock unlock];
            }
            else{
                [self.contactListTableView reloadData];
                [self.contactListTableView setNeedsDisplay];
            }
        });
    } failure:^(NSError *error) {
        if(error.code == 400){
            NSDictionary* decode = [[error.userInfo objectForKey:@"error"] firstObject];
            NSString* message = [decode objectForKey:@"message"];
            if([message containsString:@"Invalid relationship"]){
                NSLog(@"Error: table names in relational calls are case sensitive: %@", message);
                dispatch_async(dispatch_get_main_queue(),^ (void){
                    UIAlertView *message= [[UIAlertView alloc]initWithTitle:@"" message:error.errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [message show];
                    [self.navigationController
                     popToRootViewControllerAnimated:YES];
                });
                return;
            }
        }
        
        NSLog(@"Error getting contacts with relation: %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            UIAlertView *message= [[UIAlertView alloc]initWithTitle:@"" message:error.errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [message show];
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) removeContactWithContactId:(NSNumber*) contactId{
    // remove the contact from the database
    [[RESTEngine sharedEngine] removeContactWithContactId:contactId success:^(NSDictionary *response) {
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.contactListTableView reloadData];
            [self.contactListTableView setNeedsDisplay];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error deleting contact: %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            UIAlertView *message= [[UIAlertView alloc]initWithTitle:@"" message:error.errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [message show];
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) showContactViewController: (ContactRecord*) record {
    self.goingToShowContactViewController = YES;
    // give the calls on the other end just a little bit of time
    dispatch_async(dispatch_queue_create("contactListShowQueue", NULL), ^{
        [self.contactViewController waitToReady];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:self.contactViewController animated:YES];
            
        });
    });
}

- (void) showContactEditViewController{
    ContactEditViewController* contactEditViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactEditViewController"];
    // tell the contact list what group it is looking at
    contactEditViewController.contactRecord = nil;
    contactEditViewController.contactGroupId = self.groupRecord.Id;
    contactEditViewController.contactViewController = nil;
    [self.navigationController pushViewController:contactEditViewController animated:YES];
}

- (void) showGroupEditViewController{
    // same view controller, but set params to edit
    GroupAddViewController* groupAddViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GroupAddViewController"];
    groupAddViewController.groupRecord = self.groupRecord;
    [groupAddViewController prefetch];
    dispatch_async(dispatch_queue_create("contactListShowQueue", NULL), ^{
        
        [groupAddViewController waitToReady];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:groupAddViewController animated:YES];
            
        });
    });
}

@end
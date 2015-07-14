#ifndef example_ios_ContactListTableViewController_h
#define example_ios_ContactListTableViewController_h

#import <UIKit/UIKit.h>
#import "AddressBookRecord.h"

@interface ContactListViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>


@property (weak, nonatomic) IBOutlet UITableView *contactListTableView;

// which group is being viewed
@property (nonatomic) GroupRecord* groupRecord;

- (void) prefetch;

// blocks until the data has been fetched
- (void) waitToReady;
@end

#endif

#ifndef example_ios_GroupAddViewController_h
#define example_ios_GroupAddViewController_h

#import <UIKit/UIKit.h>
#import "AddressBookRecord.h"

// view controller for adding a new group and editing an existing group
@interface GroupAddViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView* groupAddTableView;
@property (weak, nonatomic) IBOutlet UITextField* groupNameTextField;

// set groupRecord and contacts alreadyInGroup when editing an existing group
// contacts already in the existing group
@property (retain, nonatomic) NSMutableArray* contactsAlreadyInGroupContentsArray;

// record of the group being edited
@property (retain, nonatomic) GroupRecord* groupRecord;

- (void) prefetch;
- (void) waitToReady;
@end
#endif

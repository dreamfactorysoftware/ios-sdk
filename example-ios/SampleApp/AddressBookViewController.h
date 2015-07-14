#ifndef example_ios_AddressBookViewController_h
#define example_ios_AddressBookViewController_h

#import <UIKit/UIKit.h>

@interface AddressBookViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) IBOutlet UITableView *addressBookTableView;

@end
#endif

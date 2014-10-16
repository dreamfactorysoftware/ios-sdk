
#import <UIKit/UIKit.h>

@interface RemoteFileContentViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *fileListTableView;
@property (nonatomic , retain) NSArray *fileListContentArray;

-(void)showProgressView:(BOOL)progress;

-(IBAction)backEvent:(id)sender;

@end

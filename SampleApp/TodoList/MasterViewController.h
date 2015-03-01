
#import <UIKit/UIKit.h>

#define kApplicationName @"todoangular"
#define kTableName @"todo"
#define kSessionIdKey @"SessionId"
#define kBaseDspUrl @"BaseDspUrl"
#define kUserEmail @"UserEmail"
#define kPassword @"UserPassword"
#define kContainerName @"applications"
#define kFolderName @"uploaded_files"


@interface MasterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

#ifndef example_ios_MasterViewController_h
#define example_ios_MasterViewController_h

#import <UIKit/UIKit.h>

// change these values to match your DSP
#define kApplicationName @"add_ios"
#define kSessionIdKey @"SessionId"
#define kBaseDspUrl @"http://localhost:8888/rest"
#define kUserEmail @"UserEmail"
#define kPassword @"UserPassword"
#define kContainerName @"applications"
#define kFolderName @"uploaded_files"


@interface MasterViewController : UIViewController

@end

#endif

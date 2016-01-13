#ifndef example_ios_MasterViewController_h
#define example_ios_MasterViewController_h

#import <UIKit/UIKit.h>

// change these values to match your instance

// API key for your app goes here, see apps tab in admin console
#define kApiKey @"47f611bfd5da6bc33e01a473142ea048409adb970839c95fa32af28e4c002e79"
#define kSessionTokenKey @"SessionToken"
#define kBaseInstanceUrl @"https://df-test-gm.enterprise.dreamfactory.com/api/v2"
#define kDbServiceName @"db/_table"
#define kUserEmail @"UserEmail"
#define kPassword @"UserPassword"
#define kContainerName @"profile_images"


@interface MasterViewController : UIViewController

@end

#endif

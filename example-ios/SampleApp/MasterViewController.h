#ifndef example_ios_MasterViewController_h
#define example_ios_MasterViewController_h

#import <UIKit/UIKit.h>

// change these values to match your instance

// API key for your app goes here, see apps tab in admin console
#define kApiKey @"ede6ff689bbfe84ba3c0d14c668cd6d523f388e46f165ded4e81f7a18a5301f4"
#define kSessionTokenKey @"SessionToken"
#define kBaseInstanceUrl @"http://localhost:8080/api/v2"
#define kDbServiceName @"db/_table"
#define kUserEmail @"UserEmail"
#define kPassword @"UserPassword"
#define kContainerName @"profile_images"


@interface MasterViewController : UIViewController

@end

#endif

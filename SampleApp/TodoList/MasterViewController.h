//
//  ViewController.h
//  TodoList
//
//  Created by Sachin Soni on 2/26/14.
//  Copyright (c) 2014 sachin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kApplicationName @"ToDoListAndroid"
#define kTableName @"todo"
#define kSessionIdKey @"SessionId"
#define kBaseDspUrl @"BaseDspUrl"

@interface MasterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

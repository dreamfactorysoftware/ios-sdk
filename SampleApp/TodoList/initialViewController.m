
#import "initialViewController.h"
#import "ToDoListViewController.h"
#import "SelectFileViewController.h"
#import "SWGUserApi.h"
#import "MasterViewController.h"

@interface initialViewController ()
@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation initialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(IBAction)SelectToDoListDemo:(id)sender{
        ToDoListViewController *toDolistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ToDoListViewController"];
        [self.navigationController pushViewController:toDolistViewController animated:YES];
}
-(IBAction)SelectFileApiDemo:(id)sender{
    SelectFileViewController *selectFileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectFileViewController"];
    [self.navigationController pushViewController:selectFileViewController animated:YES];

    
}
-(IBAction)Logout:(id)sender{
    [self showProgressView:YES];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    SWGUserApi *userApi=[[SWGUserApi alloc]init];
    [userApi setBaseUrlPath:baseDSPUrl];
    [userApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [userApi addHeader:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    [userApi logoutWithCompletionBlock:^(SWGSuccess *output, NSError *error) {
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kSessionIdKey];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserEmail];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kPassword];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}


-(void)showProgressView:(BOOL)progress{
    
    if(progress){
        [self.progressView setHidden:NO];
        [self.activityIndicator startAnimating];
    }else{
        [self.progressView setHidden:YES];
        [self.activityIndicator stopAnimating];
    }
}


@end

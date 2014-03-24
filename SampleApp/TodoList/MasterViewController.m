//
//  ViewController.m
//  TodoList
//
//  Created by Sachin Soni on 2/26/14.
//  Copyright (c) 2014 sachin. All rights reserved.
//

#import "MasterViewController.h"
#import "ToDoListViewController.h"
#import "SWGUserApi.h"




@interface MasterViewController ()

@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)SubmitActionEvent:(id)sender;
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    if(baseDSPUrl.length>0)
        [self.urlTextField setText:baseDSPUrl];
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    if (swgSessionId.length>0) {
        [self displayToDoListViewController];
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SubmitActionEvent:(id)sender {
    
    if(self.urlTextField.text.length>0 && self.emailTextField.text.length>0 && self.passwordTextField.text.length>0) {
        [self.urlTextField resignFirstResponder];
        [self.emailTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        NSString *baseDspUrl=self.urlTextField.text;
        SWGUserApi *userApi=[[SWGUserApi alloc]init];
        [userApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        if(self.urlTextField.text.length>0)
        [userApi setBaseUrlPath:self.urlTextField.text];
        
        SWGLogin *login=[[SWGLogin alloc]init];
        [login setEmail:self.emailTextField.text];
        [login setPassword:self.passwordTextField.text];
        
        
        [self.progressView setHidden:NO]; 
        [self.activityIndicator startAnimating];
        
        [userApi loginWithCompletionBlock:login completionHandler:^(SWGSession *output, NSError *error) {
            NSLog(@"Error %@",error);
            NSLog(@"OutPut %@",output._id);
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self.progressView setHidden:YES];
                [self.activityIndicator stopAnimating];
                if(output){
                    NSString *SessionId=output.session_id;
                    if(self.urlTextField.text.length>0)
                    [[NSUserDefaults standardUserDefaults] setValue:baseDspUrl forKey:kBaseDspUrl];
                    [[NSUserDefaults standardUserDefaults] setValue:SessionId forKey:kSessionIdKey];
                    [self displayToDoListViewController];
                }else{
                
                    UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                    [message show];
                }
                
            });

        }];
  }
    else {
        UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"" message:@"Please fill the all entry first." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [message show];
    }
}


// Display ToDoListViewController

-(void)displayToDoListViewController{
    ToDoListViewController *toDolistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ToDoListViewController"];
    [self.navigationController pushViewController:toDolistViewController animated:YES];
}

// TextField Delegate called when press return key in Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.urlTextField setText:@""];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    if(baseDSPUrl.length>0)
        [self.urlTextField setText:baseDSPUrl];
    [self.emailTextField setText:@""];
    [self.passwordTextField setText:@""];
}


@end

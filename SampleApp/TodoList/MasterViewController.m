
#import "MasterViewController.h"
#import "ToDoListViewController.h"
#import "SWGUserApi.h"
#import "initialViewController.h"


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
   
    NSString  *userEmail=[[NSUserDefaults standardUserDefaults] valueForKey:kUserEmail];
    NSString  *userPassword=[[NSUserDefaults standardUserDefaults] valueForKey:kPassword];

    if(userEmail.length >0 && userPassword.length >0 && baseDSPUrl.length>0){
        [self.emailTextField setText:userEmail];
        [self.passwordTextField setText:userPassword];
        [self getNewSessionWithEmail:userEmail Password:userPassword BaseUrl:baseDSPUrl];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(NSString *)setBaseUrlPath:(NSString*)baseUrl{
    
    NSString *lastPathComponent=[baseUrl lastPathComponent];
    NSString *basePath = nil;
    if(![lastPathComponent isEqualToString:@"rest"])
        
        basePath=[baseUrl stringByAppendingString:@"/rest"];
    
    else{
        
        basePath=baseUrl;
        
    }
    return basePath;
}
- (IBAction)SubmitActionEvent:(id)sender {
    if(self.urlTextField.text.length>0 && self.emailTextField.text.length>0 && self.passwordTextField.text.length>0) {
        [self.urlTextField resignFirstResponder];
        [self.emailTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
    NSString *serviceName = @"user"; // your service name here
    NSString *apiName = @"session"; // rest path
    NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",[self setBaseUrlPath:self.urlTextField.text],serviceName,apiName];
    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    NSString* contentType = @"application/json";
    
    NSDictionary *requestBody = @{@"email": self.emailTextField.text, @"password": self.passwordTextField.text};
    [self.progressView setHidden:NO];
    [self.activityIndicator startAnimating];
    [_api dictionary:restApiPath method:@"POST" queryParams:queryParams body:requestBody headerParams:headerParams contentType:contentType completionBlock:^(NSDictionary *responseDict, NSError *error) {
        NSLog(@"Error %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.progressView setHidden:YES];
            [self.activityIndicator stopAnimating];
            if(responseDict){
                NSString *SessionId = [responseDict objectForKey:@"session_id"];
                if(self.urlTextField.text.length>0)
                [[NSUserDefaults standardUserDefaults] setValue:[self setBaseUrlPath:self.urlTextField.text] forKey:kBaseDspUrl];
                [[NSUserDefaults standardUserDefaults] setValue:SessionId forKey:kSessionIdKey];
                [[NSUserDefaults standardUserDefaults] setValue:self.emailTextField.text forKey:kUserEmail];
                [[NSUserDefaults standardUserDefaults] setValue:self.passwordTextField.text forKey:kPassword];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self displayInitialViewController];
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


- (IBAction)SubmitActionEvent2:(id)sender {
    
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
                    [[NSUserDefaults standardUserDefaults] setValue:login.email forKey:kUserEmail];
                    [[NSUserDefaults standardUserDefaults] setValue:login.password forKey:kPassword];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self displayInitialViewController];
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



-(void)displayToDoListViewController{
    ToDoListViewController *toDolistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ToDoListViewController"];
    [self.navigationController pushViewController:toDolistViewController animated:YES];
}

-(void)displayInitialViewController{
    initialViewController *initialViewControllerObject = [self.storyboard instantiateViewControllerWithIdentifier:@"initialViewController"];
    [self.navigationController pushViewController:initialViewControllerObject animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.urlTextField setText:@""];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    if(baseDSPUrl.length>0)
        [self.urlTextField setText:baseDSPUrl];
    NSString  *userEmail=[[NSUserDefaults standardUserDefaults] valueForKey:kUserEmail];
    NSString  *userPassword=[[NSUserDefaults standardUserDefaults] valueForKey:kPassword];
    
    if(userEmail.length >0 && userPassword.length >0 ){
        [self.emailTextField setText:userEmail];
        [self.passwordTextField setText:userPassword];
    }else{
        [self.emailTextField setText:@""];
        [self.passwordTextField setText:@""];
    }
}

-(void)getNewSessionWithEmail1:(NSString*)email Password:(NSString*)password BaseUrl:(NSString*)baseUrl{
    NSString *baseDspUrl=baseUrl;
    SWGUserApi *userApi=[[SWGUserApi alloc]init];
    [userApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [userApi setBaseUrlPath:baseDspUrl];
    
    SWGLogin *login=[[SWGLogin alloc]init];
    [login setEmail:email];
    [login setPassword:password];
    
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
                [[NSUserDefaults standardUserDefaults] setValue:baseDspUrl forKey:kBaseDspUrl];
                [[NSUserDefaults standardUserDefaults] setValue:SessionId forKey:kSessionIdKey];
                [[NSUserDefaults standardUserDefaults] setValue:login.email forKey:kUserEmail];
                [[NSUserDefaults standardUserDefaults] setValue:login.password forKey:kPassword];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self displayInitialViewController];
            }else{
                
                UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [message show];
            }
            
        });
        
    }];

}

-(void)getNewSessionWithEmail:(NSString*)email Password:(NSString*)password BaseUrl:(NSString*)baseUrl{
    NSString *baseDspUrl=baseUrl;
    [self.progressView setHidden:NO];
    [self.activityIndicator startAnimating];
    
    NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
    NSString *serviceName = @"user"; // your service name here
    NSString *apiName = @"session"; // rest path
    NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",[self setBaseUrlPath:self.urlTextField.text],serviceName,apiName];
    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    NSString* contentType = @"application/json";
    
    NSDictionary *requestBody = @{@"email": email, @"password": password};
    
    [_api dictionary:restApiPath method:@"POST" queryParams:queryParams body:requestBody headerParams:headerParams contentType:contentType completionBlock:^(NSDictionary *output, NSError *error) {
        NSLog(@"Error %@",error);
        NSLog(@"OutPut %@",[output objectForKey:@"id"]);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.progressView setHidden:YES];
            [self.activityIndicator stopAnimating];
            if(output){
                NSString *SessionId=[output objectForKey:@"session_id"];
                [[NSUserDefaults standardUserDefaults] setValue:baseDspUrl forKey:kBaseDspUrl];
                [[NSUserDefaults standardUserDefaults] setValue:SessionId forKey:kSessionIdKey];
                [[NSUserDefaults standardUserDefaults] setValue:email forKey:kUserEmail];
                [[NSUserDefaults standardUserDefaults] setValue:password forKey:kPassword];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self displayInitialViewController];
            }else{
                
                UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [message show];
            }
            
        });
        
    }];
    
}

@end

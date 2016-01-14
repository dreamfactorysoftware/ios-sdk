#import <Foundation/Foundation.h>
#import "MasterViewController.h"
#import "AddressBookViewController.h"
#import "RegisterViewController.h"
#import "CustomNavBar.h"
#import "AppDelegate.h"
#import "RESTEngine.h"

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)RegisterActionEvent:(id)sender;

- (IBAction)SubmitActionEvent:(id)sender;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString  *userEmail=[[NSUserDefaults standardUserDefaults] valueForKey:kUserEmail];
    NSString  *userPassword=[[NSUserDefaults standardUserDefaults] valueForKey:kPassword];
    
    [self.emailTextField setValue:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    if(userEmail.length >0 && userPassword.length > 0){
        [self.emailTextField setText:userEmail];
        [self.passwordTextField setText:userPassword];
    }
    
    // set up the custom nav bar
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.backButton addTarget:self action:@selector(hitBackButton) forControlEvents:UIControlEventTouchDown];    
}

- (void) hitBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar showBackButton:NO];
    [navBar showAddButton:NO];
    [navBar showEditButton:NO];
    [navBar showDoneButton:NO];
    [navBar reloadInputViews];
}

- (IBAction)RegisterActionEvent:(id)sender {
    [self showRegisterViewController];
}

- (IBAction)SubmitActionEvent:(id)sender {
    // log in using the generic API
    if(self.emailTextField.text.length>0 && self.passwordTextField.text.length>0) {
        [self.emailTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        
        [[RESTEngine sharedEngine] loginWithEmail:self.emailTextField.text password:self.passwordTextField.text success:^(NSDictionary *response) {
            [RESTEngine sharedEngine].sessionToken = response[@"session_token"];

            [[NSUserDefaults standardUserDefaults] setValue:self.emailTextField.text forKey:kUserEmail];
            [[NSUserDefaults standardUserDefaults] setValue:self.passwordTextField.text forKey:kPassword];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self showAddressBookViewController];
            });
        } failure:^(NSError *error) {
            NSLog(@"Error logging in user: %@",error);
            dispatch_async(dispatch_get_main_queue(),^ (void){
                UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"" message:@"Error, invalid password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [message show];
            });
        }];
    } else {
        UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"" message:@"Enter email and password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [message show];
    }
}

- (void) showAddressBookViewController {
    AddressBookViewController* addressBookViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressBookViewController"];
    [self.navigationController pushViewController:addressBookViewController animated:YES];
}

- (void) showRegisterViewController {
    RegisterViewController* registerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

@end
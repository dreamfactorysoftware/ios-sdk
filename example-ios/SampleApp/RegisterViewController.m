#import <Foundation/Foundation.h>

#import "RegisterViewController.h"
#import "AddressBookViewController.h"

#import "RESTEngine.h"
#import "AppDelegate.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self.emailTextField setValue:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar showBackButton:YES];
    [navBar showAddButton:NO];
    [navBar showEditButton:NO];
    [navBar.backButton addTarget:self action:@selector(hitBackButton) forControlEvents:UIControlEventTouchDown];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.backButton removeTarget:self action:@selector(hitBackButton) forControlEvents:UIControlEventTouchDown];
    
}

- (void) hitBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SubmitActionEvent:(id)sender {
    [self.view endEditing:YES];
    if(self.emailTextField.text.length>0 && self.passwordTextField.text.length>0){
       
        [[RESTEngine sharedEngine] registerWithEmail:self.emailTextField.text password:self.passwordTextField.text success:^(NSDictionary *response) {
            
            [RESTEngine sharedEngine].sessionToken = response[@"session_token"];
            [[NSUserDefaults standardUserDefaults] setValue:self.emailTextField.text forKey:kUserEmail];
            [[NSUserDefaults standardUserDefaults] setValue:self.passwordTextField.text forKey:kPassword];
            [[NSUserDefaults standardUserDefaults] synchronize];
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self showAddressBookViewController];
            });
            
        } failure:^(NSError *error) {
            NSLog(@"Error registering new user: %@",error);
            dispatch_async(dispatch_get_main_queue(),^ (void){
                UIAlertView *message= [[UIAlertView alloc]initWithTitle:@"" message:error.errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [message show];
                [self.navigationController popToRootViewControllerAnimated:YES];
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

@end
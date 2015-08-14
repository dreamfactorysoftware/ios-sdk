#import <Foundation/Foundation.h>


#import "MasterViewController.h"
#import "RegisterViewController.h"
#import "AddressBookViewController.h"

#import "NIKApiInvoker.h"
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
    
    if(self.emailTextField.text.length>0 && self.passwordTextField.text.length>0){
        // use the generic API invoker
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        NSString *baseUrl = kBaseDspUrl; // <DSP url>/rest
        
        // build rest path for request, form is <url to DSP>/rest/serviceName/tableName
        NSString *serviceName = @"user"; // your service name here
        NSString *tableName = @"register"; // rest path
        NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",baseUrl,serviceName, tableName];
        NSLog(@"\n%@\n", restApiPath);
        
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        // also log in (get session id) when registering
        queryParams[@"login"] = [NSNumber numberWithBool:TRUE];
        
        // header has session id and application name to validate access
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        
        NSString* contentType = @"application/json";
        NSDictionary* requestBody = @{@"email":self.emailTextField.text,
                                      @"new_password":self.passwordTextField.text};
        
        [_api restPath:restApiPath
                method:@"POST"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
           if (error) {
               NSLog(@"Error registering new user data: %@",error);
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.navigationController popToRootViewControllerAnimated:YES];
               });
           }else{
               [[NSUserDefaults standardUserDefaults] setValue:baseUrl forKey:kBaseDspUrl];
               [[NSUserDefaults standardUserDefaults] setValue:[responseDict objectForKey:@"session_id"] forKey:kSessionIdKey];
               [[NSUserDefaults standardUserDefaults] setValue:self.emailTextField.text forKey:kUserEmail];
               [[NSUserDefaults standardUserDefaults] setValue:self.passwordTextField.text forKey:kPassword];
               [[NSUserDefaults standardUserDefaults] synchronize];
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self showAddressBookViewController];
               });
           }
       }];
    }
}

- (void) showAddressBookViewController {
    AddressBookViewController* addressBookViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressBookViewController"];
    [self.navigationController pushViewController:addressBookViewController animated:YES];
}

@end
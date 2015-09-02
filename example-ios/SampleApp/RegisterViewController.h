#ifndef example_ios_RegisterViewController_h
#define example_ios_RegisterViewController_h

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)SubmitActionEvent:(id)sender;

@end
#endif

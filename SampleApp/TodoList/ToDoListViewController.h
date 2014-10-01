#import <UIKit/UIKit.h>

@interface ToDoListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *todoListTableView;
@property (nonatomic , retain) NSMutableArray *todoListContentArray;
@property (retain, nonatomic) IBOutlet UIView *userInputView;
@property (retain, nonatomic) IBOutlet UITextField *userInputTextField;


- (void)dismissKeyboard;
-(void)keyboardWillShow:(id)sender;
-(void)keyboardDidHide:(id)sender;
-(void)showProgressView:(BOOL)progress;

-(IBAction)addTodoTaskActionEvent:(id)sender;
-(IBAction)deleteTodoTaskActionEvent:(id)sender;
-(IBAction)backEvent:(id)sender;
-(IBAction)doLogout:(id)sender;
@end

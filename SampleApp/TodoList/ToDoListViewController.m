
#import "ToDoListViewController.h"
#import "todoTableViewCell.h"
#import "SWGDbApi.h"
#import "MasterViewController.h"
#import "SWGSession.h"
#import "TODORecord.h"
#import "SWGUserApi.h"

static NSString *baseUrl=@"";

@interface ToDoListViewController ()
@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ToDoListViewController

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
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    baseUrl=baseDSPUrl;
    [self getTodoListContentFromServer];
    
    self.todoListContentArray=[[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];

    self.todoListTableView.layer.borderWidth = 1;
    self.todoListTableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - KeyBoard Notification

-(void)keyboardDidHide:(id)sender{
    [self setViewMovedUp:NO];
}

-(void)keyboardWillShow:(id)sender{
    [self setViewMovedUp:YES];
}


- (void)dismissKeyboard
{
    [self.userInputTextField resignFirstResponder];
}


-(void)setViewMovedUp:(BOOL)movedUp
{
    CGRect frame=self.navigationController.view.frame;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1]; 
    CGRect rect = self.userInputView.frame;
    if (movedUp)
    {
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            if (UIInterfaceOrientationIsPortrait(orientation)) {
                if(frame.size.height==1024 && frame.size.width==768){
                    rect.origin.y =frame.origin.y+660;
                }else{
                    rect.origin.y =frame.origin.y+660;
                }
            }else{
                if(frame.size.height==568 && frame.size.width==320){
                    rect.origin.y =frame.origin.y+62;
                }else{
                    rect.origin.y =frame.origin.y+64;
                }
            }
        }else{
            if (UIInterfaceOrientationIsPortrait(orientation)) {
                if(frame.size.height==568 && frame.size.width==320){
                    rect.origin.y =frame.origin.y+244+10;
                }else{
                    rect.origin.y =frame.origin.y+156+10;
                }
            }else{
                if(frame.size.height==568 && frame.size.width==320){
                    rect.origin.y =frame.origin.y+62;
                }else{
                    rect.origin.y =frame.origin.y+64;
                }
            }
        }
        
    }
    else
    {
        if (UIInterfaceOrientationIsPortrait(orientation)) {
             rect.origin.y = frame.size.height-100;
        }else{
            if(frame.size.height==568 && frame.size.width==320){
                rect.origin.y = frame.size.height-344;
            }else{
                rect.origin.y = frame.size.height-256;
            }
        }
    }
    self.userInputView.frame = rect;
    [UIView commitAnimations];
}

#pragma mark - TableView Delegate Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"todoTableViewCell";
    TODORecord *record=[self.todoListContentArray objectAtIndex:indexPath.row];
    todoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"todoTableViewCell" owner:nil options:nil];
        cell = (todoTableViewCell *) [nib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSLog(@"is recored completed %@", record.record_Complete);
    @try
    {
        if(record.record_Complete != NULL && [record.record_Complete integerValue]==0){
            cell.isComplete=NO;
        }else{
            cell.isComplete=YES;
        }
    }
    @catch (NSException *exception)
    {
        cell.isComplete=NO;
    }
    
    [cell setTaskComplete:cell.isComplete];
    [cell.deleteButton setTag:indexPath.row];
    [cell.deleteButton addTarget:self action:@selector(deleteTodoTaskActionEvent:) forControlEvents:UIControlEventTouchDown];
    [cell.todoTextLabel setText:record.record_Task];
    [cell setRecord_Id:record.record_Id];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

   [self showProgressView:YES];
    
    
    todoTableViewCell *cell = (todoTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    TODORecord *recordInfo=(TODORecord*)[self.todoListContentArray objectAtIndex:cell.deleteButton.tag];
    
    SWGRecordRequest *record=[[SWGRecordRequest alloc]init];
    [record setName:cell.todoTextLabel.text];
    [record set_id:cell.record_Id];
    if(cell.isComplete){
        [record set_complete:@"0"];
    }else{
        [record set_complete:@"1"];
    }
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    SWGDbApi *swgDbApi=[[SWGDbApi alloc]init];
    [swgDbApi setBaseUrlPath:baseUrl];
    [swgDbApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [swgDbApi addHeader:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    
    [swgDbApi updateRecordWithCompletionBlock:kTableName _id:[NSString stringWithFormat:@"%@",cell.record_Id] body:record fields:nil id_field:nil id_type:nil related:nil completionHandler:^(SWGRecordResponse *output, NSError *error) {
        NSLog(@"Completetion Error %@",error);
        NSLog(@"Completetion OutPut %@",output._id);
        dispatch_sync(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
            if (output) {
                [cell setIsComplete:!cell.isComplete];
                if(cell.isComplete){
                    [recordInfo setRecord_Complete:@"0"];
                }else{
                    [recordInfo setRecord_Complete:@"1"];
                }
                [cell setTaskComplete:cell.isComplete];
                [cell setNeedsDisplay];
            }
        });
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.todoListContentArray count];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
    
}

#pragma mark - action Event


-(IBAction)addTodoTaskActionEvent:(id)sender{
    
    NSString *taskToAdd=self.userInputTextField.text;
    [self.userInputTextField setText:@""];
    [self showProgressView:YES];
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    SWGRecordRequest *record=[[SWGRecordRequest alloc]init];
    [record set_field_:taskToAdd];
    [record setName:taskToAdd];
    SWGDbApi *swgDbApi=[[SWGDbApi alloc]init];
    [swgDbApi setBaseUrlPath:baseUrl];
    [swgDbApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [swgDbApi addHeader:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    [swgDbApi createRecordWithCompletionBlock:kTableName _id:@"" body:record fields:nil id_field:nil id_type:nil related:@"" completionHandler:^(SWGRecordResponse *output, NSError *error) {
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
        });
        if (error) {
            UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [message show];
        }else{
            TODORecord *newRecord=[[TODORecord alloc]init];
            [newRecord setRecord_Id:output._id];
            [newRecord setRecord_Task:record.name];
            [newRecord setRecord_Complete:output._complete];
            [self.todoListContentArray addObject:newRecord];
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self.todoListTableView reloadData];
                [self.todoListTableView setNeedsDisplay];
            });
        }
        
    }];
}


-(IBAction)deleteTodoTaskActionEvent:(id)sender{
    dispatch_async(dispatch_get_main_queue(),^ (void){
       [self showProgressView:YES];
    });
    
    UIButton *btn=(UIButton*)sender;
    TODORecord *record=(TODORecord*)[self.todoListContentArray objectAtIndex:btn.tag];
    [self showProgressView:NO];
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    SWGDbApi *swgDbApi=[[SWGDbApi alloc]init];
    [swgDbApi setBaseUrlPath:baseUrl];
    [swgDbApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [swgDbApi addHeader:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    [swgDbApi deleteRecordWithCompletionBlock:kTableName _id:[NSString stringWithFormat:@"%@",record.record_Id] fields:nil id_field:nil id_type:nil related:nil completionHandler:^(SWGRecordResponse *output, NSError *error) {
        NSLog(@"Error %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
        });
        if (error) {
            UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [message show];
        }else{
            for (TODORecord *record in self.todoListContentArray) {
                NSString *record_Id=[NSString stringWithFormat:@"%@",record.record_Id]  ;
                NSString *outPut_Id=[NSString stringWithFormat:@"%@",output._id];
                if ([record_Id isEqualToString:outPut_Id]) {
                    [self.todoListContentArray removeObject:record];
                    break;
                }
            }
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self.todoListTableView reloadData];
                [self.todoListTableView setNeedsDisplay];
            });
        }
    }];
    
    
}


-(void)getTodoListContentFromServer{
  
    
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    if (swgSessionId.length>0) {
        [self showProgressView:YES];
        SWGDbApi *swgDbApi=[[SWGDbApi alloc]init];
        [swgDbApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [swgDbApi addHeader:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        [swgDbApi setBaseUrlPath:baseUrl];
        [swgDbApi getRecordsWithCompletionBlock:kTableName ids:nil filter:nil limit:nil offset:nil order:nil fields:nil include_count:[NSNumber numberWithBool:TRUE] include_schema:nil id_field:nil id_type:nil continue:nil related:nil completionHandler:^(SWGRecordsResponse *output, NSError *error) {
            
            NSLog(@"Error %@",error);
            NSLog(@"OutPut %@",output.record);
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self showProgressView:NO];
            });
            if (error) {
                dispatch_async(dispatch_get_main_queue(),^ (void){
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
                
            }else{
                [self.todoListContentArray removeAllObjects];
                for (SWGRecordResponse *recordInfo in output.record) {
                    TODORecord *newRecord=[[TODORecord alloc]init];
                    [newRecord setRecord_Id:recordInfo._id];
                    [newRecord setRecord_Task:recordInfo.name];
                    [newRecord setRecord_Complete:recordInfo._complete];
                    [self.todoListContentArray addObject:newRecord];
                }
                
                dispatch_async(dispatch_get_main_queue(),^ (void){
                    [self.todoListTableView reloadData];
                    [self.todoListTableView setNeedsDisplay];
                });
            }
            
        }];
        
        
    }else{
        
    }
    
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

-(IBAction)doLogout:(id)sender{
    
        NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
        [self showProgressView:YES];
        SWGUserApi *userApi=[[SWGUserApi alloc]init];
        [userApi setBaseUrlPath:baseUrl];
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

-(IBAction)backEvent:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

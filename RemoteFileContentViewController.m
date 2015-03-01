
#import "RemoteFileContentViewController.h"
#import "SWGFilesApi.h"
#import "MasterViewController.h"
#import "remoteFileContentTableViewCell.h"

@interface RemoteFileContentViewController ()
@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation RemoteFileContentViewController

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
    [self loadRemoteFileList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)loadRemoteFileList{
    dispatch_async(dispatch_get_main_queue(),^ (void){
        [self showProgressView:YES];
    });
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];

    SWGFilesApi *fileApi = [[SWGFilesApi alloc] init];
    [fileApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [fileApi addHeader:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    [fileApi setBaseUrlPath:baseDSPUrl];
    [fileApi getFolderWithCompletionBlock:kContainerName folder_path:kFolderName include_properties:[NSNumber numberWithBool:YES] include_folders:[NSNumber numberWithBool:YES] include_files:[NSNumber numberWithBool:YES] full_tree:[NSNumber numberWithBool:YES] zip:[NSNumber numberWithBool:NO] completionHandler:^(SWGFolderResponse *output, NSError *error) {
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
        });
        if(error){
            UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [message show];

        }else{
            self.fileListContentArray = output.file;
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self.fileListTableView reloadData];
                [self.fileListTableView setNeedsDisplay];
            });
        }
        NSLog(@"output %@",output);
        NSLog(@"Error %@",error);

    }];
  
}

-(IBAction)backEvent:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.fileListContentArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"fileCell";
    SWGFileResponse *record=[self.fileListContentArray objectAtIndex:indexPath.row];
    remoteFileContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"remoteFileContentTableViewCell" owner:self options:nil];
        cell = (remoteFileContentTableViewCell *) [nib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell.deleteButton setTag:indexPath.row];
    [cell.deleteButton addTarget:self action:@selector(deleteTodoTaskActionEvent:) forControlEvents:UIControlEventTouchDown];
    [cell.filePathLabel setText:record.name];
    [cell.fielNameLabel setText:record.name];

    return cell;
}

-(IBAction)deleteTodoTaskActionEvent:(id)sender{
    dispatch_async(dispatch_get_main_queue(),^ (void){
        [self showProgressView:YES];
    });
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];

    UIButton *btn=(UIButton*)sender;
    SWGFileResponse *record=(SWGFileResponse*)[self.fileListContentArray objectAtIndex:btn.tag];
    SWGFilesApi *fileApi = [[SWGFilesApi alloc] init];
    [fileApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [fileApi addHeader:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    [fileApi setBaseUrlPath:baseDSPUrl];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",kFolderName,[self escapeString:record.name]];
    [fileApi deleteFolderWithCompletionBlock:kContainerName folder_path:filePath force:[NSNumber numberWithBool:NO] content_only:[NSNumber numberWithBool:NO] completionHandler:^(SWGFolderResponse *output, NSError *error) {
        if(error){
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self showProgressView:NO];
            });
            UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [message show];
            
        }else{
            [self loadRemoteFileList];
        }
    }];
    
   
}


-(NSString*) escapeString:(NSString *)unescaped {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef) unescaped,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
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

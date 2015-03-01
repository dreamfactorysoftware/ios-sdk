
#import "RemoteFileContentViewController.h"
#import "SWGFilesApi.h"
#import "MasterViewController.h"
#import "remoteFileContentTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

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
-(void)loadRemoteFileList1{
    dispatch_async(dispatch_get_main_queue(),^ (void){
        [self showProgressView:YES];
    });
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
    
    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    queryParams[@"include_properties"] = @"1";
    queryParams[@"include_folders"] = @"1";
    queryParams[@"include_files"] = @"1";
    queryParams[@"full_tree"] = @"1";
    queryParams[@"zip"] = @"0";
    
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    //add more headers here
    [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    
    //add more headers here
    NSString *serviceName = @"files"; // your service name here
    NSString *apiName = [NSString stringWithFormat:@"%@/%@/",kContainerName,kFolderName]; // rest path
    NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",baseDSPUrl,serviceName,apiName];
    
    NSDictionary *requestBody;
    
    NSString* contentType = @"application/json";
    
    [_api dictionary:restApiPath method:@"GET" queryParams:queryParams body:requestBody headerParams:headerParams contentType:contentType completionBlock:^(NSDictionary *responseDict, NSError *error) {
        NSLog(@"Error %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
        });
        if(error){
            UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [message show];
            
        }else{
            self.fileListContentArray = [responseDict objectForKey:@"file"];
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self.fileListTableView reloadData];
                [self.fileListTableView setNeedsDisplay];
            });
        }
    }];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(dispatch_get_main_queue(),^ (void){
        [self showProgressView:YES];
    });
    SWGFileResponse *record=[self.fileListContentArray objectAtIndex:indexPath.row];
    NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
    
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    
    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    //add more headers here
    [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    
    NSString *folderName = kContainerName; // Folder Name
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",kFolderName,record.name]; // File path
    NSString *restApiPath = [NSString stringWithFormat:@"%@/files/%@/%@",baseDSPUrl,folderName,filePath];
    queryParams[@"include_properties"] = @"1";
    queryParams[@"content"] = @"1";
    queryParams[@"download"] = @"1";
    
    NSDictionary *requestBody;
    
    NSString* contentType = @"application/json";
    
    [_api dictionary:restApiPath method:@"GET" queryParams:queryParams body:requestBody headerParams:headerParams contentType:contentType completionBlock:^(NSDictionary *responseDict, NSError *error) {
        NSLog(@"Error %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
        });
        if(error){
            UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [message show];
            
        }else{
            NSData *fileData = [[NSData alloc] initWithBase64EncodedString:[responseDict objectForKey:@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:fileData
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
            NSData *datafile = [[NSData alloc] initWithBase64EncodedString:[jsonObject objectForKey:@"data"] options:0];
            UIImage *image = [UIImage imageWithData:datafile];
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
                if (!error) {
                    NSLog(@"output %@",responseDict);
                    NSLog(@"Error %@",error);
                }
            }];
        }
        
    }];
}

-(IBAction)deleteTodoTaskActionEvent:(id)sender{
    dispatch_async(dispatch_get_main_queue(),^ (void){
        [self showProgressView:YES];
    });
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    
    UIButton *btn=(UIButton*)sender;
    SWGFileResponse *record=(SWGFileResponse*)[self.fileListContentArray objectAtIndex:btn.tag];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    //add more headers here
    [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    
    //add more headers here
    NSString *serviceName = @"files"; // your service name here
    NSString *apiName = [NSString stringWithFormat:@"%@/%@/%@",kContainerName,kFolderName,[self escapeString:record.name]]; // rest path

    NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",baseDSPUrl,serviceName,apiName];
    
    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    queryParams[@"force"] = @"0";
    queryParams[@"content_only"] = @"0";
    
    NSDictionary *requestBody;
    
    NSString* contentType = @"application/json";
    
    NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
    [_api dictionary:restApiPath method:@"DELETE" queryParams:queryParams body:requestBody headerParams:headerParams contentType:contentType completionBlock:^(NSDictionary *responseDict, NSError *error) {
        NSLog(@"Error %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
        });
        if(error){
            UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [message show];
            
        }else{
            [self loadRemoteFileList];
        }
    }];
    
}


-(IBAction)deleteTodoTaskActionEvent1:(id)sender{
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

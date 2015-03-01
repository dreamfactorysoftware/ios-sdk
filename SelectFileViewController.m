
#import "SelectFileViewController.h"
#import "RemoteFileContentViewController.h"
#import "SWGFileRequest.h"
#import "SWGFilesApi.h"
#import "MasterViewController.h"
#import "NIKFile.h"

@interface SelectFileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SelectFileViewController

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


-(IBAction)SelectLocalFile:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
}
-(IBAction)SelectRemoteFile:(id)sender{
    RemoteFileContentViewController *remoteFileContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RemoteFileContentViewController"];
    [self.navigationController pushViewController:remoteFileContentViewController animated:YES];

}

-(IBAction)backEvent:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    dispatch_async(dispatch_get_main_queue(),^ (void){
        [self showProgressView:YES];
    });
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1);
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
   
    NSURL *path = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSString *stringPath = [path absoluteString];
    NSString *name = [stringPath lastPathComponent];
    
    NIKFile *nikFile = [[NIKFile alloc] initWithNameData:name mimeType:@"application/octet-stream" data:dataImage];
    SWGFilesApi *fileApi = [[SWGFilesApi alloc] init];
    [fileApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [fileApi addHeader:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    [fileApi setBaseUrlPath:baseDSPUrl];
    [fileApi createFileWithCompletionBlock:@"applications" file_path:[NSString stringWithFormat:@"%@/%@",kFolderName,name] check_exist:nil NIKFilebody:nikFile completionHandler:^(SWGFileResponse *output, NSError *error) {
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
        });
        NSLog(@"output %@",output);
        NSLog(@"Error %@",error);

    }];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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

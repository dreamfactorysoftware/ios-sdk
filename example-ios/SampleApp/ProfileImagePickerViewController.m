#import <Foundation/Foundation.h>

#import "ProfileImagePickerViewController.h"
#import "MasterViewController.h"
#import "NIKFile.h"
#import "NIKApiInvoker.h"
#import "AppDelegate.h"

static NSString *baseUrl=@"";

@interface ProfileImagePickerViewController ()

// holds image picked from the camera roll
@property(nonatomic, retain) UIImage* imageToUpload;

// list of available profile images
@property (nonatomic, retain) NSMutableArray *imageListContentArray;

- (IBAction)ChooseLocalActionEvent:(id)sender;

@end

@implementation ProfileImagePickerViewController

@synthesize delegate;

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // get the base URL (<url to DSP>/rest)
    NSString  *baseDSPUrl=[[NSUserDefaults standardUserDefaults] valueForKey:kBaseDspUrl];
    baseUrl=baseDSPUrl;
    
    self.imageListContentArray = [[NSMutableArray alloc] init];
    [self getImageListFromServer];
    
    [self.imageNameTextField setValue:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    self.imageListTableView.contentInset = UIEdgeInsetsMake(-70, 0, -20, 0);
    
    self.imageToUpload = nil;
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar.doneButton removeTarget:self action:@selector(hitSaveButton) forControlEvents:UIControlEventTouchDown];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate* bar = [[UIApplication sharedApplication] delegate];
    CustomNavBar* navBar = bar.globalToolBar;
    [navBar showDone];
    [navBar.doneButton addTarget:self action:@selector(hitSaveButton) forControlEvents:UIControlEventTouchDown];
}

- (void) hitSaveButton {
    // actually put image up on the server when the contact gets created
    if(self.imageToUpload == nil){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        // if we chose an image to upload
        if([self.imageNameTextField.text length] > 0){
            [self.delegate addItemWithoutContactViewController:self didFinishEnteringItem:self.imageNameTextField.text didChooseImageFromPicker:self.imageToUpload];
        }
        else{
            // if we did not name the image
            [self.delegate addItemWithoutContactViewController:self didFinishEnteringItem:@"profileImage" didChooseImageFromPicker:self.imageToUpload];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.imageListContentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"profileImageTableViewCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.imageListContentArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // chose a file off the server
    NSString* toPass= [self.imageListContentArray objectAtIndex:indexPath.row];
    [self.delegate addItemViewController:self didFinishEnteringItem:toPass];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) ChooseLocalActionEvent:(id)sender {
    // chose an image from the camera roll
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // get image retrieved from the camera roll
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.imageToUpload = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void) getImageListFromServer {
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    if(self.record == nil){
        return;
    }
    if (swgSessionId.length>0) {
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        
        // build rest path for request, form is <url to DSP>/rest/files/container/application/<folder path>/
        // here the folder path is profile_images/contactId/
        NSString* containerName = @"applications";
        NSString* folderPath = [NSString stringWithFormat:@"profile_images/%@", [self.record.Id stringValue]];
        // note that you need the extra '/' here at the end of the api path because you are
        // targeting a folder not a file
        NSString *restApiPath = [NSString stringWithFormat:  @"%@/files/%@/%@/%@/",baseUrl,containerName, kApplicationName, folderPath];
        NSLog(@"\nAPI path: %@\n", restApiPath);
        
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        // only want to get files, not any sub folders
        queryParams[@"include_folders"] = [NSNumber numberWithBool:NO];
        queryParams[@"include_files"] = [NSNumber numberWithBool:YES];
        
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        
        NSString* contentType = @"application/json";
        NSDictionary* requestBody = nil;
        
        [_api restPath:restApiPath
                method:@"GET"
           queryParams:queryParams
                  body:requestBody
          headerParams:headerParams
           contentType:contentType
       completionBlock:^(NSDictionary *responseDict, NSError *error) {
           
           if (error) {
               // check if the error is file not found
               if(error.code == 404){
                   NSDictionary* decode = [[error.userInfo objectForKey:@"error"] firstObject];
                   NSString* message = [decode objectForKey:@"message"];
                   if([message containsString:@"does not exist in storage"]){
                       NSLog(@"Warning: Error getting profile image list data from server: %@", message);
                       return;
                   }
               }
               // else report normally
               NSLog(@"Error getting profile image list data from server: %@", error);
               dispatch_async(dispatch_get_main_queue(),^ (void){
                   [self.navigationController popToRootViewControllerAnimated:YES];
               });
           }
           
           NSLog(@"Error getting profile image list data from server: %@", error);
           
           [self.imageListContentArray removeAllObjects];
           
           for(NSDictionary* fileDict in [responseDict objectForKey:@"file"]){
               [self.imageListContentArray addObject:[fileDict objectForKey:@"name"]];
           }
           
           dispatch_async(dispatch_get_main_queue(),^ (void){
               [self.imageListTableView reloadData];
               [self.imageListTableView setNeedsDisplay];
           });
       }];
    }
}

@end
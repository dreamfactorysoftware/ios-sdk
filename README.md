
##DreamFactory iOS SDK

###Getting Started

To use the iOS SDK, simply clone this repo.

####Importing the Xcode Project

Once your repo is cloned, open SampleApp/TodoList.xcodeproj

####Basic Usage

####This SDK provides APIs to call any RESTful service in DreamFactory.

#####User  Login
Sample code to connect to the 'user' service, for more details please check MasterViewController.m 

```objectivec


    //SWGUserApi
	// Creating a user api object
	SWGUserApi *userApi=[[SWGUserApi alloc]init];
        [userApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    // set app name header
        [userApi setBaseUrlPath:”your dsp url”];

	// create login request
        SWGLogin *login=[[SWGLogin alloc]init];
        [login setEmail:”login email”];
        [login setPassword:”password”];

	//For complete example please check MasterViewController.m

    SWGUserApi *userApi=[[SWGUserApi alloc]init];
        [userApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        if(self.urlTextField.text.length>0)
        [userApi setBaseUrlPath:self.urlTextField.text];

        SWGLogin *login=[[SWGLogin alloc]init];
        [login setEmail:self.emailTextField.text];
        [login setPassword:self.passwordTextField.text];


        [self.progressView setHidden:NO];
        [self.activityIndicator startAnimating];

        [userApi loginWithCompletionBlock:login completionHandler:^(SWGSession *output, NSError *error) {
            NSLog(@"Error %@",error);
            NSLog(@"OutPut %@",output._id);
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self.progressView setHidden:YES];
                [self.activityIndicator stopAnimating];
                if(output){
                    NSString *SessionId=output.session_id;
                    if(self.urlTextField.text.length>0)
                    [[NSUserDefaults standardUserDefaults] setValue:baseDspUrl forKey:kBaseDspUrl];
                    [[NSUserDefaults standardUserDefaults] setValue:SessionId forKey:kSessionIdKey];
                    [[NSUserDefaults standardUserDefaults] setValue:login.email forKey:kUserEmail];
                    [[NSUserDefaults standardUserDefaults] setValue:login.password forKey:kPassword];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self displayInitialViewController];
                }else{

                    UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                    [message show];
                }

            });

        }];

        ###### Using generic API Invoker

        - (IBAction)SubmitActionEvent:(id)sender {
    if(self.urlTextField.text.length>0 && self.emailTextField.text.length>0 && self.passwordTextField.text.length>0) {
        [self.urlTextField resignFirstResponder];
        [self.emailTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
    NSString *serviceName = @"user"; // your service name here
    NSString *apiName = @"session"; // rest path
    NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",[self setBaseUrlPath:self.urlTextField.text],serviceName,apiName];
    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    NSString* contentType = @"application/json";
    
    NSDictionary *requestBody = @{@"email": self.emailTextField.text, @"password": self.passwordTextField.text};
    [self.progressView setHidden:NO];
    [self.activityIndicator startAnimating];
    [_api dictionary:restApiPath method:@"POST" queryParams:queryParams body:requestBody headerParams:headerParams contentType:contentType completionBlock:^(NSDictionary *responseDict, NSError *error) {
        NSLog(@"Error %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self.progressView setHidden:YES];
            [self.activityIndicator stopAnimating];
            if(responseDict){
                NSString *SessionId = [responseDict objectForKey:@"session_id"];
                if(self.urlTextField.text.length>0)
                [[NSUserDefaults standardUserDefaults] setValue:[self setBaseUrlPath:self.urlTextField.text] forKey:kBaseDspUrl];
                [[NSUserDefaults standardUserDefaults] setValue:SessionId forKey:kSessionIdKey];
                [[NSUserDefaults standardUserDefaults] setValue:self.emailTextField.text forKey:kUserEmail];
                [[NSUserDefaults standardUserDefaults] setValue:self.passwordTextField.text forKey:kPassword];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self displayInitialViewController];
            }else{
                
                UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [message show];
            }
            
        });
        
    }];
    }
    else {
        UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"" message:@"Please fill the all entry first." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [message show];
    }
    
}


```
### Working with the DB Service
```objectivec


//SWGDBApi
	// create a SWGDBApi object similar to above
	SWGDbApi *swgDbApi=[[SWGDbApi alloc]init];
	[swgDbApi setBaseUrlPath:baseUrl];
	[swgDbApi addHeader:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
	[swgDbApi addHeader:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
	[swgDbApi createRecordWithCompletionBlock:kTableName _id:@"" body:record fields:nil id_field:nil id_type:nil related:@"" completionHandler:^(SWGRecordResponse *output, NSError *error) 	{
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

    ###### Using generic API Invoker
    -(void)getTodoListContentFromServer{
    NSString  *swgSessionId=[[NSUserDefaults standardUserDefaults] valueForKey:kSessionIdKey];
    if (swgSessionId.length>0) {
        [self showProgressView:YES];
        NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
        NSString *serviceName = @"db"; // your service name here
        NSString *apiName = kTableName; // rest path
        NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",baseUrl,serviceName,apiName];
        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
        queryParams[@"include_count"] = [NSNumber numberWithBool:TRUE];
        
        NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
        [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
        [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
        NSString* contentType = @"application/json";
        id bodyDictionary = nil;
        [self.progressView setHidden:NO];
        [self.activityIndicator startAnimating];
        [_api dictionary:restApiPath method:@"GET" queryParams:queryParams body:bodyDictionary headerParams:headerParams contentType:contentType completionBlock:^(NSDictionary *responseDict, NSError *error) {
            NSLog(@"Error %@",error);
            dispatch_async(dispatch_get_main_queue(),^ (void){
                [self showProgressView:NO];
            });
            if (error) {
                dispatch_async(dispatch_get_main_queue(),^ (void){
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
                
            }else{
                [self.todoListContentArray removeAllObjects];
                for (NSDictionary *recordInfo in [responseDict objectForKey:@"record"]) {
                    TODORecord *newRecord=[[TODORecord alloc]init];
                    [newRecord setRecord_Id:[recordInfo objectForKey:@"id"]];
                    [newRecord setRecord_Task:[recordInfo objectForKey:@"name"]];
                    [newRecord setRecord_Complete:[recordInfo objectForKey:@"complete"]];
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

```
####Working with Files
```objectivec

//SWGFilesApi
	//Here is how to use File API
       // create a SWGFilesApi api object similar to above
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

    #### Using generic api invoker
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
    NIKApiInvoker *_api = [NIKApiInvoker sharedInstance];
    
    NSString *folderName = @"applications"; // Folder Name
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",kFolderName,name]; // File path
    NSString *restApiPath = [NSString stringWithFormat:@"%@/files/%@/%@",baseDSPUrl,folderName,filePath];
    
    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
    [headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];
    
    NSString* contentType = @"application/octet-stream";
    
    NSString *base64String = [dataImage base64EncodedStringWithOptions:0];
    NSDictionary *requestBody = @{@"name": name, @"mimeType": @"application/octet-stream",@"data":base64String};
    
    [_api dictionary:restApiPath method:@"POST" queryParams:queryParams body:requestBody headerParams:headerParams contentType:contentType completionBlock:^(NSDictionary *responseDict, NSError *error) {
        NSLog(@"Error %@",error);
        dispatch_async(dispatch_get_main_queue(),^ (void){
            [self showProgressView:NO];
        });
        if (error) {
            UIAlertView *message=[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [message show];
        }else{
        }
    }];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

```

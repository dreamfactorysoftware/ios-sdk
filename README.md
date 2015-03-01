
##DreamFactory iOS SDK

###Getting Started

To use the iOS SDK, simply clone this repo.

####Importing the Xcode Project

Once your repo is cloned , open SampleApp/TodoList.xcodeproj

####Basic Usage

#####User  Login

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
```

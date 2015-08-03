SampleApp
==========
This repo contains a sample iPhone "Address Book" application that demonstrates the DreamFactory iOS API. 

#####Getting DreamFactory on your local machine
To download and install DreamFactory, follow the instructions [here](https://github.com/dreamfactorysoftware/dsp-core/wiki/Usage-Options). Alternatively, you can create a [free hosted developer account](http://www.dreamfactory.com) at www.dreamfactory.com if you don't want to install DreamFactory locally.

In the DreamFactory Admin Console, navigate to the Config tab and click on CORS in the left sidebar. To enable [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) for development purposes, click add, set the host to *, allow all HTTP verbs and check the enabled box. Click update when you are done. More info on setting up CORS is [here](https://github.com/dreamfactorysoftware/dsp-core/wiki/CORs-Configuration).

#####Running the example iOS Address Book app
From the Apps menu in the DreamFactory Admin Console, click import and select "Address Book" from the list of sample applications. Set the storage service to local file storage and the storage container to applications. Click the Update button when done.

Almost there! Download this repo to your local machine. Open and run the project in Xcode. You can log in to the app with the username and password you used for the DreamFactory Admin Console.

The default DreamFactory Admin Console URL is localhost:8080. If your DreamFactory Admin Console is not at that path, you can change the default path in MasterViewController.h

#####Set up new user registration
To allow new users to register in the Address Book app you need to create a new role:

1. From the DreamFactory Admin Console, click roles then click Create
2. Enter a name and description for the role
3. Go to the Access tab
4. Create a new service under Server Access
  - set Service = All
  - set Component = *
  - check all HTTP verbs under Access
  - set Requester = API
5. Under the Apps tab make the address book the default
6. Click Create Role
7. Click the Config tab, then go to Open Registration
8. Check Allow Open Registration
9. Set the default role to the name of the role you created

Example API calls 
==============
More info on the DreamFactory iOS API is available [here](../api). 

Each example has a link to where the call is made in code as well as a short excerpt showing the most important part of the call.

### Examples of log in and registration: 
  - [MasterViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/MasterViewController.m#L82-L127)
  - [RegisterViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/RegisterViewController.m#L52-L97)
``` Objective-C
// build rest path for request, form is <url to server>/rest/serviceName/resourcePath
NSString *serviceName = @"user"; // your service name here
NSString *resourcePath = @"session"; // rest path
NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",baseUrl,serviceName, resourcePath];

NSDictionary* requestBody = @{@"email":self.emailTextField.text,
                              @"password":self.passwordTextField.text};
```

### Examples of fetching records

#####all records in table: 
  - [AddressBookViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/AddressBookViewController.m#L125-L177)
```Objective-C
// build rest path for request, form is <url to server>/rest/serviceName/tableName
NSString *serviceName = @"db"; // your service name here
NSString *tableName = @"contact_groups";

NSString *restApiPath = [NSString stringWithFormat:@"%@/%@/%@",baseUrl,serviceName, tableName];

// passing no query params will get all the records from a table
NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];

// header has session id and application name to validate access
NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
[headerParams setObject:kApplicationName forKey:@"X-DreamFactory-Application-Name"];
[headerParams setObject:swgSessionId forKey:@"X-DreamFactory-Session-Token"];

NSString* contentType = @"application/json";
id requestBody = nil; 
```

#####with fields: 
  - [GroupAddViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/GroupAddViewController.m#L310-L403)
```Objective-C
// only need to get the contactId and full contact name
// set the fields param to give us just the fields we need
queryParams[@"fields"] = @"contactId,firstName,lastName";
```

#####with filter: 
  - [GroupAddViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/GroupAddViewController.m#L592-L638)
  - [ContactViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactViewController.m#L423-L496)
``` Objective-C
  // create filter to get only the contact in the group
  NSString *filter = [NSString stringWithFormat:@"contactGroupId=%@", self.groupRecord.Id];
  queryParams[@"filter"] = filter;
```

#####with relation: 
  - [ContactListViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactListViewController.m#L336-L495)
  - [ContactViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactViewController.m#L591-L672)
``` Objective-C
// only get contactrelationships for this contact
NSString *filter = [NSString stringWithFormat:@"contactId=%@", self.contactRecord.Id];
queryParams[@"filter"] = filter;

// request without related would return just {id, groupId, contactId}
// set the related field to go get the group records referenced by
// each contactrelationships record
queryParams[@"related"] = @"contact_groups_by_contactGroupId";
```

### Examples of updating records

#####single record:
  - [ContactEditViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactEditViewController.m#L616-L665)
  - [GroupAddViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/GroupAddViewController.m#L543-L562)
``` Objective-C
// set the id of the contact we are looking at
queryParams[@"ids"] = [self.groupRecord.Id stringValue];

// already know the record id from query, so request is just new name
NSDictionary *requestBody = @{@"groupName":self.groupNameTextField.text};
```

#####multiple records:
  - [ContactEditViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactEditViewController.m#L674-L724)
``` Objective-C
// build request body
NSMutableArray* records = [[NSMutableArray alloc] init];
for(UIView* view in [self.contactEditScrollView subviews]){
    if([view isKindOfClass:[ContactInfoView class]]){
        ContactInfoView* contactInfoView = (ContactInfoView*) view;
        if(contactInfoView.record.ContactId != nil){
            [contactInfoView updateRecord];
            [records addObject: [contactInfoView buildToDictionary]];
        }
    }
}
// make an array out of each record to update, then send the whole array
NSDictionary *requestBody = @{@"record": records};
```

###Examples of creating records
#####records with references:
  - [ContactEditViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactEditViewController.m#L297-L361)
  - [GroupAddViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/GroupAddViewController.m#L407-L453)
  
#####single record: 
  - [GroupAddViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/GroupAddViewController.m#L412-L450)
  - [ContactEditViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactEditViewController.m#L370-L410)
``` Objective-C
// build reques body, just need to post the name, table is {groupId, groupName}
NSDictionary *requestBody = @{@"groupName": self.groupNameTextField.text};
```

#####multiple records:
  - [ContactEditViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactEditViewController.m#L420-L498)
  - [GroupAddViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/GroupAddViewController.m#L469-L529)
``` Objective-C
NSMutableArray* records = [[NSMutableArray alloc] init];
for(NSNumber* contactId in self.selectedRows){
    [records addObject:@{@"contactGroupId":groupId,@"contactId":contactId}];
}

/*
 *  structure of request is:
 *  {
 *      "records":[
 *          {
 *             "contactGroupId":id,
 *             "contactId":id"
 *          },
 *          {...}
 *      ]
 *  }
 */
NSDictionary *requestBody = @{@"record": records};
```

### Examples of deleting records

#####records with references: 
  - [ContactListViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactListViewController.m#L281-L285)
  - [AddressBookViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/AddressBookViewController.m#L73-L79)

#####with filter: 
  - [AddressBookViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/AddressBookViewController.m#L186-L227)
  - [ContactListViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactListViewController.m#L504-L542)
  - [ContactListViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactListViewController.m#L551-L589)
```Objective-C
// create filter to select all contactrelationships records that
// reference the group being deleted
NSString *filter = [NSString stringWithFormat:@"contactGroupId=%@", [groupId stringValue]];
queryParams[@"filter"] = filter;
```

#####with Ids:
  - [AddressBookViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/AddressBookViewController.m#L237-L273)
  - [ContactListViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactListViewController.m#L647-L689)
``` Objective-C
// delete the record by the record ID
// form is "ids":"1,2,3"
queryParams[@"ids"] = [groupId stringValue];
```

#####with different identifying field:
  - [GroupAddViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/GroupAddViewController.m#L654-L707)
``` Objective-C
// do not know the ID of the record to remove
// one value for groupId, but many values for contactId
// instead of making a long SQL query, change what we use as identifiers
queryParams[@"id_field"] = @"contactGroupId,contactId";

NSMutableArray* requestRecordsArray = [[NSMutableArray alloc] init];
/*
 * Form of request is:
 *  {
 *      "record":[
 *          {
 *              "contactGroupId":id,
 *              "contactId":id
 *          },
 *          {...}
 *      ]
 *  }
 */

for(NSNumber* recordId in self.contactsAlreadyInGroupContentsArray){
    [requestRecordsArray addObject:@{@"contactGroupId":self.groupRecord.Id, 
                                     @"contactId":recordId}];
}
NSDictionary* requestBody = @{@"record":requestRecordsArray};
```

### Examples of working with files and folders

#####getting a file:
  - [ContactViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactViewController.m#L514-L577)
``` Objective-C
// build rest path for request, form is:
// <url to server>/rest/files/container/application/<folder path>/filename
// here the folder path is profile_images/contactId/
// the file path does not end in a '/' because we are targeting a file not a folder
NSString* container_name = @"applications";
NSString* folder_path = [NSString stringWithFormat:@"profile_images/%@", 
                                        [self.contactRecord.Id stringValue]];
NSString* file_name = self.contactRecord.ImageUrl;

NSString *restApiPath = [NSString stringWithFormat:  @"%@/files/%@/%@/%@/%@",
                                                      baseUrl,
                                                      container_name, 
                                                      kApplicationName, 
                                                      folder_path, 
                                                      file_name];

// request a download from the file
NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
queryParams[@"include_properties"] = [NSNumber numberWithBool:YES];
queryParams[@"content"] = [NSNumber numberWithBool:YES];
queryParams[@"download"] = [NSNumber numberWithBool:YES];

... get the file ...
// decode the file
NSData *fileData = [[NSData alloc] 
                      initWithBase64EncodedString: [responseDict objectForKey:@"content"]
                      options:NSDataBase64DecodingIgnoreUnknownCharacters];
```

#####creating a file / uploading an image:
  - [ContactEditViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactEditViewController.m#L557-L607)
``` Objective-C
// build rest path for request, form is:
// <url to server>/rest/files/container/application/<folder path>/filename
// here the folder path is profile_images/contactId/
// the file path does not end in a '/' because we are targeting a file not a folder
NSString* containerName = @"applications";
NSString* folderPath = [NSString stringWithFormat:@"profile_images/%@", 
                        [self.contactRecord.Id stringValue]];
NSString* fileName = @"UserFile1.jpg"; // example default file name
if([self.imageUrl length] > 0){
  fileName = [NSString stringWithFormat:@"%@.jpg", self.imageUrl];
}
NSString *restApiPath = [NSString stringWithFormat:  @"%@/files/%@/%@/%@/%@",
                                                      baseUrl,
                                                      containerName, 
                                                      kApplicationName, 
                                                      folderPath, 
                                                      fileName];

// encode the image and send it up in a NIKFile
NSData* imageData = UIImageJPEGRepresentation(image, 0.1);
NIKFile* file = [[NIKFile alloc] initWithNameData:fileName 
                                         mimeType:@"application/octet-stream" 
                                             data:imageData];
```

#####getting contents of a folder:
  - [ProfileImagePickerViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ProfileImagePickerViewController.m#L130-L191)
``` Objective-C
// build rest path for request, form is 
// <url to server>/rest/files/container/application/<folder path>/
// here the folder path is profile_images/contactId/
NSString* containerName = @"applications";
NSString* folderPath = [NSString stringWithFormat:@"profile_images/%@", 
                        [self.record.Id stringValue]];
// note that you need the extra '/' here at the end of the api path because you are
// targeting a folder not a file
NSString *restApiPath = [NSString stringWithFormat:  @"%@/files/%@/%@/%@/",
                                                      baseUrl,
                                                      containerName, 
                                                      kApplicationName, 
                                                      folderPath];
                                                      
NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
// only want to get files, not any sub folders
queryParams[@"include_folders"] = [NSNumber numberWithBool:NO];
queryParams[@"include_files"] = [NSNumber numberWithBool:YES];

... get the contents of the file ...

for(NSDictionary* fileDict in [responseDict objectForKey:@"file"]){
  [self.imageListContentArray addObject:[fileDict objectForKey:@"name"]];
}
```

#####creating a folder:
  - [ContactEditViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactEditViewController.m#L506-L549)
``` Objective-C
// build rest path for request, form is 
// <url to server>/rest/files/container/application/<folder path>/
// here the folder path is profile_images/contactId/
NSString* containerName = @"applications";
NSString* folderPath = [NSString stringWithFormat:@"profile_images/%@", 
                        [self.contactRecord.Id stringValue]];
                        
// note that you need the extra '/' here at the end of the api path because
// it is targeting a folder, not a file
NSString *restApiPath = [NSString stringWithFormat:  @"%@/files/%@/%@/%@/",
                                                      baseUrl,
                                                      containerName, 
                                                      kApplicationName,
                                                      folderPath];
```

#####deleting a folder:
  - [ContactListViewController](https://github.com/ConnorFoody/DreamFactory-ios-app/blob/master/example-ios/SampleApp/ContactListViewController.m#L598-L638)
``` Objective-C
// build rest path for request, form is 
// <url to server>/rest/files/container/application/<folder path>/
// here the folder path is profile_images/contactId/
NSString* containerName = @"applications";
NSString* folderPath = [NSString stringWithFormat:@"profile_images/%@", 
                        [contactId stringValue]];
// note that you need the extra '/' here at the end of the api path because
// the url is pointing to a folder
NSString *restApiPath = [NSString stringWithFormat:  @"%@/files/%@/%@/%@/",
                                                      baseUrl,
                                                      containerName, 
                                                      kApplicationName, 
                                                      folderPath];
                                                      
NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
// delete all files and folders in the target folder
queryParams[@"force"] = [NSNumber numberWithBool:YES];
```

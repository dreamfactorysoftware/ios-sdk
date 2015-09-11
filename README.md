Address Book for iOS
====================

This repo contains a sample address book application for iOS that demonstrates how to use the DreamFactory REST API. It includes new user registration, user login, and CRUD for related tables.

#Getting DreamFactory on your local machine

To download and install DreamFactory, follow the instructions [here](https://github.com/dreamfactorysoftware/dsp-core/wiki/Usage-Options). Alternatively, you can create a [free hosted developer account](http://www.dreamfactory.com) at www.dreamfactory.com if you don't want to install DreamFactory locally.

#Configuring your DreamFactory instance to run the app

- Enable [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) for development purposes.
    - In the admin console, navigate to the Config tab and click on CORS in the left sidebar.
    - Click Add.
    - Set Origin, Paths, and Headers to *.
    - Set Max Age to 0.
    - Allow all HTTP verbs and check the Enabled box.
    - Click update when you are done.
    - More info on setting up CORS is available [here](https://github.com/dreamfactorysoftware/dsp-core/wiki/CORs-Configuration).

- Create a default role for new users and enable open registration
    - In the admin console, click the Roles tab then click Create in the left sidebar.
    - Enter a name for the role and check the Active box.
    - Go to the Access tab.
    - Add a new entry under Service Access (you can make it more restrictive later).
        - set Service = All
        - set Component = *
        - check all HTTP verbs under Access
        - set Requester = API
    - Click Create Role.
    - Click the Services tab, then edit the user service. Go to Config and enable Allow Open Registration.
    - Set the Open Reg Role Id to the name of the role you just created.
    - Make sure Open Reg Email Service Id is blank, so that new users can register without email confirmation.
    - Save changes.

- Import the package file for the app.
    - From the Apps tab in the admin console, click Import and click 'Address Book for iOS' in the list of sample apps. The Address Book package contains the application description, schemas, and sample data.
    - Leave storage service and folder blank. This is a native iOS app so it requires no file storage on the server.
    - Click the Import button. If successful, your app will appear on the Apps tab. You may have to refresh the page to see your new app in the list.
    
- Make sure you have a SQL database service named 'db'. Depending on how you installed DreamFactory you may or may not have a 'db' service already available on your instance. You can add one by going to the Services tab in the admin console and creating a new SQL service. Make sure you set the name to 'db'.

#Running the Address Book app

Almost there! Clone this repo to your local machine then open and run the project with Xcode.

Before running the project you need to edit API_KEY in the file MasterViewController.h to match the key for your new app. This key can be found by selecting your app from the list on the Apps tab in the admin console.

The default admin console URL is localhost:8080. If your admin console is not at that path, you can change the default path in MasterViewController.h.

When the app starts up you can register a new user, or log in as an existing user. Currently the app does not support registering and logging in admin users.

#Example API calls

The DreamFactory iOS API is a super light wrapper on NSUrl HTTP requests. All of the request formatting is exposed in case you want to roll your own code or use a third-party library to send requests.

The general form of a DreamFactory REST API call is: 

`<rest-verb> http[s]://<server-name>/rest/[<service-api-name>]/[<resource-path>][?<param-name>=<param-value>]`

The iOS API format is: 

```Objective-C
  NIKApiInvoker restPath: (NSString*) path
                  method: (NSString*) method
             queryParams: (NSDictionary*) queryParams
                    body: (id) body
            headerParams: (NSDictionary*) headerParams
             contentType: (NSString*) contentType
         completionBlock: (void (^)(NSDictionary*, NSError *))completionBlock;
```

Breaking down each parameter:
  - **path** Holds the value of `http[s]://<server-name>/rest/[<service-api-name>]/[<resource-path>]` from the generic call. You can include the query parameters here. However, it is easier and cleaner to pass in the query parameters as a dictionary than it is to format them into the url. 
  - **method** The REST verb.
  - **queryParams** Holds the query parameters.
  - **body** Request body, usually  a dictionary, array or NIKFile.
  - **headerParams** Users using 1.* need to include the session id and the application name.
  - **contentType** Either json or xml.
  - **completionBlock** Block to be run once the request is completed. 
  
### Examples of log in and registration: 
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
```Objective-C
// only need to get the contactId and full contact name
// set the fields param to give us just the fields we need
queryParams[@"fields"] = @"contactId,firstName,lastName";
```

#####with filter: 
``` Objective-C
  // create filter to get only the contact in the group
  NSString *filter = [NSString stringWithFormat:@"contactGroupId=%@", self.groupRecord.Id];
  queryParams[@"filter"] = filter;
```

#####with relation: 
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
``` Objective-C
// set the id of the contact we are looking at
queryParams[@"ids"] = [self.groupRecord.Id stringValue];

// already know the record id from query, so request is just new name
NSDictionary *requestBody = @{@"groupName":self.groupNameTextField.text};
```

#####multiple records:
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
  
#####single record: 
``` Objective-C
// build reques body, just need to post the name, table is {groupId, groupName}
NSDictionary *requestBody = @{@"groupName": self.groupNameTextField.text};
```

#####multiple records:
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

#####with filter: 
```Objective-C
// create filter to select all contactrelationships records that
// reference the group being deleted
NSString *filter = [NSString stringWithFormat:@"contactGroupId=%@", [groupId stringValue]];
queryParams[@"filter"] = filter;
```

#####with Ids:
``` Objective-C
// delete the record by the record ID
// form is "ids":"1,2,3"
queryParams[@"ids"] = [groupId stringValue];
```

#####with different identifying field:
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

#Additional Resources

More detailed information on the DreamFactory REST API is available [here](https://github.com/dreamfactorysoftware/dsp-core/wiki/REST-API).

The live API documentation included in the admin console is a great way to learn how the DreamFactory REST API works.
Check out how to use the live API docs [here](https://github.com/dreamfactorysoftware/dsp-core/wiki/API-Docs).
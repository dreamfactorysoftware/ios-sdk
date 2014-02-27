#import <Foundation/Foundation.h>
#import "NIKApiInvoker.h"
#import "SWGFileResponse.h"
#import "SWGContainer.h"
#import "SWGFolderRequest.h"
#import "SWGContainerRequest.h"
#import "SWGFolder.h"
#import "SWGContainersResponse.h"
#import "SWGFileRequest.h"
#import "SWGContainersRequest.h"
#import "SWGFolderResponse.h"
#import "SWGFile.h"
#import "SWGContainerResponse.h"


@interface SWGAppApi: NSObject {

@private
    NSOperationQueue *_queue;
    NIKApiInvoker * _api;
}
@property(nonatomic, readonly) NSOperationQueue* queue;
@property(nonatomic, readonly) NIKApiInvoker* api;

-(void) addHeader:(NSString*)value forKey:(NSString*)key;

/**

 getContainers() - List all containers.
 List the names of the available containers in this storage. Use 'include_properties' to include any properties of the containers.
 @param include_properties Return any properties of the container in the response.
 */
-(void) getContainersWithCompletionBlock :(NSNumber*) include_properties 
        completionHandler: (void (^)(SWGContainersResponse* output, NSError* error))completionBlock;

/**

 createContainers() - Create one or more containers.
 Post data should be a single container definition or an array of container definitions. Alternatively, override the HTTP Method to pass containers to other actions.
 @param body Array of containers to create.
 @param check_exist If true, the request fails when the container to create already exists.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createContainersWithCompletionBlock :(SWGContainersRequest*) body 
        check_exist:(NSNumber*) check_exist 
        X-HTTP-METHOD:(NSString*) X-HTTP-METHOD 
        completionHandler: (void (^)(SWGContainersResponse* output, NSError* error))completionBlock;

/**

 deleteContainers() - Delete one or more containers.
 Pass a comma-delimited list of container names to delete. Set 'force' to true to delete all containers. Alternatively, to delete by container records or a large list of names, use the POST request with X-HTTP-METHOD = DELETE header and post containers.
 @param names List of containers to delete.
 @param force Set force to true to delete all containers, otherwise 'names' parameter is required.
 */
-(void) deleteContainersWithCompletionBlock :(NSString*) names 
        force:(NSNumber*) force 
        completionHandler: (void (^)(SWGContainersResponse* output, NSError* error))completionBlock;

/**

 getContainer() - List the container's content, including properties.
 Use 'include_properties' to get properties of the container. Use the 'include_folders' and/or 'include_files' to modify the listing.
 @param container The name of the container from which you want to retrieve contents.
 @param include_properties Include any properties of the container in the response.
 @param include_folders Include folders in the returned listing.
 @param include_files Include files in the returned listing.
 @param full_tree List the contents of all sub-folders as well.
 @param zip Return the content of the folder as a zip file.
 */
-(void) getContainerWithCompletionBlock :(NSString*) container 
        include_properties:(NSNumber*) include_properties 
        include_folders:(NSNumber*) include_folders 
        include_files:(NSNumber*) include_files 
        full_tree:(NSNumber*) full_tree 
        zip:(NSNumber*) zip 
        completionHandler: (void (^)(SWGContainerResponse* output, NSError* error))completionBlock;

/**

 createContainer() - Create container and/or add content.
 Post data as an array of folders and/or files.
 @param container The name of the container you want to put the contents.
 @param body Array of folders and/or files.
 @param url The full URL of the file to upload.
 @param extract Extract an uploaded zip file into the container.
 @param clean Option when 'extract' is true, clean the current folder before extracting files and folders.
 @param check_exist If true, the request fails when the file or folder to create already exists.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createContainerWithCompletionBlock :(NSString*) container 
        body:(SWGContainerRequest*) body 
        url:(NSString*) url 
        extract:(NSNumber*) extract 
        clean:(NSNumber*) clean 
        check_exist:(NSNumber*) check_exist 
        X-HTTP-METHOD:(NSString*) X-HTTP-METHOD 
        completionHandler: (void (^)(SWGContainerResponse* output, NSError* error))completionBlock;

/**

 updateContainerProperties() - Update properties of the container.
 Post data as an array of container properties.
 @param container The name of the container you want to put the contents.
 @param body An array of container properties.
 */
-(void) updateContainerPropertiesWithCompletionBlock :(NSString*) container 
        body:(SWGContainer*) body 
        completionHandler: (void (^)(SWGContainer* output, NSError* error))completionBlock;

/**

 deleteContainer() - Delete one container and/or its contents.
 Set 'content_only' to true to delete the folders and files contained, but not the container. Set 'force' to true to delete a non-empty container. Alternatively, to delete by a listing of folders and files, use the POST request with X-HTTP-METHOD = DELETE header and post listing.
 @param container The name of the container you want to delete from.
 @param force Set to true to force delete on a non-empty container.
 @param content_only Set to true to only delete the content of the container.
 */
-(void) deleteContainerWithCompletionBlock :(NSString*) container 
        force:(NSNumber*) force 
        content_only:(NSNumber*) content_only 
        completionHandler: (void (^)(SWGContainerResponse* output, NSError* error))completionBlock;

/**

 getFolder() - List the folder's content, including properties.
 Use 'include_properties' to get properties of the folder. Use the 'include_folders' and/or 'include_files' to modify the listing.
 @param container The name of the container from which you want to retrieve contents.
 @param folder_path The path of the folder you want to retrieve. This can be a sub-folder, with each level separated by a '/'
 @param include_properties Return any properties of the folder in the response.
 @param include_folders Include folders in the returned listing.
 @param include_files Include files in the returned listing.
 @param full_tree List the contents of all sub-folders as well.
 @param zip Return the content of the folder as a zip file.
 */
-(void) getFolderWithCompletionBlock :(NSString*) container 
        folder_path:(NSString*) folder_path 
        include_properties:(NSNumber*) include_properties 
        include_folders:(NSNumber*) include_folders 
        include_files:(NSNumber*) include_files 
        full_tree:(NSNumber*) full_tree 
        zip:(NSNumber*) zip 
        completionHandler: (void (^)(SWGFolderResponse* output, NSError* error))completionBlock;

/**

 createFolder() - Create a folder and/or add content.
 Post data as an array of folders and/or files. Folders are created if they do not exist
 @param container The name of the container where you want to put the contents.
 @param folder_path The path of the folder where you want to put the contents. This can be a sub-folder, with each level separated by a '/'
 @param body Array of folders and/or files.
 @param url The full URL of the file to upload.
 @param extract Extract an uploaded zip file into the folder.
 @param clean Option when 'extract' is true, clean the current folder before extracting files and folders.
 @param check_exist If true, the request fails when the file or folder to create already exists.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createFolderWithCompletionBlock :(NSString*) container 
        folder_path:(NSString*) folder_path 
        body:(SWGFolderRequest*) body 
        url:(NSString*) url 
        extract:(NSNumber*) extract 
        clean:(NSNumber*) clean 
        check_exist:(NSNumber*) check_exist 
        X-HTTP-METHOD:(NSString*) X-HTTP-METHOD 
        completionHandler: (void (^)(SWGFolderResponse* output, NSError* error))completionBlock;

/**

 updateFolderProperties() - Update folder properties.
 Post body as an array of folder properties.
 @param container The name of the container where you want to put the contents.
 @param folder_path The path of the folder you want to update. This can be a sub-folder, with each level separated by a '/'
 @param body Array of folder properties.
 */
-(void) updateFolderPropertiesWithCompletionBlock :(NSString*) container 
        folder_path:(NSString*) folder_path 
        body:(SWGFolder*) body 
        completionHandler: (void (^)(SWGFolder* output, NSError* error))completionBlock;

/**

 deleteFolder() - Delete one folder and/or its contents.
 Set 'content_only' to true to delete the sub-folders and files contained, but not the folder. Set 'force' to true to delete a non-empty folder. Alternatively, to delete by a listing of sub-folders and files, use the POST request with X-HTTP-METHOD = DELETE header and post listing.
 @param container The name of the container where the folder exists.
 @param folder_path The path of the folder where you want to delete contents. This can be a sub-folder, with each level separated by a '/'
 @param force Set to true to force delete on a non-empty folder.
 @param content_only Set to true to only delete the content of the folder.
 */
-(void) deleteFolderWithCompletionBlock :(NSString*) container 
        folder_path:(NSString*) folder_path 
        force:(NSNumber*) force 
        content_only:(NSNumber*) content_only 
        completionHandler: (void (^)(SWGFolderResponse* output, NSError* error))completionBlock;

/**

 getFile() - Download the file contents and/or its properties.
 By default, the file is streamed to the browser. Use the 'download' parameter to prompt for download. Use the 'include_properties' parameter (optionally add 'content' to include base64 content) to list properties of the file.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to retrieve.
 @param include_properties Return properties of the file.
 @param content Return the content as base64 of the file, only applies when 'include_properties' is true.
 @param download Prompt the user to download the file from the browser.
 */
-(void) getFileWithCompletionBlock :(NSString*) container 
        file_path:(NSString*) file_path 
        include_properties:(NSNumber*) include_properties 
        content:(NSNumber*) content 
        download:(NSNumber*) download 
        completionHandler: (void (^)(SWGFileResponse* output, NSError* error))completionBlock;

/**

 createFile() - Create a new file.
 Post body should be the contents of the file or an object with file properties.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to create.
 @param check_exist If true, the request fails when the file to create already exists.
 @param body Content and/or properties of the file.
 */
-(void) createFileWithCompletionBlock :(NSString*) container 
        file_path:(NSString*) file_path 
        check_exist:(NSNumber*) check_exist 
        body:(SWGFileRequest*) body 
        completionHandler: (void (^)(SWGFileResponse* output, NSError* error))completionBlock;

/**

 replaceFile() - Update content of the file.
 Post body should be the contents of the file.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to update.
 @param body The content of the file.
 */
-(void) replaceFileWithCompletionBlock :(NSString*) container 
        file_path:(NSString*) file_path 
        body:(SWGFileRequest*) body 
        completionHandler: (void (^)(SWGFileResponse* output, NSError* error))completionBlock;

/**

 updateFileProperties() - Update properties of the file.
 Post body should be an array of file properties.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to update.
 @param body Properties of the file.
 */
-(void) updateFilePropertiesWithCompletionBlock :(NSString*) container 
        file_path:(NSString*) file_path 
        body:(SWGFile*) body 
        completionHandler: (void (^)(SWGFile* output, NSError* error))completionBlock;

/**

 deleteFile() - Delete one file.
 Careful, this removes the given file from the storage.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to delete.
 */
-(void) deleteFileWithCompletionBlock :(NSString*) container 
        file_path:(NSString*) file_path 
        completionHandler: (void (^)(SWGFileResponse* output, NSError* error))completionBlock;

@end

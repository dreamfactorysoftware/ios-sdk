#import <Foundation/Foundation.h>
#import "NIKApiInvoker.h"
#import "RVBFileResponse.h"
#import "RVBContainer.h"
#import "RVBFolderRequest.h"
#import "RVBContainerRequest.h"
#import "RVBFolder.h"
#import "RVBContainersResponse.h"
#import "RVBFileRequest.h"
#import "RVBContainersRequest.h"
#import "RVBFolderResponse.h"
#import "RVBFile.h"
#import "RVBContainerResponse.h"


@interface RVBRsFilesDFWApi: NSObject {

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
-(void) getContainersWithCompletionBlock :(RVBNSNumber**) include_properties 
        completionHandler: (void (^)(RVBContainersResponse* output, NSError* error))completionBlock;

/**

 createContainers() - Create one or more containers.
 Post data should be a single container definition or an array of container definitions. Alternatively, override the HTTP Method to pass containers to other actions.
 @param body Array of containers to create.
 @param check_exist If true, the request fails when the container to create already exists.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createContainersWithCompletionBlock :(RVBRVBContainersRequest**) body 
        check_exist:(RVBNSNumber**) check_exist 
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 
        completionHandler: (void (^)(RVBContainersResponse* output, NSError* error))completionBlock;

/**

 deleteContainers() - Delete one or more containers.
 Pass a comma-delimited list of container names to delete. Set 'force' to true to delete all containers. Alternatively, to delete by container records or a large list of names, use the POST request with X-HTTP-METHOD = DELETE header and post containers.
 @param names List of containers to delete.
 @param force Set force to true to delete all containers, otherwise 'names' parameter is required.
 */
-(void) deleteContainersWithCompletionBlock :(RVBNSString**) names 
        force:(RVBNSNumber**) force 
        completionHandler: (void (^)(RVBContainersResponse* output, NSError* error))completionBlock;

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
-(void) getContainerWithCompletionBlock :(RVBNSString**) container 
        include_properties:(RVBNSNumber**) include_properties 
        include_folders:(RVBNSNumber**) include_folders 
        include_files:(RVBNSNumber**) include_files 
        full_tree:(RVBNSNumber**) full_tree 
        zip:(RVBNSNumber**) zip 
        completionHandler: (void (^)(RVBContainerResponse* output, NSError* error))completionBlock;

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
-(void) createContainerWithCompletionBlock :(RVBNSString**) container 
        body:(RVBRVBContainerRequest**) body 
        url:(RVBNSString**) url 
        extract:(RVBNSNumber**) extract 
        clean:(RVBNSNumber**) clean 
        check_exist:(RVBNSNumber**) check_exist 
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 
        completionHandler: (void (^)(RVBContainerResponse* output, NSError* error))completionBlock;

/**

 updateContainerProperties() - Update properties of the container.
 Post data as an array of container properties.
 @param container The name of the container you want to put the contents.
 @param body An array of container properties.
 */
-(void) updateContainerPropertiesWithCompletionBlock :(RVBNSString**) container 
        body:(RVBRVBContainer**) body 
        completionHandler: (void (^)(RVBContainer* output, NSError* error))completionBlock;

/**

 deleteContainer() - Delete one container and/or its contents.
 Set 'content_only' to true to delete the folders and files contained, but not the container. Set 'force' to true to delete a non-empty container. Alternatively, to delete by a listing of folders and files, use the POST request with X-HTTP-METHOD = DELETE header and post listing.
 @param container The name of the container you want to delete from.
 @param force Set to true to force delete on a non-empty container.
 @param content_only Set to true to only delete the content of the container.
 */
-(void) deleteContainerWithCompletionBlock :(RVBNSString**) container 
        force:(RVBNSNumber**) force 
        content_only:(RVBNSNumber**) content_only 
        completionHandler: (void (^)(RVBContainerResponse* output, NSError* error))completionBlock;

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
-(void) getFolderWithCompletionBlock :(RVBNSString**) container 
        folder_path:(RVBNSString**) folder_path 
        include_properties:(RVBNSNumber**) include_properties 
        include_folders:(RVBNSNumber**) include_folders 
        include_files:(RVBNSNumber**) include_files 
        full_tree:(RVBNSNumber**) full_tree 
        zip:(RVBNSNumber**) zip 
        completionHandler: (void (^)(RVBFolderResponse* output, NSError* error))completionBlock;

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
-(void) createFolderWithCompletionBlock :(RVBNSString**) container 
        folder_path:(RVBNSString**) folder_path 
        body:(RVBRVBFolderRequest**) body 
        url:(RVBNSString**) url 
        extract:(RVBNSNumber**) extract 
        clean:(RVBNSNumber**) clean 
        check_exist:(RVBNSNumber**) check_exist 
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 
        completionHandler: (void (^)(RVBFolderResponse* output, NSError* error))completionBlock;

/**

 updateFolderProperties() - Update folder properties.
 Post body as an array of folder properties.
 @param container The name of the container where you want to put the contents.
 @param folder_path The path of the folder you want to update. This can be a sub-folder, with each level separated by a '/'
 @param body Array of folder properties.
 */
-(void) updateFolderPropertiesWithCompletionBlock :(RVBNSString**) container 
        folder_path:(RVBNSString**) folder_path 
        body:(RVBRVBFolder**) body 
        completionHandler: (void (^)(RVBFolder* output, NSError* error))completionBlock;

/**

 deleteFolder() - Delete one folder and/or its contents.
 Set 'content_only' to true to delete the sub-folders and files contained, but not the folder. Set 'force' to true to delete a non-empty folder. Alternatively, to delete by a listing of sub-folders and files, use the POST request with X-HTTP-METHOD = DELETE header and post listing.
 @param container The name of the container where the folder exists.
 @param folder_path The path of the folder where you want to delete contents. This can be a sub-folder, with each level separated by a '/'
 @param force Set to true to force delete on a non-empty folder.
 @param content_only Set to true to only delete the content of the folder.
 */
-(void) deleteFolderWithCompletionBlock :(RVBNSString**) container 
        folder_path:(RVBNSString**) folder_path 
        force:(RVBNSNumber**) force 
        content_only:(RVBNSNumber**) content_only 
        completionHandler: (void (^)(RVBFolderResponse* output, NSError* error))completionBlock;

/**

 getFile() - Download the file contents and/or its properties.
 By default, the file is streamed to the browser. Use the 'download' parameter to prompt for download. Use the 'include_properties' parameter (optionally add 'content' to include base64 content) to list properties of the file.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to retrieve.
 @param include_properties Return properties of the file.
 @param content Return the content as base64 of the file, only applies when 'include_properties' is true.
 @param download Prompt the user to download the file from the browser.
 */
-(void) getFileWithCompletionBlock :(RVBNSString**) container 
        file_path:(RVBNSString**) file_path 
        include_properties:(RVBNSNumber**) include_properties 
        content:(RVBNSNumber**) content 
        download:(RVBNSNumber**) download 
        completionHandler: (void (^)(RVBFileResponse* output, NSError* error))completionBlock;

/**

 createFile() - Create a new file.
 Post body should be the contents of the file or an object with file properties.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to create.
 @param check_exist If true, the request fails when the file to create already exists.
 @param body Content and/or properties of the file.
 */
-(void) createFileWithCompletionBlock :(RVBNSString**) container 
        file_path:(RVBNSString**) file_path 
        check_exist:(RVBNSNumber**) check_exist 
        body:(RVBRVBFileRequest**) body 
        completionHandler: (void (^)(RVBFileResponse* output, NSError* error))completionBlock;

/**

 replaceFile() - Update content of the file.
 Post body should be the contents of the file.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to update.
 @param body The content of the file.
 */
-(void) replaceFileWithCompletionBlock :(RVBNSString**) container 
        file_path:(RVBNSString**) file_path 
        body:(RVBRVBFileRequest**) body 
        completionHandler: (void (^)(RVBFileResponse* output, NSError* error))completionBlock;

/**

 updateFileProperties() - Update properties of the file.
 Post body should be an array of file properties.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to update.
 @param body Properties of the file.
 */
-(void) updateFilePropertiesWithCompletionBlock :(RVBNSString**) container 
        file_path:(RVBNSString**) file_path 
        body:(RVBRVBFile**) body 
        completionHandler: (void (^)(RVBFile* output, NSError* error))completionBlock;

/**

 deleteFile() - Delete one file.
 Careful, this removes the given file from the storage.
 @param container Name of the container where the file exists.
 @param file_path Path and name of the file to delete.
 */
-(void) deleteFileWithCompletionBlock :(RVBNSString**) container 
        file_path:(RVBNSString**) file_path 
        completionHandler: (void (^)(RVBFileResponse* output, NSError* error))completionBlock;

@end

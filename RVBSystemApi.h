#import <Foundation/Foundation.h>
#import "NIKApiInvoker.h"
#import "RVBConstant.h"
#import "RVBRolesResponse.h"
#import "RVBAppGroupsResponse.h"
#import "RVBCustomSettings.h"
#import "RVBUsersRequest.h"
#import "RVBAppGroup.h"
#import "RVBEmailTemplateRequest.h"
#import "RVBUserRequest.h"
#import "RVBConfigResponse.h"
#import "RVBCustomSetting.h"
#import "RVBEmailTemplatesRequest.h"
#import "RVBServiceResponse.h"
#import "RVBServiceRequest.h"
#import "RVBRoleRequest.h"
#import "RVBServicesResponse.h"
#import "RVBAppsRequest.h"
#import "RVBAppGroupResponse.h"
#import "RVBConstants.h"
#import "RVBResources.h"
#import "RVBEmailTemplatesResponse.h"
#import "RVBAppsResponse.h"
#import "RVBEmailTemplateResponse.h"
#import "RVBSuccess.h"
#import "RVBServicesRequest.h"
#import "RVBAppRequest.h"
#import "RVBAppGroupsRequest.h"
#import "RVBAppGroupRequest.h"
#import "RVBRolesRequest.h"
#import "RVBUserResponse.h"
#import "RVBAppResponse.h"
#import "RVBUsersResponse.h"
#import "RVBRoleResponse.h"
#import "RVBConfigRequest.h"


@interface RVBSystemApi: NSObject {

@private
    NSOperationQueue *_queue;
    NIKApiInvoker * _api;
}
@property(nonatomic, readonly) NSOperationQueue* queue;
@property(nonatomic, readonly) NIKApiInvoker* api;

-(void) addHeader:(NSString*)value forKey:(NSString*)key;

/**

 getResources() - List resources available for system management.
 See listed operations for each resource available.
 */
-(void) getResourcesWithCompletionBlock :(void (^)(RVBResources* output, NSError* error))completionBlock;

/**

 getApps() - Retrieve one or more applications.
 Use the 'ids' or 'filter' parameter to limit records that are returned. By default, all records up to the maximum are returned. <br>Use the 'fields' and 'related' parameters to limit properties returned for each record. By default, all fields and no relations are returned for each record. <br>Alternatively, to retrieve by record, a large list of ids, or a complicated filter, use the POST request with X-HTTP-METHOD = GET header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to retrieve.
 @param filter SQL-like filter to limit the records to retrieve.
 @param limit Set to limit the filter results.
 @param order SQL-like order containing field and direction for filter results.
 @param offset Set to offset the filter results to a particular record count.
 @param fields Comma-delimited list of field names to retrieve for each record.
 @param related Comma-delimited list of related names to retrieve for each record.
 @param include_count Include the total number of filter results in returned metadata.
 @param include_schema Include the schema of the table queried in returned metadata.
 */
-(void) getAppsWithCompletionBlock :(RVBNSString**) ids 
        filter:(RVBNSString**) filter 
        limit:(RVBNSNumber**) limit 
        order:(RVBNSString**) order 
        offset:(RVBNSNumber**) offset 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        include_count:(RVBNSNumber**) include_count 
        include_schema:(RVBNSNumber**) include_schema 
        completionHandler: (void (^)(RVBAppsResponse* output, NSError* error))completionBlock;

/**

 createApps() - Create one or more applications.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createAppsWithCompletionBlock :(RVBRVBAppsRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 
        completionHandler: (void (^)(RVBAppsResponse* output, NSError* error))completionBlock;

/**

 updateApps() - Update one or more applications.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateAppsWithCompletionBlock :(RVBRVBAppsRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBAppsResponse* output, NSError* error))completionBlock;

/**

 deleteApps() - Delete one or more applications.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param delete_storage If the app is hosted in a storage service, the storage will be deleted as well.
 */
-(void) deleteAppsWithCompletionBlock :(RVBNSString**) ids 
        force:(RVBNSNumber**) force 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        delete_storage:(RVBNSNumber**) delete_storage 
        completionHandler: (void (^)(RVBAppsResponse* output, NSError* error))completionBlock;

/**

 getApp() - Retrieve one application.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 @param pkg Download this app as a DreamFactory package file.
 @param include_files If 'pkg' is true, include hosted files in the package.
 @param include_services If 'pkg' is true, include associated services configuration in the package.
 @param include_schema If 'pkg' is true, include associated database schema in the package.
 @param sdk Download the DreamFactory Javascript SDK amended for this app.
 */
-(void) getAppWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        pkg:(RVBNSNumber**) pkg 
        include_files:(RVBNSNumber**) include_files 
        include_services:(RVBNSNumber**) include_services 
        include_schema:(RVBNSNumber**) include_schema 
        sdk:(RVBNSNumber**) sdk 
        completionHandler: (void (^)(RVBAppResponse* output, NSError* error))completionBlock;

/**

 updateApp() - Update one application.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateAppWithCompletionBlock :(RVBNSString**) _id 
        body:(RVBRVBAppRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBAppResponse* output, NSError* error))completionBlock;

/**

 deleteApp() - Delete one application.
  By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 @param delete_storage If the app is hosted in a storage service, the storage will be deleted as well.
 */
-(void) deleteAppWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        delete_storage:(RVBNSNumber**) delete_storage 
        completionHandler: (void (^)(RVBAppResponse* output, NSError* error))completionBlock;

/**

 getAppGroups() - Retrieve one or more application groups.
 Use the 'ids' or 'filter' parameter to limit records that are returned. By default, all records up to the maximum are returned. <br>Use the 'fields' and 'related' parameters to limit properties returned for each record. By default, all fields and no relations are returned for each record. <br>Alternatively, to retrieve by record, a large list of ids, or a complicated filter, use the POST request with X-HTTP-METHOD = GET header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to retrieve.
 @param filter SQL-like filter to limit the records to retrieve.
 @param limit Set to limit the filter results.
 @param order SQL-like order containing field and direction for filter results.
 @param offset Set to offset the filter results to a particular record count.
 @param fields Comma-delimited list of field names to retrieve for each record.
 @param related Comma-delimited list of related names to retrieve for each record.
 @param include_count Include the total number of filter results in returned metadata.
 @param include_schema Include the schema of the table queried in returned metadata.
 */
-(void) getAppGroupsWithCompletionBlock :(RVBNSString**) ids 
        filter:(RVBNSString**) filter 
        limit:(RVBNSNumber**) limit 
        order:(RVBNSString**) order 
        offset:(RVBNSNumber**) offset 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        include_count:(RVBNSNumber**) include_count 
        include_schema:(RVBNSNumber**) include_schema 
        completionHandler: (void (^)(RVBAppGroupsResponse* output, NSError* error))completionBlock;

/**

 createAppGroups() - Create one or more application groups.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createAppGroupsWithCompletionBlock :(RVBRVBAppGroupsRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 
        completionHandler: (void (^)(RVBAppGroupsResponse* output, NSError* error))completionBlock;

/**

 updateAppGroups() - Update one or more application groups.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateAppGroupsWithCompletionBlock :(RVBRVBAppGroupsRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBAppGroupsResponse* output, NSError* error))completionBlock;

/**

 deleteAppGroups() - Delete one or more application groups.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteAppGroupsWithCompletionBlock :(RVBNSString**) ids 
        force:(RVBNSNumber**) force 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBAppGroupsResponse* output, NSError* error))completionBlock;

/**

 getAppGroup() - Retrieve one application group.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getAppGroupWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBAppGroup* output, NSError* error))completionBlock;

/**

 updateAppGroup() - Update one application group.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateAppGroupWithCompletionBlock :(RVBNSString**) _id 
        body:(RVBRVBAppGroupRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBAppGroupResponse* output, NSError* error))completionBlock;

/**

 deleteAppGroup() - Delete one application group.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteAppGroupWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBAppGroupResponse* output, NSError* error))completionBlock;

/**

 getConfig() - Retrieve system configuration properties.
 The retrieved properties control how the system behaves.
 */
-(void) getConfigWithCompletionBlock :(void (^)(RVBConfigResponse* output, NSError* error))completionBlock;

/**

 setConfig() - Update one or more system configuration properties.
 Post data should be an array of properties.
 @param body Data containing name-value pairs of properties to set.
 */
-(void) setConfigWithCompletionBlock :(RVBRVBConfigRequest**) body 
        completionHandler: (void (^)(RVBConfigResponse* output, NSError* error))completionBlock;

/**

 getConstants() - Retrieve all platform enumerated constants.
 Returns an object containing every enumerated type and its constant values
 */
-(void) getConstantsWithCompletionBlock :(void (^)(RVBConstants* output, NSError* error))completionBlock;

/**

 getConstant() - Retrieve one constant type enumeration.
 Returns , all fields and no relations are returned.
 @param type Identifier of the enumeration type to retrieve.
 */
-(void) getConstantWithCompletionBlock :(RVBNSString**) type 
        completionHandler: (void (^)(RVBConstant* output, NSError* error))completionBlock;

/**

 getCustomSettings() - Retrieve all custom system settings.
 Returns an object containing name-value pairs for custom system settings
 */
-(void) getCustomSettingsWithCompletionBlock :(void (^)(RVBCustomSettings* output, NSError* error))completionBlock;

/**

 setCustomSettings() - Update one or more custom system settings.
 A valid session and system configuration permissions is required to edit settings. Post body should be an array of name-value pairs.
 @param body Data containing name-value pairs of desired settings.
 */
-(void) setCustomSettingsWithCompletionBlock :(RVBRVBCustomSettings**) body 
        completionHandler: (void (^)(RVBSuccess* output, NSError* error))completionBlock;

/**

 getCustomSetting() - Retrieve one custom system setting.
 Setting will be returned as an object containing name-value pair.
 @param setting Name of the setting to retrieve.
 */
-(void) getCustomSettingWithCompletionBlock :(RVBNSString**) setting 
        completionHandler: (void (^)(RVBCustomSetting* output, NSError* error))completionBlock;

/**

 deleteCustomSetting() - Delete one custom setting.
 A valid session with system configuration permissions is required to delete settings.
 @param setting Name of the setting to delete.
 */
-(void) deleteCustomSettingWithCompletionBlock :(RVBNSString**) setting 
        completionHandler: (void (^)(RVBSuccess* output, NSError* error))completionBlock;

/**

 getEmailTemplates() - Retrieve one or more email templates.
 Use the 'ids' or 'filter' parameter to limit records that are returned. By default, all records up to the maximum are returned. <br>Use the 'fields' and 'related' parameters to limit properties returned for each record. By default, all fields and no relations are returned for each record. <br>Alternatively, to retrieve by record, a large list of ids, or a complicated filter, use the POST request with X-HTTP-METHOD = GET header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to retrieve.
 @param filter SQL-like filter to limit the records to retrieve.
 @param limit Set to limit the filter results.
 @param order SQL-like order containing field and direction for filter results.
 @param offset Set to offset the filter results to a particular record count.
 @param fields Comma-delimited list of field names to retrieve for each record.
 @param related Comma-delimited list of related names to retrieve for each record.
 @param include_count Include the total number of filter results in returned metadata.
 @param include_schema Include the schema of the table queried in returned metadata.
 */
-(void) getEmailTemplatesWithCompletionBlock :(RVBNSString**) ids 
        filter:(RVBNSString**) filter 
        limit:(RVBNSNumber**) limit 
        order:(RVBNSString**) order 
        offset:(RVBNSNumber**) offset 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        include_count:(RVBNSNumber**) include_count 
        include_schema:(RVBNSNumber**) include_schema 
        completionHandler: (void (^)(RVBEmailTemplatesResponse* output, NSError* error))completionBlock;

/**

 createEmailTemplates() - Create one or more email templates.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createEmailTemplatesWithCompletionBlock :(RVBRVBEmailTemplatesRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 
        completionHandler: (void (^)(RVBEmailTemplatesResponse* output, NSError* error))completionBlock;

/**

 updateEmailTemplates() - Update one or more email templates.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateEmailTemplatesWithCompletionBlock :(RVBRVBEmailTemplatesRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBEmailTemplatesResponse* output, NSError* error))completionBlock;

/**

 deleteEmailTemplates() - Delete one or more email templates.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteEmailTemplatesWithCompletionBlock :(RVBNSString**) ids 
        force:(RVBNSNumber**) force 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBEmailTemplatesResponse* output, NSError* error))completionBlock;

/**

 getEmailTemplate() - Retrieve one email template.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getEmailTemplateWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBEmailTemplateResponse* output, NSError* error))completionBlock;

/**

 updateEmailTemplate() - Update one email template.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateEmailTemplateWithCompletionBlock :(RVBNSString**) _id 
        body:(RVBRVBEmailTemplateRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBEmailTemplateResponse* output, NSError* error))completionBlock;

/**

 deleteEmailTemplate() - Delete one email template.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteEmailTemplateWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBEmailTemplateResponse* output, NSError* error))completionBlock;

/**

 getRoles() - Retrieve one or more roles.
 Use the 'ids' or 'filter' parameter to limit records that are returned. By default, all records up to the maximum are returned. <br>Use the 'fields' and 'related' parameters to limit properties returned for each record. By default, all fields and no relations are returned for each record. <br>Alternatively, to retrieve by record, a large list of ids, or a complicated filter, use the POST request with X-HTTP-METHOD = GET header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to retrieve.
 @param filter SQL-like filter to limit the records to retrieve.
 @param limit Set to limit the filter results.
 @param order SQL-like order containing field and direction for filter results.
 @param offset Set to offset the filter results to a particular record count.
 @param fields Comma-delimited list of field names to retrieve for each record.
 @param related Comma-delimited list of related names to retrieve for each record.
 @param include_count Include the total number of filter results in returned metadata.
 @param include_schema Include the schema of the table queried in returned metadata.
 */
-(void) getRolesWithCompletionBlock :(RVBNSString**) ids 
        filter:(RVBNSString**) filter 
        limit:(RVBNSNumber**) limit 
        order:(RVBNSString**) order 
        offset:(RVBNSNumber**) offset 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        include_count:(RVBNSNumber**) include_count 
        include_schema:(RVBNSNumber**) include_schema 
        completionHandler: (void (^)(RVBRolesResponse* output, NSError* error))completionBlock;

/**

 createRoles() - Create one or more roles.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createRolesWithCompletionBlock :(RVBRVBRolesRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 
        completionHandler: (void (^)(RVBRolesResponse* output, NSError* error))completionBlock;

/**

 updateRoles() - Update one or more roles.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateRolesWithCompletionBlock :(RVBRVBRolesRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBRolesResponse* output, NSError* error))completionBlock;

/**

 deleteRoles() - Delete one or more roles.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteRolesWithCompletionBlock :(RVBNSString**) ids 
        force:(RVBNSNumber**) force 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBRolesResponse* output, NSError* error))completionBlock;

/**

 getRole() - Retrieve one role.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getRoleWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBRoleResponse* output, NSError* error))completionBlock;

/**

 updateRole() - Update one role.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateRoleWithCompletionBlock :(RVBNSString**) _id 
        body:(RVBRVBRoleRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBRoleResponse* output, NSError* error))completionBlock;

/**

 deleteRole() - Delete one role.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteRoleWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBRoleResponse* output, NSError* error))completionBlock;

/**

 getServices() - Retrieve one or more services.
 Use the 'ids' or 'filter' parameter to limit records that are returned. By default, all records up to the maximum are returned. <br>Use the 'fields' and 'related' parameters to limit properties returned for each record. By default, all fields and no relations are returned for each record. <br>Alternatively, to retrieve by record, a large list of ids, or a complicated filter, use the POST request with X-HTTP-METHOD = GET header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to retrieve.
 @param filter SQL-like filter to limit the records to retrieve.
 @param limit Set to limit the filter results.
 @param order SQL-like order containing field and direction for filter results.
 @param offset Set to offset the filter results to a particular record count.
 @param fields Comma-delimited list of field names to retrieve for each record.
 @param related Comma-delimited list of related names to retrieve for each record.
 @param include_count Include the total number of filter results in returned metadata.
 @param include_schema Include the schema of the table queried in returned metadata.
 */
-(void) getServicesWithCompletionBlock :(RVBNSString**) ids 
        filter:(RVBNSString**) filter 
        limit:(RVBNSNumber**) limit 
        order:(RVBNSString**) order 
        offset:(RVBNSNumber**) offset 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        include_count:(RVBNSNumber**) include_count 
        include_schema:(RVBNSNumber**) include_schema 
        completionHandler: (void (^)(RVBServicesResponse* output, NSError* error))completionBlock;

/**

 createServices() - Create one or more services.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createServicesWithCompletionBlock :(RVBRVBServicesRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 
        completionHandler: (void (^)(RVBServicesResponse* output, NSError* error))completionBlock;

/**

 updateServices() - Update one or more services.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateServicesWithCompletionBlock :(RVBRVBServicesRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBServicesResponse* output, NSError* error))completionBlock;

/**

 deleteServices() - Delete one or more services.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteServicesWithCompletionBlock :(RVBNSString**) ids 
        force:(RVBNSNumber**) force 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBServicesResponse* output, NSError* error))completionBlock;

/**

 getService() - Retrieve one service.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getServiceWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBServiceResponse* output, NSError* error))completionBlock;

/**

 updateService() - Update one service.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateServiceWithCompletionBlock :(RVBNSString**) _id 
        body:(RVBRVBServiceRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBServiceResponse* output, NSError* error))completionBlock;

/**

 deleteService() - Delete one service.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteServiceWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBServiceResponse* output, NSError* error))completionBlock;

/**

 getUsers() - Retrieve one or more users.
 Use the 'ids' or 'filter' parameter to limit records that are returned. By default, all records up to the maximum are returned. <br>Use the 'fields' and 'related' parameters to limit properties returned for each record. By default, all fields and no relations are returned for each record. <br>Alternatively, to retrieve by record, a large list of ids, or a complicated filter, use the POST request with X-HTTP-METHOD = GET header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to retrieve.
 @param filter SQL-like filter to limit the records to retrieve.
 @param limit Set to limit the filter results.
 @param order SQL-like order containing field and direction for filter results.
 @param offset Set to offset the filter results to a particular record count.
 @param fields Comma-delimited list of field names to retrieve for each record.
 @param related Comma-delimited list of related names to retrieve for each record.
 @param include_count Include the total number of filter results in returned metadata.
 @param include_schema Include the schema of the table queried in returned metadata.
 @param file Download the results of the request as a file.
 */
-(void) getUsersWithCompletionBlock :(RVBNSString**) ids 
        filter:(RVBNSString**) filter 
        limit:(RVBNSNumber**) limit 
        order:(RVBNSString**) order 
        offset:(RVBNSNumber**) offset 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        include_count:(RVBNSNumber**) include_count 
        include_schema:(RVBNSNumber**) include_schema 
        file:(RVBNSString**) file 
        completionHandler: (void (^)(RVBUsersResponse* output, NSError* error))completionBlock;

/**

 createUsers() - Create one or more users.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createUsersWithCompletionBlock :(RVBRVBUsersRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 
        completionHandler: (void (^)(RVBUsersResponse* output, NSError* error))completionBlock;

/**

 updateUsers() - Update one or more users.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateUsersWithCompletionBlock :(RVBRVBUsersRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBUsersResponse* output, NSError* error))completionBlock;

/**

 deleteUsers() - Delete one or more users.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteUsersWithCompletionBlock :(RVBNSString**) ids 
        force:(RVBNSNumber**) force 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBUsersResponse* output, NSError* error))completionBlock;

/**

 getUser() - Retrieve one user.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getUserWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBUserResponse* output, NSError* error))completionBlock;

/**

 updateUser() - Update one user.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateUserWithCompletionBlock :(RVBNSString**) _id 
        body:(RVBRVBUserRequest**) body 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBUserResponse* output, NSError* error))completionBlock;

/**

 deleteUser() - Delete one user.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteUserWithCompletionBlock :(RVBNSString**) _id 
        fields:(RVBNSString**) fields 
        related:(RVBNSString**) related 
        completionHandler: (void (^)(RVBUserResponse* output, NSError* error))completionBlock;

@end

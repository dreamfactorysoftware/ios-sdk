#import <Foundation/Foundation.h>
#import "NIKApiInvoker.h"
#import "SWGEventsResponse.h"
#import "SWGRegister.h"
#import "SWGConstant.h"
#import "SWGScriptsResponse.h"
#import "SWGRolesResponse.h"
#import "SWGAppGroupsResponse.h"
#import "SWGCustomSettings.h"
#import "SWGEventResponse.h"
#import "SWGProviderUsersRequest.h"
#import "SWGProviderUsersResponse.h"
#import "SWGProviderUserRequest.h"
#import "SWGProvidersRequest.h"
#import "SWGProviderRequest.h"
#import "SWGProvidersResponse.h"
#import "SWGEnvironmentResponse.h"
#import "SWGScriptOutput.h"
#import "SWGEventsRequest.h"
#import "SWGLogin.h"
#import "SWGPasswordResponse.h"
#import "SWGProfileResponse.h"
#import "SWGUsersRequest.h"
#import "SWGSession.h"
#import "SWGEmailTemplateRequest.h"
#import "SWGDeviceResponse.h"
#import "SWGUserRequest.h"
#import "SWGConfigResponse.h"
#import "SWGEmailTemplatesRequest.h"
#import "SWGCustomSetting.h"
#import "SWGServiceResponse.h"
#import "SWGPasswordRequest.h"
#import "SWGServiceRequest.h"
#import "SWGDeviceRequest.h"
#import "SWGRoleRequest.h"
#import "SWGServicesResponse.h"
#import "SWGScriptResponse.h"
#import "SWGAppsRequest.h"
#import "SWGAppGroupResponse.h"
#import "SWGEmailTemplatesResponse.h"
#import "SWGConstants.h"
#import "SWGResources.h"
#import "SWGAppsResponse.h"
#import "SWGEmailTemplateResponse.h"
#import "SWGProviderUserResponse.h"
#import "SWGSuccess.h"
#import "SWGServicesRequest.h"
#import "SWGEventCacheResponse.h"
#import "SWGAppRequest.h"
#import "SWGRolesRequest.h"
#import "SWGAppGroupsRequest.h"
#import "SWGAppGroupRequest.h"
#import "SWGUserResponse.h"
#import "SWGProfileRequest.h"
#import "SWGProviderResponse.h"
#import "SWGDevicesResponse.h"
#import "SWGEventRequest.h"
#import "SWGAppResponse.h"
#import "SWGUsersResponse.h"
#import "SWGRoleResponse.h"
#import "SWGConfigRequest.h"


@interface SWGSystemApi: NSObject {

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
-(void) getResourcesWithCompletionBlock :(void (^)(SWGResources* output, NSError* error))completionBlock;

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
-(void) getAppsWithCompletionBlock :(NSString*) ids 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        order:(NSString*) order 
        offset:(NSNumber*) offset 
        fields:(NSString*) fields 
        related:(NSString*) related 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        completionHandler: (void (^)(SWGAppsResponse* output, NSError* error))completionBlock;

/**

 createApps() - Create one or more applications.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createAppsWithCompletionBlock :(SWGAppsRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD
        completionHandler: (void (^)(SWGAppsResponse* output, NSError* error))completionBlock;

/**

 updateApps() - Update one or more applications.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateAppsWithCompletionBlock :(SWGAppsRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGAppsResponse* output, NSError* error))completionBlock;

/**

 deleteApps() - Delete one or more applications.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param delete_storage If the app is hosted in a storage service, the storage will be deleted as well.
 */
-(void) deleteAppsWithCompletionBlock :(NSString*) ids 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        delete_storage:(NSNumber*) delete_storage 
        completionHandler: (void (^)(SWGAppsResponse* output, NSError* error))completionBlock;

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
-(void) getAppWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        pkg:(NSNumber*) pkg 
        include_files:(NSNumber*) include_files 
        include_services:(NSNumber*) include_services 
        include_schema:(NSNumber*) include_schema 
        sdk:(NSNumber*) sdk 
        completionHandler: (void (^)(SWGAppResponse* output, NSError* error))completionBlock;

/**

 updateApp() - Update one application.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateAppWithCompletionBlock :(NSString*) _id 
        body:(SWGAppRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGAppResponse* output, NSError* error))completionBlock;

/**

 deleteApp() - Delete one application.
  By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 @param delete_storage If the app is hosted in a storage service, the storage will be deleted as well.
 */
-(void) deleteAppWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        delete_storage:(NSNumber*) delete_storage 
        completionHandler: (void (^)(SWGAppResponse* output, NSError* error))completionBlock;

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
-(void) getAppGroupsWithCompletionBlock :(NSString*) ids 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        order:(NSString*) order 
        offset:(NSNumber*) offset 
        fields:(NSString*) fields 
        related:(NSString*) related 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        completionHandler: (void (^)(SWGAppGroupsResponse* output, NSError* error))completionBlock;

/**

 createAppGroups() - Create one or more application groups.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createAppGroupsWithCompletionBlock :(SWGAppGroupsRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD
        completionHandler: (void (^)(SWGAppGroupsResponse* output, NSError* error))completionBlock;

/**

 updateAppGroups() - Update one or more application groups.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateAppGroupsWithCompletionBlock :(SWGAppGroupsRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGAppGroupsResponse* output, NSError* error))completionBlock;

/**

 deleteAppGroups() - Delete one or more application groups.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteAppGroupsWithCompletionBlock :(NSString*) ids 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGAppGroupsResponse* output, NSError* error))completionBlock;

/**

 getAppGroup() - Retrieve one application group.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getAppGroupWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGAppGroupResponse* output, NSError* error))completionBlock;

/**

 updateAppGroup() - Update one application group.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateAppGroupWithCompletionBlock :(NSString*) _id 
        body:(SWGAppGroupRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGAppGroupResponse* output, NSError* error))completionBlock;

/**

 deleteAppGroup() - Delete one application group.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteAppGroupWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGAppGroupResponse* output, NSError* error))completionBlock;

/**

 getConfig() - Retrieve system configuration properties.
 The retrieved properties control how the system behaves.
 */
-(void) getConfigWithCompletionBlock :(void (^)(SWGConfigResponse* output, NSError* error))completionBlock;

/**

 setConfig() - Update one or more system configuration properties.
 Post data should be an array of properties.
 @param body Data containing name-value pairs of properties to set.
 */
-(void) setConfigWithCompletionBlock :(SWGConfigRequest*) body 
        completionHandler: (void (^)(SWGConfigResponse* output, NSError* error))completionBlock;

/**

 getConstants() - Retrieve all platform enumerated constants.
 Returns an object containing every enumerated type and its constant values
 */
-(void) getConstantsWithCompletionBlock :(void (^)(SWGConstants* output, NSError* error))completionBlock;

/**

 getConstant() - Retrieve one constant type enumeration.
 Returns , all fields and no relations are returned.
 @param type Identifier of the enumeration type to retrieve.
 */
-(void) getConstantWithCompletionBlock :(NSString*) type 
        completionHandler: (void (^)(SWGConstant* output, NSError* error))completionBlock;

/**

 getCustomSettings() - Retrieve all custom system settings.
 Returns an object containing name-value pairs for custom system settings
 */
//-(void) getCustomSettingsWithCompletionBlock :(void (^)(SWGCustomSettings* output, NSError* error))completionBlock;

/**

 setCustomSettings() - Update one or more custom system settings.
 A valid session and system configuration permissions is required to edit settings. Post body should be an array of name-value pairs.
 @param body Data containing name-value pairs of desired settings.
 */
-(void) setCustomSettingsWithCompletionBlock :(SWGCustomSettings*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 getCustomSetting() - Retrieve one custom system setting.
 Setting will be returned as an object containing name-value pair.
 @param setting Name of the setting to retrieve.
 */
-(void) getCustomSettingWithCompletionBlock :(NSString*) setting 
        completionHandler: (void (^)(SWGCustomSetting* output, NSError* error))completionBlock;

/**

 deleteCustomSetting() - Delete one custom setting.
 A valid session with system configuration permissions is required to delete settings.
 @param setting Name of the setting to delete.
 */
-(void) deleteCustomSettingWithCompletionBlock :(NSString*) setting 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 getDevices() - Retrieve one or more devices.
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
-(void) getDevicesWithCompletionBlock :(NSString*) ids 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        order:(NSString*) order 
        offset:(NSNumber*) offset 
        fields:(NSString*) fields 
        related:(NSString*) related 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        completionHandler: (void (^)(SWGDevicesResponse* output, NSError* error))completionBlock;

/**

 deleteDevices() - Delete one or more devices.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteDevicesWithCompletionBlock :(NSString*) ids 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGDevicesResponse* output, NSError* error))completionBlock;

/**

 getDevice() - Retrieve one device.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getDeviceWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGDeviceResponse* output, NSError* error))completionBlock;

/**

 deleteDevice() - Delete one device.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteDeviceWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGDeviceResponse* output, NSError* error))completionBlock;

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
-(void) getEmailTemplatesWithCompletionBlock :(NSString*) ids 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        order:(NSString*) order 
        offset:(NSNumber*) offset 
        fields:(NSString*) fields 
        related:(NSString*) related 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        completionHandler: (void (^)(SWGEmailTemplatesResponse* output, NSError* error))completionBlock;

/**

 createEmailTemplates() - Create one or more email templates.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createEmailTemplatesWithCompletionBlock :(SWGEmailTemplatesRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD 
        completionHandler: (void (^)(SWGEmailTemplatesResponse* output, NSError* error))completionBlock;

/**

 updateEmailTemplates() - Update one or more email templates.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateEmailTemplatesWithCompletionBlock :(SWGEmailTemplatesRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGEmailTemplatesResponse* output, NSError* error))completionBlock;

/**

 deleteEmailTemplates() - Delete one or more email templates.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteEmailTemplatesWithCompletionBlock :(NSString*) ids 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGEmailTemplatesResponse* output, NSError* error))completionBlock;

/**

 getEmailTemplate() - Retrieve one email template.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getEmailTemplateWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGEmailTemplateResponse* output, NSError* error))completionBlock;

/**

 updateEmailTemplate() - Update one email template.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateEmailTemplateWithCompletionBlock :(NSString*) _id 
        body:(SWGEmailTemplateRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGEmailTemplateResponse* output, NSError* error))completionBlock;

/**

 deleteEmailTemplate() - Delete one email template.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteEmailTemplateWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGEmailTemplateResponse* output, NSError* error))completionBlock;

/**

 getEnvironment() - Retrieve environment information.
 The retrieved information describes the container/machine on which the DSP resides.
 */
-(void) getEnvironmentWithCompletionBlock :(void (^)(SWGEnvironmentResponse* output, NSError* error))completionBlock;

/**

 getEvents() - Retrieve events and registered listeners.
 
 @param all_events If set to true, all events that are available are returned. Otherwise only events that are have registered listeners are returned.
 @param as_cached If set to true, the returned structure is identical the stored structure. If false, a simpler form is returned for client consumption.
 */
-(void) getEventsWithCompletionBlock :(NSNumber*) all_events 
        as_cached:(NSNumber*) as_cached 
        completionHandler: (void (^)(SWGEventCacheResponse* output, NSError* error))completionBlock;

/**

 registerEvents() - Register one or more event listeners.
 Post data should be a single record or an array of records. No data is returned from this call. You will get a 201 (created) upon success.
 @param body Data containing event registration records to create.
 */
-(void) registerEventsWithCompletionBlock :(SWGEventsRequest*) body 
        completionHandler: (void (^)(SWGEventsResponse* output, NSError* error))completionBlock;

/**

 unregisterEvents() - Delete one or more event listeners.
 Post data should be a single record or an array of records. No data is returned from this call. You will get a 200 (OK) upon success.
 @param body Data containing event registration records to delete.
 */
-(void) unregisterEventsWithCompletionBlock :(SWGEventsRequest*) body 
        completionHandler: (void (^)(SWGEventsResponse* output, NSError* error))completionBlock;

/**

 getEvent() - Retrieve one event.
 
 @param event_name Identifier of the record to retrieve.
 */
-(void) getEventWithCompletionBlock :(NSString*) event_name 
        completionHandler: (void (^)(SWGEventResponse* output, NSError* error))completionBlock;

/**

 registerEvent() - Register one event listeners.
 Post data must be a single record. No data is returned from this call. You will get a 201 (created) upon success.
 @param body Data containing event registration record to create.
 */
-(void) registerEventWithCompletionBlock :(SWGEventRequest*) body 
        completionHandler: (void (^)(SWGEventResponse* output, NSError* error))completionBlock;

/**

 updateEvent() - Update one listener(s) for a single event.
 Post data must be a single record. No data is returned from this call. You will get a 200 (OK) upon success.
 @param _id The event ID
 @param body Data containing event registration record to update.
 */
-(void) updateEventWithCompletionBlock :(NSString*) _id 
        body:(SWGEventRequest*) body 
        completionHandler: (void (^)(SWGEventResponse* output, NSError* error))completionBlock;

/**

 unregisterEvent() - Delete one event.
 Post data must be a single record. No data is returned from this call. You will get a 200 (OK) upon success.
 @param _id The event ID
 @param body Data containing event registration record to delete.
 */
-(void) unregisterEventWithCompletionBlock :(NSString*) _id 
        body:(SWGEventRequest*) body 
        completionHandler: (void (^)(SWGEventResponse* output, NSError* error))completionBlock;

/**

 getProviders() - Retrieve one or more providers.
 
 @param user_id If specified, filter the providers by the user ID given.
 */
-(void) getProvidersWithCompletionBlock :(NSNumber*) user_id 
        completionHandler: (void (^)(SWGProvidersResponse* output, NSError* error))completionBlock;

/**

 createProviders() - Create one or more providers.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createProvidersWithCompletionBlock :(SWGProvidersRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD 
        completionHandler: (void (^)(SWGProvidersResponse* output, NSError* error))completionBlock;

/**

 updateProviders() - Update one or more providers.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateProvidersWithCompletionBlock :(SWGProvidersRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProvidersResponse* output, NSError* error))completionBlock;

/**

 deleteProviders() - Delete one or more providers.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteProvidersWithCompletionBlock :(NSString*) ids 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProvidersResponse* output, NSError* error))completionBlock;

/**

 getProvider() - Retrieve one provider.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getProviderWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProviderResponse* output, NSError* error))completionBlock;

/**

 updateProvider() - Update one provider.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateProviderWithCompletionBlock :(NSString*) _id 
        body:(SWGProviderRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProviderResponse* output, NSError* error))completionBlock;

/**

 deleteProvider() - Delete one provider.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteProviderWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProviderResponse* output, NSError* error))completionBlock;

/**

 getProviderUsers() - Retrieve one or more provider provider users.
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
-(void) getProviderUsersWithCompletionBlock :(NSString*) ids 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        order:(NSString*) order 
        offset:(NSNumber*) offset 
        fields:(NSString*) fields 
        related:(NSString*) related 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        file:(NSString*) file 
        completionHandler: (void (^)(SWGProviderUsersResponse* output, NSError* error))completionBlock;

/**

 createProviderUsers() - Create one or more provider users.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createProviderUsersWithCompletionBlock :(SWGProviderUsersRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD 
        completionHandler: (void (^)(SWGProviderUsersResponse* output, NSError* error))completionBlock;

/**

 updateProviderUsers() - Update one or more provider provider users.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateProviderUsersWithCompletionBlock :(SWGProviderUsersRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProviderUsersResponse* output, NSError* error))completionBlock;

/**

 deleteProviderUsers() - Delete one or more provider users.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteProviderUsersWithCompletionBlock :(NSString*) ids 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProviderUsersResponse* output, NSError* error))completionBlock;

/**

 getProviderUser() - Retrieve one provider user.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getProviderUserWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProviderUserResponse* output, NSError* error))completionBlock;

/**

 updateProviderUser() - Update one provider user.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateProviderUserWithCompletionBlock :(NSString*) _id 
        body:(SWGProviderUserRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProviderUserResponse* output, NSError* error))completionBlock;

/**

 deleteProviderUser() - Delete one provider user.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteProviderUserWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGProviderUserResponse* output, NSError* error))completionBlock;

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
-(void) getRolesWithCompletionBlock :(NSString*) ids 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        order:(NSString*) order 
        offset:(NSNumber*) offset 
        fields:(NSString*) fields 
        related:(NSString*) related 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        completionHandler: (void (^)(SWGRolesResponse* output, NSError* error))completionBlock;

/**

 createRoles() - Create one or more roles.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createRolesWithCompletionBlock :(SWGRolesRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD 
        completionHandler: (void (^)(SWGRolesResponse* output, NSError* error))completionBlock;

/**

 updateRoles() - Update one or more roles.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateRolesWithCompletionBlock :(SWGRolesRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRolesResponse* output, NSError* error))completionBlock;

/**

 deleteRoles() - Delete one or more roles.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteRolesWithCompletionBlock :(NSString*) ids 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRolesResponse* output, NSError* error))completionBlock;

/**

 getRole() - Retrieve one role.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getRoleWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRoleResponse* output, NSError* error))completionBlock;

/**

 updateRole() - Update one role.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateRoleWithCompletionBlock :(NSString*) _id 
        body:(SWGRoleRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRoleResponse* output, NSError* error))completionBlock;

/**

 deleteRole() - Delete one role.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteRoleWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRoleResponse* output, NSError* error))completionBlock;

/**

 getScripts() - List all scripts
 List all known scripts
 @param include_script_body True if you would like the body of the scripts back as well
 @param include_user_scripts If true, user scripts will be returned along with the event scripts.
 @param include_only_user_scripts If true, and &quot;include_user_scripts&quot; is true, ONLY user scripts will be returned.
 */
-(void) getScriptsWithCompletionBlock :(NSNumber*) include_script_body 
        include_user_scripts:(NSNumber*) include_user_scripts 
        include_only_user_scripts:(NSNumber*) include_only_user_scripts 
        completionHandler: (void (^)(SWGScriptsResponse* output, NSError* error))completionBlock;

/**

 getScript() - Get the script with ID provided
 
 @param script_id The ID of the record to retrieve
 @param is_user_script True if you would like a user script to be returned
 @param include_script_body True if you would like the body of the scripts back as well
 */
-(void) getScriptWithCompletionBlock :(NSString*) script_id 
        is_user_script:(NSNumber*) is_user_script 
        include_script_body:(NSNumber*) include_script_body 
        completionHandler: (void (^)(SWGScriptResponse* output, NSError* error))completionBlock;

/**

 runScript() - Runs the specified script.
 Loads and executes the specified script
 @param script_id The ID of the script which you want to retrieve.
 @param is_user_script True if this is a user script
 */
-(void) runScriptWithCompletionBlock :(NSString*) script_id 
        is_user_script:(NSNumber*) is_user_script 
        completionHandler: (void (^)(SWGScriptOutput* output, NSError* error))completionBlock;

/**

 writeScript() - Writes the specified script to the file system.
 Post data as a string.
 @param script_id The ID of the script which you want to retrieve.
 @param body The body of the script to write.
 @param is_user_script True if this is a user script
 */
-(void) writeScriptWithCompletionBlock :(NSString*) script_id 
        body:(NSString*) body 
        is_user_script:(NSNumber*) is_user_script 
        completionHandler: (void (^)(SWGScriptResponse* output, NSError* error))completionBlock;

/**

 deleteScript() - Delete the script with ID provided
 
 @param script_id The ID of the record to delete
 @param is_user_script True if it is a user script
 */
-(void) deleteScriptWithCompletionBlock :(NSString*) script_id 
        is_user_script:(NSNumber*) is_user_script 
        completionHandler: (void (^)(SWGScriptResponse* output, NSError* error))completionBlock;

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
 @param include_components Include the components of the service, as used by role service accesses.
 */
-(void) getServicesWithCompletionBlock :(NSString*) ids 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        order:(NSString*) order 
        offset:(NSNumber*) offset 
        fields:(NSString*) fields 
        related:(NSString*) related 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        include_components:(NSNumber*) include_components 
        completionHandler: (void (^)(SWGServicesResponse* output, NSError* error))completionBlock;

/**

 createServices() - Create one or more services.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createServicesWithCompletionBlock :(SWGServicesRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD 
        completionHandler: (void (^)(SWGServicesResponse* output, NSError* error))completionBlock;

/**

 updateServices() - Update one or more services.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateServicesWithCompletionBlock :(SWGServicesRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGServicesResponse* output, NSError* error))completionBlock;

/**

 deleteServices() - Delete one or more services.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteServicesWithCompletionBlock :(NSString*) ids 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGServicesResponse* output, NSError* error))completionBlock;

/**

 getService() - Retrieve one service.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getServiceWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGServiceResponse* output, NSError* error))completionBlock;

/**

 updateService() - Update one service.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateServiceWithCompletionBlock :(NSString*) _id 
        body:(SWGServiceRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGServiceResponse* output, NSError* error))completionBlock;

/**

 deleteService() - Delete one service.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteServiceWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGServiceResponse* output, NSError* error))completionBlock;

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
-(void) getUsersWithCompletionBlock :(NSString*) ids 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        order:(NSString*) order 
        offset:(NSNumber*) offset 
        fields:(NSString*) fields 
        related:(NSString*) related 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        file:(NSString*) file 
        completionHandler: (void (^)(SWGUsersResponse* output, NSError* error))completionBlock;

/**

 createUsers() - Create one or more users.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record affected is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 */
-(void) createUsersWithCompletionBlock :(SWGUsersRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD 
        completionHandler: (void (^)(SWGUsersResponse* output, NSError* error))completionBlock;

/**

 updateUsers() - Update one or more users.
 Post data should be a single record or an array of records (shown). By default, only the id property of the record is returned on success, use 'fields' and 'related' to return more info.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) updateUsersWithCompletionBlock :(SWGUsersRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGUsersResponse* output, NSError* error))completionBlock;

/**

 deleteUsers() - Delete one or more users.
 By default, only the id property of the record deleted is returned on success. Use 'fields' and 'related' to return more properties of the deleted records. <br>Alternatively, to delete by record or a large list of ids, use the POST request with X-HTTP-METHOD = DELETE header and post records or ids.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param force Set force to true to delete all records in this table, otherwise 'ids' parameter is required.
 @param fields Comma-delimited list of field names to return for each record affected.
 @param related Comma-delimited list of related names to return for each record affected.
 */
-(void) deleteUsersWithCompletionBlock :(NSString*) ids 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGUsersResponse* output, NSError* error))completionBlock;

/**

 getUser() - Retrieve one user.
 Use the 'fields' and/or 'related' parameter to limit properties that are returned. By default, all fields and no relations are returned.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) getUserWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGUserResponse* output, NSError* error))completionBlock;

/**

 updateUser() - Update one user.
 Post data should be an array of fields to update for a single record. <br>By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return more properties.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of fields to update.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) updateUserWithCompletionBlock :(NSString*) _id 
        body:(SWGUserRequest*) body 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGUserResponse* output, NSError* error))completionBlock;

/**

 deleteUser() - Delete one user.
 By default, only the id is returned. Use the 'fields' and/or 'related' parameter to return deleted properties.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to return.
 @param related Comma-delimited list of related records to return.
 */
-(void) deleteUserWithCompletionBlock :(NSString*) _id 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGUserResponse* output, NSError* error))completionBlock;

/**

 getCustomSettings() - Retrieve all custom user settings.
 Returns an object containing name-value pairs for custom user settings
 */
//-(void) getCustomSettingsWithCompletionBlock :(void (^)(SWGCustomSettings* output, NSError* error))completionBlock;

/**

 setCustomSettings() - Set or update one or more custom user settings.
 A valid session is required to edit settings. Post body should be an array of name-value pairs.
 @param body Data containing name-value pairs of desired settings.
 */
//-(void) setCustomSettingsWithCompletionBlock :(SWGCustomSettings*) body
  //      completionHandler : (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 getCustomSetting() - Retrieve one custom user setting.
 Setting will be returned as an object containing name-value pair. A value of null is returned for settings that are not found.
 @param setting Name of the setting to retrieve.
 */
//-(void) getCustomSettingWithCompletionBlock :(NSString*) setting
  //      completionHandler: (void (^)(SWGCustomSetting* output, NSError* error))completionBlock;

/**

 deleteCustomSetting() - Delete one custom setting.
 A valid session is required to delete settings.
 @param setting Name of the setting to delete.
 */
//-(void) deleteCustomSettingWithCompletionBlock :(NSString*) setting
//        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 getDevices() - Retrieve the current user's device information.
 A valid current session is required to use this API.
 */
-(void) getDevicesWithCompletionBlock :(void (^)(SWGDevicesResponse* output, NSError* error))completionBlock;

/**

 setDevice() - Create a record of the current user's device information.
 Record the device information for this session. This method is idempotent and will only create one entry per uuid.
 @param body Data containing name-value pairs for the user device.
 */
-(void) setDeviceWithCompletionBlock :(SWGDeviceRequest*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 changePassword() - Change or reset the current user's password.
 A valid current session along with old and new password are required to change the password directly posting 'old_password' and 'new_password'. <br/>To request password reset, post 'email' and set 'reset' to true. <br/>To reset the password from an email confirmation, post 'email', 'code', and 'new_password'. <br/>To reset the password from a security question, post 'email', 'security_answer', and 'new_password'.
 @param reset Set to true to perform password reset.
 @param login Login and create a session upon successful password reset.
 @param body Data containing name-value pairs for password change.
 */
-(void) changePasswordWithCompletionBlock :(NSNumber*) reset 
        login:(NSNumber*) login 
        body:(SWGPasswordRequest*) body 
        completionHandler: (void (^)(SWGPasswordResponse* output, NSError* error))completionBlock;

/**

 getProfile() - Retrieve the current user's profile information.
 A valid current session is required to use this API. This profile, along with password, is the only things that the user can directly change.
 */
-(void) getProfileWithCompletionBlock :(void (^)(SWGProfileResponse* output, NSError* error))completionBlock;

/**

 updateProfile() - Update the current user's profile information.
 Update the display name, phone, etc., as well as, security question and answer.
 @param body Data containing name-value pairs for the user profile.
 */
-(void) updateProfileWithCompletionBlock :(SWGProfileRequest*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 register() - Register a new user in the system.
 The new user is created and, if required, sent an email for confirmation. This also handles the registration confirmation by posting email, confirmation code and new password.
 @param login Login and create a session upon successful registration.
 @param body Data containing name-value pairs for new user registration.
 */
-(void) registerWithCompletionBlock :(NSNumber*) login 
        body:(SWGRegister*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 getSession() - Retrieve the current user session information.
 Calling this refreshes the current session, or returns an error for timed-out or invalid sessions.
 */
-(void) getSessionWithCompletionBlock :(void (^)(SWGSession* output, NSError* error))completionBlock;

/**

 login() - Login and create a new user session.
 Calling this creates a new session and logs in the user.
 @param body Data containing name-value pairs used for logging into the system.
 */
-(void) loginWithCompletionBlock :(SWGLogin*) body 
        completionHandler: (void (^)(SWGSession* output, NSError* error))completionBlock;

/**

 logout() - Logout and destroy the current user session.
 Calling this deletes the current session and logs out the user.
 */
-(void) logoutWithCompletionBlock :(void (^)(SWGSuccess* output, NSError* error))completionBlock;

@end

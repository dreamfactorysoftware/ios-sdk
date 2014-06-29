#import <Foundation/Foundation.h>
#import "NIKApiInvoker.h"
#import "SWGRecordsRequest.h"
#import "SWGRecordResponse.h"
#import "SWGIdsRequest.h"
#import "SWGRecordRequest.h"
#import "SWGFilterRequest.h"
#import "SWGGetRecordsRequest.h"
#import "SWGIdsRecordRequest.h"
#import "SWGResources.h"
#import "SWGFilterRecordRequest.h"
#import "SWGRecordsResponse.h"
#import "SWGTables.h"


@interface SWGDbApi: NSObject {

@private
    NSOperationQueue *_queue;
    NIKApiInvoker * _api;
}
@property(nonatomic, readonly) NSOperationQueue* queue;
@property(nonatomic, readonly) NIKApiInvoker* api;

-(void) addHeader:(NSString*)value forKey:(NSString*)key;

/**

 getResources() - List all resources.
 List the names of the available tables in this storage. 
 */
-(void) getResourcesWithCompletionBlock :(void (^)(SWGResources* output, NSError* error))completionBlock;

/**

 getTables() - List all properties on given tables.
 List the properties of the given tables in this storage.
 @param names Comma-delimited list of the table names to retrieve.
 */
-(void) getTablesWithCompletionBlock :(NSString*) names 
        completionHandler: (void (^)(SWGTables* output, NSError* error))completionBlock;

/**

 getRecordsByFilter() - Retrieve one or more records by using a filter.
 Set the <b>filter</b> parameter to a SQL WHERE clause (optional native filter accepted in some scenarios) to limit records returned or leave it blank to return all records up to the maximum limit.<br/> Set the <b>limit</b> parameter with or without a filter to return a specific amount of records.<br/> Use the <b>offset</b> parameter along with the <b>limit</b> parameter to page through sets of records.<br/> Set the <b>order</b> parameter to SQL ORDER_BY clause containing field and optional direction (<field_name> [ASC|DESC]) to order the returned records.<br/> Alternatively, to send the <b>filter</b> with or without <b>params</b> as posted data, use the getRecordsByPost() POST request and post a filter with or without params.<br/>Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> Use the <b>fields</b> parameter to limit properties returned for each record. By default, all fields are returned for all records. 
 @param table_name Name of the table to perform operations on.
 @param filter SQL WHERE clause filter to limit the records retrieved.
 @param limit Maximum number of records to return.
 @param offset Offset the filter results to a particular record index (may require &lt;b&gt;order&lt;/b&gt;&gt; parameter in some scenarios).
 @param order SQL ORDER_BY clause containing field and direction for filter results.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param include_count Include the total number of filter results as meta data.
 @param include_schema Include table properties, including indexes and field details where available, as meta data.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) getRecordsByFilterWithCompletionBlock :(NSString*) table_name 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        offset:(NSNumber*) offset 
        order:(NSString*) order 
        fields:(NSString*) fields 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 getRecordsByIds() - Retrieve one or more records by identifiers.
 Pass the identifying field values as a comma-separated list in the <b>ids</b> parameter.<br/> Use the <b>id_field</b> and <b>id_type</b> parameters to override or specify detail for identifying fields where applicable.<br/> Alternatively, to send the <b>ids</b> as posted data, use the getRecordsByPost() POST request.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> Use the <b>fields</b> parameter to limit properties returned for each record. By default, all fields are returned for identified records. 
 @param table_name Name of the table to perform operations on.
 @param ids Comma-delimited list of the identifiers of the records to retrieve.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) getRecordsByIdsWithCompletionBlock :(NSString*) table_name 
        ids:(NSString*) ids 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 getRecordsByPost() - Retrieve one or more records by posting necessary data.
 Post data should be an array of records wrapped in a <b>record</b> element - including the identifying fields at a minimum, or a <b>filter</b> in the SQL or other appropriate formats with or without a replacement <b>params</b> array, or a list of <b>ids</b> in a string list or an array.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> Use the <b>fields</b> parameter to limit properties returned for each record. By default, all fields are returned for identified records. 
 @param table_name Name of the table to perform operations on.
 @param body Data containing name-value pairs of records to retrieve.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as GET.
 */
-(void) getRecordsByPostWithCompletionBlock :(NSString*) table_name 
        body:(SWGGetRecordsRequest*) body 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        X-HTTP-METHOD:(NSString*) X-HTTP-METHOD 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 getRecords() - Retrieve one or more records.
 Here for SDK backwards compatibility, see getRecordsByFilter(), getRecordsByIds(), and getRecordsByPost()
 @param table_name Name of the table to perform operations on.
 @param ids Comma-delimited list of the identifiers of the records to retrieve.
 @param filter SQL-like filter to limit the records to retrieve.
 @param limit Set to limit the filter results.
 @param offset Set to offset the filter results to a particular record count.
 @param order SQL-like order containing field and direction for filter results.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param include_count Include the total number of filter results as meta data.
 @param include_schema Include the table schema as meta data.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) getRecordsWithCompletionBlock :(NSString*) table_name 
        ids:(NSString*) ids 
        filter:(NSString*) filter 
        limit:(NSNumber*) limit 
        offset:(NSNumber*) offset 
        order:(NSString*) order 
        fields:(NSString*) fields 
        include_count:(NSNumber*) include_count 
        include_schema:(NSNumber*) include_schema 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 createRecords() - Create one or more records.
 Posted data should be an array of records wrapped in a <b>record</b> element.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success. Use <b>fields</b> parameter to return more info.
 @param table_name Name of the table to perform operations on.
 @param body Data containing name-value pairs of records to create.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param rollback In batch scenarios, where supported, rollback all changes if any record of the batch fails. Default behavior is to halt and return results up to the first point of failure, leaving any changes.
 @param X-HTTP-METHOD Override request using POST to tunnel other http request, such as DELETE.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) createRecordsWithCompletionBlock :(NSString*) table_name 
        body:(SWGRecordsRequest*) body 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        rollback:(NSNumber*) rollback 
        X-HTTP-METHOD:(NSString*) X-HTTP-METHOD 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 replaceRecordsByIds() - Update (replace) one or more records.
 Posted body should be a single record with name-value pairs to update wrapped in a <b>record</b> tag.<br/> Ids can be included via URL parameter or included in the posted body.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success. Use <b>fields</b> parameter to return more info.
 @param table_name Name of the table to perform operations on.
 @param body Data containing name-value pairs of records to update.
 @param ids Comma-delimited list of the identifiers of the records to modify.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param rollback In batch scenarios, where supported, rollback all changes if any record of the batch fails. Default behavior is to halt and return results up to the first point of failure, leaving any changes.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) replaceRecordsByIdsWithCompletionBlock :(NSString*) table_name 
        body:(SWGIdsRecordRequest*) body 
        ids:(NSString*) ids 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        rollback:(NSNumber*) rollback 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 replaceRecordsByFilter() - Update (replace) one or more records.
 Posted body should be a single record with name-value pairs to update wrapped in a <b>record</b> tag.<br/> Filter can be included via URL parameter or included in the posted body.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success. Use <b>fields</b> parameter to return more info.
 @param table_name Name of the table to perform operations on.
 @param body Data containing name-value pairs of records to update.
 @param filter SQL-like filter to limit the records to modify.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) replaceRecordsByFilterWithCompletionBlock :(NSString*) table_name 
        body:(SWGFilterRecordRequest*) body 
        filter:(NSString*) filter 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 replaceRecords() - Update (replace) one or more records.
 Post data should be an array of records wrapped in a <b>record</b> tag.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success. Use <b>fields</b> parameter to return more info.
 @param table_name Name of the table to perform operations on.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param rollback In batch scenarios, where supported, rollback all changes if any record of the batch fails. Default behavior is to halt and return results up to the first point of failure, leaving any changes.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) replaceRecordsWithCompletionBlock :(NSString*) table_name 
        body:(SWGRecordsRequest*) body 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        rollback:(NSNumber*) rollback 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 updateRecordsByIds() - Update (patch) one or more records.
 Posted body should be a single record with name-value pairs to update wrapped in a <b>record</b> tag.<br/> Ids can be included via URL parameter or included in the posted body.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success. Use <b>fields</b> parameter to return more info.
 @param table_name Name of the table to perform operations on.
 @param body A single record containing name-value pairs of fields to update.
 @param ids Comma-delimited list of the identifiers of the records to modify.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param rollback In batch scenarios, where supported, rollback all changes if any record of the batch fails. Default behavior is to halt and return results up to the first point of failure, leaving any changes.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) updateRecordsByIdsWithCompletionBlock :(NSString*) table_name 
        body:(SWGIdsRecordRequest*) body 
        ids:(NSString*) ids 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        rollback:(NSNumber*) rollback 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 updateRecordsByFilter() - Update (patch) one or more records.
 Posted body should be a single record with name-value pairs to update wrapped in a <b>record</b> tag.<br/> Filter can be included via URL parameter or included in the posted body.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success. Use <b>fields</b> parameter to return more info.
 @param table_name Name of the table to perform operations on.
 @param body Data containing name-value pairs of fields to update.
 @param filter SQL-like filter to limit the records to modify.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) updateRecordsByFilterWithCompletionBlock :(NSString*) table_name 
        body:(SWGFilterRecordRequest*) body 
        filter:(NSString*) filter 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 updateRecords() - Update (patch) one or more records.
 Post data should be an array of records containing at least the identifying fields for each record.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success. Use <b>fields</b> parameter to return more info.
 @param table_name Name of the table to perform operations on.
 @param body Data containing name-value pairs of records to update.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param rollback In batch scenarios, where supported, rollback all changes if any record of the batch fails. Default behavior is to halt and return results up to the first point of failure, leaving any changes.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) updateRecordsWithCompletionBlock :(NSString*) table_name 
        body:(SWGRecordsRequest*) body 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        rollback:(NSNumber*) rollback 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 deleteRecordsByIds() - Delete one or more records.
 Set the <b>ids</b> parameter to a list of record identifying (primary key) values to delete specific records.<br/> Alternatively, to delete records by a large list of ids, pass the ids in the <b>body</b>.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success, use <b>fields</b> to return more info. 
 @param table_name Name of the table to perform operations on.
 @param ids Comma-delimited list of the identifiers of the records to delete.
 @param body Data containing ids of records to delete.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param rollback In batch scenarios, where supported, rollback all changes if any record of the batch fails. Default behavior is to halt and return results up to the first point of failure, leaving any changes.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) deleteRecordsByIdsWithCompletionBlock :(NSString*) table_name 
        ids:(NSString*) ids 
        body:(SWGIdsRequest*) body 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        rollback:(NSNumber*) rollback 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 deleteRecordsByFilter() - Delete one or more records by using a filter.
 Set the <b>filter</b> parameter to a SQL WHERE clause to delete specific records, otherwise set <b>force</b> to true to clear the table.<br/> Alternatively, to delete by a complicated filter or to use parameter replacement, pass the filter with or without params as the <b>body</b>.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success, use <b>fields</b> to return more info. 
 @param table_name Name of the table to perform operations on.
 @param filter SQL WHERE clause filter to limit the records deleted.
 @param body Data containing filter and/or params of records to delete.
 @param force Set force to true to delete all records in this table, otherwise &lt;b&gt;filter&lt;/b&gt; parameter is required.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) deleteRecordsByFilterWithCompletionBlock :(NSString*) table_name 
        filter:(NSString*) filter 
        body:(SWGFilterRequest*) body 
        force:(NSNumber*) force 
        fields:(NSString*) fields 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 deleteRecords() - Delete one or more records.
 Set the <b>body</b> to an array of records, minimally including the identifying fields, to delete specific records.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> By default, only the id property of the record is returned on success, use <b>fields</b> to return more info. 
 @param table_name Name of the table to perform operations on.
 @param body Data containing name-value pairs of records to delete.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param continue In batch scenarios, where supported, continue processing even after one record fails. Default behavior is to halt and return results up to the first point of failure.
 @param rollback In batch scenarios, where supported, rollback all changes if any record of the batch fails. Default behavior is to halt and return results up to the first point of failure, leaving any changes.
 @param filter For SDK backwards compatibility.
 @param ids For SDK backwards compatibility.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) deleteRecordsWithCompletionBlock :(NSString*) table_name 
        body:(SWGRecordsRequest*) body 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        continue:(NSNumber*) continue 
        rollback:(NSNumber*) rollback 
        filter:(NSString*) filter 
        ids:(NSString*) ids 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock;

/**

 getRecord() - Retrieve one record by identifier.
 Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> Use the <b>fields</b> parameter to limit properties that are returned. By default, all fields are returned.
 @param table_name Name of the table to perform operations on.
 @param _id Identifier of the record to retrieve.
 @param fields Comma-delimited list of field names to retrieve for the record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) getRecordWithCompletionBlock :(NSString*) table_name 
        _id:(NSString*) _id 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock;

/**

 createRecord() - Create one record with given identifier.
 Post data should be an array of fields for a single record.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> Use the <b>fields</b> parameter to return more properties. By default, the id is returned.
 @param table_name Name of the table to perform operations on.
 @param _id Identifier of the record to create.
 @param body Data containing name-value pairs of the record to create.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) createRecordWithCompletionBlock :(NSString*) table_name 
        _id:(NSString*) _id 
        body:(SWGRecordRequest*) body 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock;

/**

 replaceRecord() - Replace the content of one record by identifier.
 Post data should be an array of fields for a single record.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> Use the <b>fields</b> parameter to return more properties. By default, the id is returned.
 @param table_name Name of the table to perform operations on.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of the replacement record.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) replaceRecordWithCompletionBlock :(NSString*) table_name 
        _id:(NSString*) _id 
        body:(SWGRecordRequest*) body 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock;

/**

 updateRecord() - Update (patch) one record by identifier.
 Post data should be an array of fields for a single record.<br/> Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> Use the <b>fields</b> parameter to return more properties. By default, the id is returned.
 @param table_name The name of the table you want to update.
 @param _id Identifier of the record to update.
 @param body Data containing name-value pairs of the fields to update.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) updateRecordWithCompletionBlock :(NSString*) table_name 
        _id:(NSString*) _id 
        body:(SWGRecordRequest*) body 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock;

/**

 deleteRecord() - Delete one record by identifier.
 Use the <b>related</b> parameter to return related records for each resource. By default, no related records are returned.<br/> Use the <b>fields</b> parameter to return more deleted properties. By default, the id is returned.
 @param table_name Name of the table to perform operations on.
 @param _id Identifier of the record to delete.
 @param fields Comma-delimited list of field names to retrieve for each record, '*' to return all fields.
 @param id_field Single or comma-delimited list of the fields used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param id_type Single or comma-delimited list of the field types used as identifiers for the table, used to override defaults or provide identifiers when none are provisioned.
 @param related Comma-delimited list of relationship names to retrieve for each record, or '*' to retrieve all.
 */
-(void) deleteRecordWithCompletionBlock :(NSString*) table_name 
        _id:(NSString*) _id 
        fields:(NSString*) fields 
        id_field:(NSString*) id_field 
        id_type:(NSString*) id_type 
        related:(NSString*) related 
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock;

@end

#import <Foundation/Foundation.h>
#import "NIKApiInvoker.h"
#import "SWGFieldSchema.h"
#import "SWGFields.h"
#import "SWGResources.h"
#import "SWGTableSchema.h"
#import "SWGSuccess.h"
#import "SWGTables.h"


@interface SWGSchemaApi: NSObject {

@private
    NSOperationQueue *_queue;
    NIKApiInvoker * _api;
}
@property(nonatomic, readonly) NSOperationQueue* queue;
@property(nonatomic, readonly) NIKApiInvoker* api;

-(void) addHeader:(NSString*)value forKey:(NSString*)key;

/**

 getResources() - List resources available for database schema.
 See listed operations for each resource available.
 */
-(void) getResourcesWithCompletionBlock :(void (^)(SWGResources* output, NSError* error))completionBlock;

/**

 createTables() - Create one or more tables.
 Post data should be a single table definition or an array of table definitions.
 @param body Array of table definitions.
 */
-(void) createTablesWithCompletionBlock :(SWGTables*) body 
        completionHandler: (void (^)(SWGResources* output, NSError* error))completionBlock;

/**

 replaceTables() - Update (replace) one or more tables.
 Post data should be a single table definition or an array of table definitions.
 @param body Array of table definitions.
 */
-(void) replaceTablesWithCompletionBlock :(SWGTables*) body 
        completionHandler: (void (^)(SWGResources* output, NSError* error))completionBlock;

/**

 updateTables() - Update (patch) one or more tables.
 Post data should be a single table definition or an array of table definitions.
 @param body Array of table definitions.
 */
-(void) updateTablesWithCompletionBlock :(SWGTables*) body 
        completionHandler: (void (^)(SWGResources* output, NSError* error))completionBlock;

/**

 describeTable() - Retrieve table definition for the given table.
 This describes the table, its fields and relations to other tables.
 @param table_name Name of the table to perform operations on.
 */
-(void) describeTableWithCompletionBlock :(NSString*) table_name 
        completionHandler: (void (^)(SWGTableSchema* output, NSError* error))completionBlock;

/**

 createFields() - Create one or more fields in the given table.
 Post data should be an array of field properties for a single record or an array of fields.
 @param table_name Name of the table to perform operations on.
 @param body Array of field definitions.
 */
-(void) createFieldsWithCompletionBlock :(NSString*) table_name 
        body:(SWGFields*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 replaceFields() - Update (replace) one or more fields in the given table.
 Post data should be an array of field properties for a single record or an array of fields.
 @param table_name Name of the table to perform operations on.
 @param body Array of field definitions.
 */
-(void) replaceFieldsWithCompletionBlock :(NSString*) table_name 
        body:(SWGFields*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 updateFields() - Update (patch) one or more fields in the given table.
 Post data should be an array of field properties for a single record or an array of fields.
 @param table_name Name of the table to perform operations on.
 @param body Array of field definitions.
 */
-(void) updateFieldsWithCompletionBlock :(NSString*) table_name 
        body:(SWGFields*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 deleteTable() - Delete (aka drop) the given table.
 Careful, this drops the database table and all of its contents.
 @param table_name Name of the table to perform operations on.
 */
-(void) deleteTableWithCompletionBlock :(NSString*) table_name 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 describeField() - Retrieve the definition of the given field for the given table.
 This describes the field and its properties.
 @param table_name Name of the table to perform operations on.
 @param field_name Name of the field to perform operations on.
 */
-(void) describeFieldWithCompletionBlock :(NSString*) table_name 
        field_name:(NSString*) field_name 
        completionHandler: (void (^)(SWGFieldSchema* output, NSError* error))completionBlock;

/**

 replaceField() - Update one record by identifier.
 Post data should be an array of field properties for the given field.
 @param table_name Name of the table to perform operations on.
 @param field_name Name of the field to perform operations on.
 @param body Array of field properties.
 */
-(void) replaceFieldWithCompletionBlock :(NSString*) table_name 
        field_name:(NSString*) field_name 
        body:(SWGFieldSchema*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 updateField() - Update one record by identifier.
 Post data should be an array of field properties for the given field.
 @param table_name Name of the table to perform operations on.
 @param field_name Name of the field to perform operations on.
 @param body Array of field properties.
 */
-(void) updateFieldWithCompletionBlock :(NSString*) table_name 
        field_name:(NSString*) field_name 
        body:(SWGFieldSchema*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 deleteField() - Remove the given field from the given table.
 Careful, this drops the database table field/column and all of its contents.
 @param table_name Name of the table to perform operations on.
 @param field_name Name of the field to perform operations on.
 */
-(void) deleteFieldWithCompletionBlock :(NSString*) table_name 
        field_name:(NSString*) field_name 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

@end

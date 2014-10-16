#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGRelatedService : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* api_name;
@property(nonatomic) NSString* swgdescription;
@property(nonatomic) NSNumber* is_active;
@property(nonatomic) NSString* type;
@property(nonatomic) NSNumber* type_id;
@property(nonatomic) NSString* storage_type;
@property(nonatomic) NSNumber* storage_type_id;
@property(nonatomic) NSString* credentials;
@property(nonatomic) NSString* native_format;
@property(nonatomic) NSString* base_url;
@property(nonatomic) NSString* parameters;
@property(nonatomic) NSString* headers;
@property(nonatomic) NSString* created_date;
@property(nonatomic) NSNumber* created_by_id;
@property(nonatomic) NSString* last_modified_date;
@property(nonatomic) NSNumber* last_modified_by_id;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     api_name: (NSString*) api_name
     description: (NSString*) description
     is_active: (NSNumber*) is_active
     type: (NSString*) type
     type_id: (NSNumber*) type_id
     storage_type: (NSString*) storage_type
     storage_type_id: (NSNumber*) storage_type_id
     credentials: (NSString*) credentials
     native_format: (NSString*) native_format
     base_url: (NSString*) base_url
     parameters: (NSString*) parameters
     headers: (NSString*) headers
     created_date: (NSString*) created_date
     created_by_id: (NSNumber*) created_by_id
     last_modified_date: (NSString*) last_modified_date
     last_modified_by_id: (NSNumber*) last_modified_by_id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


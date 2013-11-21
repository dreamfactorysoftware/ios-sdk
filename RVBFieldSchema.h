#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "Integer.h"

@interface RVBFieldSchema : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* label;
@property(nonatomic) NSString* type;
@property(nonatomic) NSString* db_type;
@property(nonatomic) NSNumber* length;
@property(nonatomic) NSNumber* precision;
@property(nonatomic) NSNumber* scale;
@property(nonatomic) NSString* default;
@property(nonatomic) NSNumber* required;
@property(nonatomic) NSNumber* allow_null;
@property(nonatomic) NSNumber* fixed_length;
@property(nonatomic) NSNumber* supports_multibyte;
@property(nonatomic) NSNumber* auto_increment;
@property(nonatomic) NSNumber* is_primary_key;
@property(nonatomic) NSNumber* is_foreign_key;
@property(nonatomic) NSString* ref_table;
@property(nonatomic) NSString* ref_fields;
@property(nonatomic) NSArray* validation;
@property(nonatomic) NSArray* values;
- (id) name: (NSString*) name
     label: (NSString*) label
     type: (NSString*) type
     db_type: (NSString*) db_type
     length: (NSNumber*) length
     precision: (NSNumber*) precision
     scale: (NSNumber*) scale
     default: (NSString*) default
     required: (NSNumber*) required
     allow_null: (NSNumber*) allow_null
     fixed_length: (NSNumber*) fixed_length
     supports_multibyte: (NSNumber*) supports_multibyte
     auto_increment: (NSNumber*) auto_increment
     is_primary_key: (NSNumber*) is_primary_key
     is_foreign_key: (NSNumber*) is_foreign_key
     ref_table: (NSString*) ref_table
     ref_fields: (NSString*) ref_fields
     validation: (NSArray*) validation
     values: (NSArray*) values;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


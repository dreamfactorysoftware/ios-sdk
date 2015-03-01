#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGFieldSchema.h"
#import "SWGRelatedSchema.h"

@interface SWGTableSchema : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* label;
@property(nonatomic) NSString* plural;
@property(nonatomic) NSString* primary_key;
@property(nonatomic) NSString* name_field;
@property(nonatomic) NSArray* field;
@property(nonatomic) NSArray* related;
- (id) name: (NSString*) name
     label: (NSString*) label
     plural: (NSString*) plural
     primary_key: (NSString*) primary_key
     name_field: (NSString*) name_field
     field: (NSArray*) field
     related: (NSArray*) related;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


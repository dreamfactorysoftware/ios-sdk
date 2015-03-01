#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGRelatedSchema : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* type;
@property(nonatomic) NSString* ref_table;
@property(nonatomic) NSString* ref_field;
@property(nonatomic) NSString* join;
@property(nonatomic) NSString* field;
- (id) name: (NSString*) name
     type: (NSString*) type
     ref_table: (NSString*) ref_table
     ref_field: (NSString*) ref_field
     join: (NSString*) join
     field: (NSString*) field;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


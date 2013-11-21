#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBRVBRelatedSchema*.h"
#import "RVBRVBEmailAddress*.h"
#import "RVBFieldSchema.h"
#import "RVBEmailAddress.h"
#import "RVBRelatedSchema.h"
#import "RVBRVBFieldSchema*.h"

@interface RVBTableSchema : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSArray* label;
@property(nonatomic) NSArray* plural;
@property(nonatomic) NSString* primary_key;
@property(nonatomic) NSString* name_field;
@property(nonatomic) NSArray* field;
@property(nonatomic) NSArray* related;
- (id) name: (NSString*) name
     label: (NSArray*) label
     plural: (NSArray*) plural
     primary_key: (NSString*) primary_key
     name_field: (NSString*) name_field
     field: (NSArray*) field
     related: (NSArray*) related;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


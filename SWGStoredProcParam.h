#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGStoredProcParam : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* param_type;
@property(nonatomic) NSString* value;
@property(nonatomic) NSString* type;
@property(nonatomic) NSNumber* length;
- (id) name: (NSString*) name
     param_type: (NSString*) param_type
     value: (NSString*) value
     type: (NSString*) type
     length: (NSNumber*) length;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


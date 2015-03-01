#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGTableSchema.h"

@interface SWGTableSchemas : NIKSwaggerObject

@property(nonatomic) NSArray* table;
- (id) table: (NSArray*) table;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


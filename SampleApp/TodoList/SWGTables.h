#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGTableSchema.h"

@interface SWGTables : NIKSwaggerObject

@property(nonatomic) NSArray* field;
- (id) field: (NSArray*) field;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


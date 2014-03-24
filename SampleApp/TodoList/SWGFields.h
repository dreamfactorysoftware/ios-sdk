#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGFieldSchema.h"

@interface SWGFields : NIKSwaggerObject

@property(nonatomic) NSArray* field;
- (id) field: (NSArray*) field;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


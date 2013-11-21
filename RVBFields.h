#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBFieldSchema.h"
#import "RVBRVBFieldSchema*.h"

@interface RVBFields : NIKSwaggerObject

@property(nonatomic) NSArray* field;
- (id) field: (NSArray*) field;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


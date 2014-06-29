#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGIdsRequest : NIKSwaggerObject

@property(nonatomic) NSArray* ids;
- (id) ids: (NSArray*) ids;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


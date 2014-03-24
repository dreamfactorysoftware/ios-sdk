#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGResource.h"

@interface SWGResources : NIKSwaggerObject

@property(nonatomic) NSArray* resource;
- (id) resource: (NSArray*) resource;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


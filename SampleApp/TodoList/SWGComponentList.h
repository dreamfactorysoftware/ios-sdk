#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGComponentList : NIKSwaggerObject

@property(nonatomic) NSArray* resource;
- (id) resource: (NSArray*) resource;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGContainer.h"

@interface SWGContainersRequest : NIKSwaggerObject

@property(nonatomic) NSArray* container;
- (id) container: (NSArray*) container;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


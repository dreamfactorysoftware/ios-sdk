#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGEventRequest.h"

@interface SWGEventsRequest : NIKSwaggerObject

@property(nonatomic) NSArray* record;
- (id) record: (NSArray*) record;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


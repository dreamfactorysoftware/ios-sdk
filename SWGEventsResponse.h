#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGEventResponse.h"

@interface SWGEventsResponse : NIKSwaggerObject

@property(nonatomic) NSArray* record;
- (id) record: (NSArray*) record;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


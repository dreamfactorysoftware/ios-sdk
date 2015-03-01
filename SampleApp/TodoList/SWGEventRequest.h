#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGEventRequest : NIKSwaggerObject

@property(nonatomic) NSString* event_name;
@property(nonatomic) NSArray* listeners;
- (id) event_name: (NSString*) event_name
     listeners: (NSArray*) listeners;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGDeviceResponse.h"

@interface SWGDevicesResponse : NIKSwaggerObject

@property(nonatomic) NSArray* record;
- (id) record: (NSArray*) record;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


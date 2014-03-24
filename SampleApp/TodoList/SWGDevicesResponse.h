#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGDeviceResponse.h"
#import "SWGMetadata.h"

@interface SWGDevicesResponse : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) SWGMetadata* meta;
- (id) record: (NSArray*) record
     meta: (SWGMetadata*) meta;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


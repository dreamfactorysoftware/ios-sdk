#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGPlatformSection : NIKSwaggerObject

@property(nonatomic) NSNumber* is_hosted;
@property(nonatomic) NSNumber* is_private;
@property(nonatomic) NSString* dsp_version_current;
@property(nonatomic) NSString* dsp_version_latest;
@property(nonatomic) NSNumber* upgrade_available;
- (id) is_hosted: (NSNumber*) is_hosted
     is_private: (NSNumber*) is_private
     dsp_version_current: (NSString*) dsp_version_current
     dsp_version_latest: (NSString*) dsp_version_latest
     upgrade_available: (NSNumber*) upgrade_available;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


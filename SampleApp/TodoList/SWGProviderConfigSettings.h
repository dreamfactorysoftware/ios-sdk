#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGProviderConfigSetting.h"

@interface SWGProviderConfigSettings : NIKSwaggerObject

@property(nonatomic) NSArray* settings;
- (id) settings: (NSArray*) settings;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


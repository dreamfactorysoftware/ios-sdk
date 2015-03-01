#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGCustomSetting.h"

@interface SWGCustomSettings : NIKSwaggerObject

@property(nonatomic) NSArray* name;
- (id) name: (NSArray*) name;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


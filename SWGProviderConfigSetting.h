#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGProviderConfigSetting : NIKSwaggerObject

@property(nonatomic) NSString* key;
@property(nonatomic) NSString* value;
- (id) key: (NSString*) key
     value: (NSString*) value;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


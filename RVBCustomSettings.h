#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBRVBCustomSetting*.h"
#import "RVBCustomSetting.h"

@interface RVBCustomSettings : NIKSwaggerObject

@property(nonatomic) NSArray* type_name;
- (id) type_name: (NSArray*) type_name;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


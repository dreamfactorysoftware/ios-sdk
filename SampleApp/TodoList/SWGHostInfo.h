#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGHostInfo : NIKSwaggerObject

@property(nonatomic) NSString* host;
@property(nonatomic) NSNumber* is_enabled;
@property(nonatomic) NSArray* verbs;
- (id) host: (NSString*) host
     is_enabled: (NSNumber*) is_enabled
     verbs: (NSArray*) verbs;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface RVBResource : NIKSwaggerObject

@property(nonatomic) NSString* name;
- (id) name: (NSString*) name;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGConstant : NIKSwaggerObject

@property(nonatomic) NSArray* name;
- (id) name: (NSArray*) name;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


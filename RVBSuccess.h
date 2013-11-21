#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface RVBSuccess : NIKSwaggerObject

@property(nonatomic) NSNumber* success;
- (id) success: (NSNumber*) success;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


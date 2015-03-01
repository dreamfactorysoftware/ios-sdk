#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGPhpInfoSection : NIKSwaggerObject

@property(nonatomic) NSArray* name;
- (id) name: (NSArray*) name;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


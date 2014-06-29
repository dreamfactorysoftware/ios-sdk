#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGFilterRequest : NIKSwaggerObject

@property(nonatomic) NSString* filter;
@property(nonatomic) NSArray* params;
- (id) filter: (NSString*) filter
     params: (NSArray*) params;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


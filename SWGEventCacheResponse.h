#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGEventPaths.h"

@interface SWGEventCacheResponse : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSArray* paths;
- (id) name: (NSString*) name
     paths: (NSArray*) paths;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


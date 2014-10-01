#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGEventVerbs.h"

@interface SWGEventPaths : NIKSwaggerObject

@property(nonatomic) NSString* path;
@property(nonatomic) NSArray* verbs;
- (id) path: (NSString*) path
     verbs: (NSArray*) verbs;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


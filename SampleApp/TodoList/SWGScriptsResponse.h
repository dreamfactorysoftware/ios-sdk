#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGScriptResponse.h"

@interface SWGScriptsResponse : NIKSwaggerObject

@property(nonatomic) NSArray* script;
- (id) script: (NSArray*) script;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


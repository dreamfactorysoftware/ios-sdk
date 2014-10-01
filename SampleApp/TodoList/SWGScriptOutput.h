#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGScriptOutput : NIKSwaggerObject

@property(nonatomic) NSString* script_output;
@property(nonatomic) NSString* script_last_variable;
- (id) script_output: (NSString*) script_output
     script_last_variable: (NSString*) script_last_variable;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


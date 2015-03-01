#import "NIKDate.h"
#import "SWGScriptOutput.h"

@implementation SWGScriptOutput

-(id)script_output: (NSString*) script_output
    script_last_variable: (NSString*) script_last_variable
{
  _script_output = script_output;
  _script_last_variable = script_last_variable;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _script_output = dict[@"script_output"]; 
        _script_last_variable = dict[@"script_last_variable"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_script_output != nil) dict[@"script_output"] = _script_output ;
    if(_script_last_variable != nil) dict[@"script_last_variable"] = _script_last_variable ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "SWGScriptsResponse.h"

@implementation SWGScriptsResponse

-(id)script: (NSArray*) script
{
  _script = script;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id script_dict = dict[@"script"];
        if([script_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)script_dict count]];

            if([(NSArray*)script_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)script_dict) {
                    SWGScriptResponse* d = [[SWGScriptResponse alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _script = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _script = [[NSArray alloc] init];
            }
        }
        else {
            _script = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_script != nil){
        if([_script isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGScriptResponse *script in (NSArray*)_script) {
                [array addObject:[(NIKSwaggerObject*)script asDictionary]];
            }
            dict[@"script"] = array;
        }
        else if(_script && [_script isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_script toString];
            if(dateString){
                dict[@"script"] = dateString;
            }
        }
    }
    else {
    if(_script != nil) dict[@"script"] = [(NIKSwaggerObject*)_script asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


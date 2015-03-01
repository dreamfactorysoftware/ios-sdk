#import "NIKDate.h"
#import "SWGHostInfo.h"

@implementation SWGHostInfo

-(id)host: (NSString*) host
    is_enabled: (NSNumber*) is_enabled
    verbs: (NSArray*) verbs
{
  _host = host;
  _is_enabled = is_enabled;
  _verbs = verbs;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _host = dict[@"host"]; 
        _is_enabled = dict[@"is_enabled"]; 
        _verbs = dict[@"verbs"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_host != nil) dict[@"host"] = _host ;
    if(_is_enabled != nil) dict[@"is_enabled"] = _is_enabled ;
    if(_verbs != nil) dict[@"verbs"] = _verbs ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


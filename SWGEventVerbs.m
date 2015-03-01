#import "NIKDate.h"
#import "SWGEventVerbs.h"

@implementation SWGEventVerbs

-(id)type: (NSString*) type
    event: (NSArray*) event
    scripts: (NSArray*) scripts
    listeners: (NSArray*) listeners
{
  _type = type;
  _event = event;
  _scripts = scripts;
  _listeners = listeners;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _type = dict[@"type"]; 
        _event = dict[@"event"]; 
        _scripts = dict[@"scripts"]; 
        _listeners = dict[@"listeners"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_type != nil) dict[@"type"] = _type ;
    if(_event != nil) dict[@"event"] = _event ;
    if(_scripts != nil) dict[@"scripts"] = _scripts ;
    if(_listeners != nil) dict[@"listeners"] = _listeners ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


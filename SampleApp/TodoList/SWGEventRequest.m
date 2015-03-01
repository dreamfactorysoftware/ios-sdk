#import "NIKDate.h"
#import "SWGEventRequest.h"

@implementation SWGEventRequest

-(id)event_name: (NSString*) event_name
    listeners: (NSArray*) listeners
{
  _event_name = event_name;
  _listeners = listeners;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _event_name = dict[@"event_name"]; 
        _listeners = dict[@"listeners"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_event_name != nil) dict[@"event_name"] = _event_name ;
    if(_listeners != nil) dict[@"listeners"] = _listeners ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


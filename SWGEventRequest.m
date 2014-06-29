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
        id listeners_dict = dict[@"listeners"];
        if([listeners_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)listeners_dict count]];

            if([(NSArray*)listeners_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)listeners_dict) {
                    NSArray* d = [[NSArray alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _listeners = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _listeners = [[NSArray alloc] init];
            }
        }
        else {
            _listeners = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_event_name != nil) dict[@"event_name"] = _event_name ;
    if(_listeners != nil){
        if([_listeners isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( NSArray *listeners in (NSArray*)_listeners) {
                [array addObject:[(NIKSwaggerObject*)listeners asDictionary]];
            }
            dict[@"listeners"] = array;
        }
        else if(_listeners && [_listeners isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_listeners toString];
            if(dateString){
                dict[@"listeners"] = dateString;
            }
        }
    }
    else {
    if(_listeners != nil) dict[@"listeners"] = [(NIKSwaggerObject*)_listeners asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


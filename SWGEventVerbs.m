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
        id event_dict = dict[@"event"];
        if([event_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)event_dict count]];

            if([(NSArray*)event_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)event_dict) {
                    NSArray* d = [[NSArray alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _event = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _event = [[NSArray alloc] init];
            }
        }
        else {
            _event = [[NSArray alloc] init];
        }
        id scripts_dict = dict[@"scripts"];
        if([scripts_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)scripts_dict count]];

            if([(NSArray*)scripts_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)scripts_dict) {
                    NSArray* d = [[NSArray alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _scripts = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _scripts = [[NSArray alloc] init];
            }
        }
        else {
            _scripts = [[NSArray alloc] init];
        }
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
    if(_type != nil) dict[@"type"] = _type ;
    if(_event != nil){
        if([_event isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( NSArray *event in (NSArray*)_event) {
                [array addObject:[(NIKSwaggerObject*)event asDictionary]];
            }
            dict[@"event"] = array;
        }
        else if(_event && [_event isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_event toString];
            if(dateString){
                dict[@"event"] = dateString;
            }
        }
    }
    else {
    if(_event != nil) dict[@"event"] = [(NIKSwaggerObject*)_event asDictionary];
    }
    if(_scripts != nil){
        if([_scripts isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( NSArray *scripts in (NSArray*)_scripts) {
                [array addObject:[(NIKSwaggerObject*)scripts asDictionary]];
            }
            dict[@"scripts"] = array;
        }
        else if(_scripts && [_scripts isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_scripts toString];
            if(dateString){
                dict[@"scripts"] = dateString;
            }
        }
    }
    else {
    if(_scripts != nil) dict[@"scripts"] = [(NIKSwaggerObject*)_scripts asDictionary];
    }
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


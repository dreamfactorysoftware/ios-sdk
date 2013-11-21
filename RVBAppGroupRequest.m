#import "NIKDate.h"
#import "RVBAppGroupRequest.h"

@implementation RVBAppGroupRequest

-(id)_id: (NSNumber*) _id
    name: (NSString*) name
    description: (NSString*) description
    apps: (NSArray*) apps
{
  __id = _id;
  _name = name;
  _description = description;
  _apps = apps;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __id = dict[@"id"]; 
        _name = dict[@"name"]; 
        _description = dict[@"description"]; 
        id apps_dict = dict[@"apps"];
        if([apps_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)apps_dict count]];

            if([(NSArray*)apps_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)apps_dict) {
                    RVBApp* d = [[RVBApp alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _apps = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _apps = [[NSArray alloc] init];
            }
        }
        else {
            _apps = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__id != nil) dict[@"id"] = __id ;
    if(_name != nil) dict[@"name"] = _name ;
    if(_description != nil) dict[@"description"] = _description ;
    if(_apps != nil){
        if([_apps isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBApp *apps in (NSArray*)_apps) {
                [array addObject:[(NIKSwaggerObject*)apps asDictionary]];
            }
            dict[@"apps"] = array;
        }
        else if(_apps && [_apps isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_apps toString];
            if(dateString){
                dict[@"apps"] = dateString;
            }
        }
    }
    else {
    if(_apps != nil) dict[@"apps"] = [(NIKSwaggerObject*)_apps asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


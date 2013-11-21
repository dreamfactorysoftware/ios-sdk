#import "NIKDate.h"
#import "RVBAppGroupResponse.h"

@implementation RVBAppGroupResponse

-(id)_id: (NSNumber*) _id
    name: (NSString*) name
    description: (NSString*) description
    apps: (NSArray*) apps
    created_date: (NSString*) created_date
    created_by_id: (NSNumber*) created_by_id
    last_modified_date: (NSString*) last_modified_date
    last_modified_by_id: (NSNumber*) last_modified_by_id
{
  __id = _id;
  _name = name;
  _description = description;
  _apps = apps;
  _created_date = created_date;
  _created_by_id = created_by_id;
  _last_modified_date = last_modified_date;
  _last_modified_by_id = last_modified_by_id;
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
        _created_date = dict[@"created_date"]; 
        _created_by_id = dict[@"created_by_id"]; 
        _last_modified_date = dict[@"last_modified_date"]; 
        _last_modified_by_id = dict[@"last_modified_by_id"]; 
        

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
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


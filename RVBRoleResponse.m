#import "NIKDate.h"
#import "RVBRoleResponse.h"

@implementation RVBRoleResponse

-(id)_id: (NSNumber*) _id
    name: (NSString*) name
    description: (NSString*) description
    is_active: (NSNumber*) is_active
    default_app_id: (NSNumber*) default_app_id
    default_app: (RVBApp*) default_app
    users: (NSArray*) users
    apps: (NSArray*) apps
    services: (NSArray*) services
    created_date: (NSString*) created_date
    created_by_id: (NSNumber*) created_by_id
    last_modified_date: (NSString*) last_modified_date
    last_modified_by_id: (NSNumber*) last_modified_by_id
{
  __id = _id;
  _name = name;
  _description = description;
  _is_active = is_active;
  _default_app_id = default_app_id;
  _default_app = default_app;
  _users = users;
  _apps = apps;
  _services = services;
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
        _is_active = dict[@"is_active"]; 
        _default_app_id = dict[@"default_app_id"]; 
        id default_app_dict = dict[@"default_app"];
        _default_app = [[RVBApp alloc]initWithValues:default_app_dict];
        _users = dict[@"users"]; 
        _apps = dict[@"apps"]; 
        _services = dict[@"services"]; 
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
    if(_is_active != nil) dict[@"is_active"] = _is_active ;
    if(_default_app_id != nil) dict[@"default_app_id"] = _default_app_id ;
    if(_default_app != nil){
        if([_default_app isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBApp *default_app in (NSArray*)_default_app) {
                [array addObject:[(NIKSwaggerObject*)default_app asDictionary]];
            }
            dict[@"default_app"] = array;
        }
        else if(_default_app && [_default_app isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_default_app toString];
            if(dateString){
                dict[@"default_app"] = dateString;
            }
        }
    }
    else {
    if(_default_app != nil) dict[@"default_app"] = [(NIKSwaggerObject*)_default_app asDictionary];
    }
    if(_users != nil) dict[@"users"] = _users ;
    if(_apps != nil) dict[@"apps"] = _apps ;
    if(_services != nil) dict[@"services"] = _services ;
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


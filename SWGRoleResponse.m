#import "NIKDate.h"
#import "SWGRoleResponse.h"

@implementation SWGRoleResponse

-(id)_id: (NSNumber*) _id
    name: (NSString*) name
    description: (NSString*) description
    is_active: (NSNumber*) is_active
    default_app_id: (NSNumber*) default_app_id
    default_app: (SWGRelatedApp*) default_app
    users: (SWGRelatedUsers*) users
    apps: (SWGRelatedApps*) apps
    services: (SWGRelatedServices*) services
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
        _default_app = [[SWGRelatedApp alloc]initWithValues:default_app_dict];
        id users_dict = dict[@"users"];
        _users = [[SWGRelatedUsers alloc]initWithValues:users_dict];
        id apps_dict = dict[@"apps"];
        _apps = [[SWGRelatedApps alloc]initWithValues:apps_dict];
        id services_dict = dict[@"services"];
        _services = [[SWGRelatedServices alloc]initWithValues:services_dict];
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
            for( SWGRelatedApp *default_app in (NSArray*)_default_app) {
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
    if(_users != nil){
        if([_users isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRelatedUsers *users in (NSArray*)_users) {
                [array addObject:[(NIKSwaggerObject*)users asDictionary]];
            }
            dict[@"users"] = array;
        }
        else if(_users && [_users isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_users toString];
            if(dateString){
                dict[@"users"] = dateString;
            }
        }
    }
    else {
    if(_users != nil) dict[@"users"] = [(NIKSwaggerObject*)_users asDictionary];
    }
    if(_apps != nil){
        if([_apps isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRelatedApps *apps in (NSArray*)_apps) {
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
    if(_services != nil){
        if([_services isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRelatedServices *services in (NSArray*)_services) {
                [array addObject:[(NIKSwaggerObject*)services asDictionary]];
            }
            dict[@"services"] = array;
        }
        else if(_services && [_services isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_services toString];
            if(dateString){
                dict[@"services"] = dateString;
            }
        }
    }
    else {
    if(_services != nil) dict[@"services"] = [(NIKSwaggerObject*)_services asDictionary];
    }
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


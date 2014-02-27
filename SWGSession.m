#import "NIKDate.h"
#import "SWGSession.h"

@implementation SWGSession

-(id)_id: (NSString*) _id
    email: (NSString*) email
    first_name: (NSString*) first_name
    last_name: (NSString*) last_name
    display_name: (NSString*) display_name
    is_sys_admin: (NSNumber*) is_sys_admin
    role: (NSString*) role
    last_login_date: (NSString*) last_login_date
    app_groups: (NSArray*) app_groups
    no_group_apps: (NSArray*) no_group_apps
    session_id: (NSString*) session_id
    ticket: (NSString*) ticket
    ticket_expiry: (NSString*) ticket_expiry
{
  __id = _id;
  _email = email;
  _first_name = first_name;
  _last_name = last_name;
  _display_name = display_name;
  _is_sys_admin = is_sys_admin;
  _role = role;
  _last_login_date = last_login_date;
  _app_groups = app_groups;
  _no_group_apps = no_group_apps;
  _session_id = session_id;
  _ticket = ticket;
  _ticket_expiry = ticket_expiry;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __id = dict[@"id"]; 
        _email = dict[@"email"]; 
        _first_name = dict[@"first_name"]; 
        _last_name = dict[@"last_name"]; 
        _display_name = dict[@"display_name"]; 
        _is_sys_admin = dict[@"is_sys_admin"]; 
        _role = dict[@"role"]; 
        _last_login_date = dict[@"last_login_date"]; 
        id app_groups_dict = dict[@"app_groups"];
        if([app_groups_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)app_groups_dict count]];

            if([(NSArray*)app_groups_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)app_groups_dict) {
                    SWGSessionApp* d = [[SWGSessionApp alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _app_groups = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _app_groups = [[NSArray alloc] init];
            }
        }
        else {
            _app_groups = [[NSArray alloc] init];
        }
        id no_group_apps_dict = dict[@"no_group_apps"];
        if([no_group_apps_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)no_group_apps_dict count]];

            if([(NSArray*)no_group_apps_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)no_group_apps_dict) {
                    SWGSessionApp* d = [[SWGSessionApp alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _no_group_apps = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _no_group_apps = [[NSArray alloc] init];
            }
        }
        else {
            _no_group_apps = [[NSArray alloc] init];
        }
        _session_id = dict[@"session_id"]; 
        _ticket = dict[@"ticket"]; 
        _ticket_expiry = dict[@"ticket_expiry"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__id != nil) dict[@"id"] = __id ;
    if(_email != nil) dict[@"email"] = _email ;
    if(_first_name != nil) dict[@"first_name"] = _first_name ;
    if(_last_name != nil) dict[@"last_name"] = _last_name ;
    if(_display_name != nil) dict[@"display_name"] = _display_name ;
    if(_is_sys_admin != nil) dict[@"is_sys_admin"] = _is_sys_admin ;
    if(_role != nil) dict[@"role"] = _role ;
    if(_last_login_date != nil) dict[@"last_login_date"] = _last_login_date ;
    if(_app_groups != nil){
        if([_app_groups isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGSessionApp *app_groups in (NSArray*)_app_groups) {
                [array addObject:[(NIKSwaggerObject*)app_groups asDictionary]];
            }
            dict[@"app_groups"] = array;
        }
        else if(_app_groups && [_app_groups isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_app_groups toString];
            if(dateString){
                dict[@"app_groups"] = dateString;
            }
        }
    }
    else {
    if(_app_groups != nil) dict[@"app_groups"] = [(NIKSwaggerObject*)_app_groups asDictionary];
    }
    if(_no_group_apps != nil){
        if([_no_group_apps isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGSessionApp *no_group_apps in (NSArray*)_no_group_apps) {
                [array addObject:[(NIKSwaggerObject*)no_group_apps asDictionary]];
            }
            dict[@"no_group_apps"] = array;
        }
        else if(_no_group_apps && [_no_group_apps isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_no_group_apps toString];
            if(dateString){
                dict[@"no_group_apps"] = dateString;
            }
        }
    }
    else {
    if(_no_group_apps != nil) dict[@"no_group_apps"] = [(NIKSwaggerObject*)_no_group_apps asDictionary];
    }
    if(_session_id != nil) dict[@"session_id"] = _session_id ;
    if(_ticket != nil) dict[@"ticket"] = _ticket ;
    if(_ticket_expiry != nil) dict[@"ticket_expiry"] = _ticket_expiry ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


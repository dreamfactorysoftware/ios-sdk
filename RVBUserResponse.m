#import "NIKDate.h"
#import "RVBUserResponse.h"

@implementation RVBUserResponse

-(id)_id: (NSNumber*) _id
    email: (NSString*) email
    password: (NSString*) password
    first_name: (NSString*) first_name
    last_name: (NSString*) last_name
    display_name: (NSString*) display_name
    phone: (NSString*) phone
    is_active: (NSNumber*) is_active
    is_sys_admin: (NSNumber*) is_sys_admin
    default_app_id: (NSString*) default_app_id
    role_id: (NSString*) role_id
    default_app: (RVBApp*) default_app
    role: (RVBRole*) role
    last_login_date: (NSString*) last_login_date
    created_date: (NSString*) created_date
    created_by_id: (NSNumber*) created_by_id
    last_modified_date: (NSString*) last_modified_date
    last_modified_by_id: (NSNumber*) last_modified_by_id
{
  __id = _id;
  _email = email;
  _password = password;
  _first_name = first_name;
  _last_name = last_name;
  _display_name = display_name;
  _phone = phone;
  _is_active = is_active;
  _is_sys_admin = is_sys_admin;
  _default_app_id = default_app_id;
  _role_id = role_id;
  _default_app = default_app;
  _role = role;
  _last_login_date = last_login_date;
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
        _email = dict[@"email"]; 
        _password = dict[@"password"]; 
        _first_name = dict[@"first_name"]; 
        _last_name = dict[@"last_name"]; 
        _display_name = dict[@"display_name"]; 
        _phone = dict[@"phone"]; 
        _is_active = dict[@"is_active"]; 
        _is_sys_admin = dict[@"is_sys_admin"]; 
        _default_app_id = dict[@"default_app_id"]; 
        _role_id = dict[@"role_id"]; 
        id default_app_dict = dict[@"default_app"];
        _default_app = [[RVBApp alloc]initWithValues:default_app_dict];
        id role_dict = dict[@"role"];
        _role = [[RVBRole alloc]initWithValues:role_dict];
        _last_login_date = dict[@"last_login_date"]; 
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
    if(_email != nil) dict[@"email"] = _email ;
    if(_password != nil) dict[@"password"] = _password ;
    if(_first_name != nil) dict[@"first_name"] = _first_name ;
    if(_last_name != nil) dict[@"last_name"] = _last_name ;
    if(_display_name != nil) dict[@"display_name"] = _display_name ;
    if(_phone != nil) dict[@"phone"] = _phone ;
    if(_is_active != nil) dict[@"is_active"] = _is_active ;
    if(_is_sys_admin != nil) dict[@"is_sys_admin"] = _is_sys_admin ;
    if(_default_app_id != nil) dict[@"default_app_id"] = _default_app_id ;
    if(_role_id != nil) dict[@"role_id"] = _role_id ;
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
    if(_role != nil){
        if([_role isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBRole *role in (NSArray*)_role) {
                [array addObject:[(NIKSwaggerObject*)role asDictionary]];
            }
            dict[@"role"] = array;
        }
        else if(_role && [_role isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_role toString];
            if(dateString){
                dict[@"role"] = dateString;
            }
        }
    }
    else {
    if(_role != nil) dict[@"role"] = [(NIKSwaggerObject*)_role asDictionary];
    }
    if(_last_login_date != nil) dict[@"last_login_date"] = _last_login_date ;
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


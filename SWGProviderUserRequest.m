#import "NIKDate.h"
#import "SWGProviderUserRequest.h"

@implementation SWGProviderUserRequest

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
    default_app: (SWGRelatedApp*) default_app
    role: (SWGRelatedRole*) role
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
        _default_app = [[SWGRelatedApp alloc]initWithValues:default_app_dict];
        id role_dict = dict[@"role"];
        _role = [[SWGRelatedRole alloc]initWithValues:role_dict];
        

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
    if(_role != nil){
        if([_role isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRelatedRole *role in (NSArray*)_role) {
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
    NSDictionary* output = [dict copy];
    return output;
}

@end


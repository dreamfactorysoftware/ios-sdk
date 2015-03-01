#import "NIKDate.h"
#import "SWGRelatedUser.h"

@implementation SWGRelatedUser

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
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


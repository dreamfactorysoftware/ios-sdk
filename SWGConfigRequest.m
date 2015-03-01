#import "NIKDate.h"
#import "SWGConfigRequest.h"

@implementation SWGConfigRequest

-(id)open_reg_role_id: (NSNumber*) open_reg_role_id
    open_reg_email_service_id: (NSNumber*) open_reg_email_service_id
    open_reg_email_template_id: (NSNumber*) open_reg_email_template_id
    invite_email_service_id: (NSNumber*) invite_email_service_id
    invite_email_template_id: (NSNumber*) invite_email_template_id
    password_email_service_id: (NSNumber*) password_email_service_id
    password_email_template_id: (NSNumber*) password_email_template_id
    guest_role_id: (NSNumber*) guest_role_id
    editable_profile_fields: (NSString*) editable_profile_fields
    allowed_hosts: (NSArray*) allowed_hosts
    restricted_verbs: (NSArray*) restricted_verbs
    install_type: (NSNumber*) install_type
    install_name: (NSString*) install_name
    is_hosted: (NSNumber*) is_hosted
    is_private: (NSNumber*) is_private
    is_guest: (NSNumber*) is_guest
{
  _open_reg_role_id = open_reg_role_id;
  _open_reg_email_service_id = open_reg_email_service_id;
  _open_reg_email_template_id = open_reg_email_template_id;
  _invite_email_service_id = invite_email_service_id;
  _invite_email_template_id = invite_email_template_id;
  _password_email_service_id = password_email_service_id;
  _password_email_template_id = password_email_template_id;
  _guest_role_id = guest_role_id;
  _editable_profile_fields = editable_profile_fields;
  _allowed_hosts = allowed_hosts;
  _restricted_verbs = restricted_verbs;
  _install_type = install_type;
  _install_name = install_name;
  _is_hosted = is_hosted;
  _is_private = is_private;
  _is_guest = is_guest;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _open_reg_role_id = dict[@"open_reg_role_id"]; 
        _open_reg_email_service_id = dict[@"open_reg_email_service_id"]; 
        _open_reg_email_template_id = dict[@"open_reg_email_template_id"]; 
        _invite_email_service_id = dict[@"invite_email_service_id"]; 
        _invite_email_template_id = dict[@"invite_email_template_id"]; 
        _password_email_service_id = dict[@"password_email_service_id"]; 
        _password_email_template_id = dict[@"password_email_template_id"]; 
        _guest_role_id = dict[@"guest_role_id"]; 
        _editable_profile_fields = dict[@"editable_profile_fields"]; 
        id allowed_hosts_dict = dict[@"allowed_hosts"];
        if([allowed_hosts_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)allowed_hosts_dict count]];

            if([(NSArray*)allowed_hosts_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)allowed_hosts_dict) {
                    SWGHostInfo* d = [[SWGHostInfo alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _allowed_hosts = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _allowed_hosts = [[NSArray alloc] init];
            }
        }
        else {
            _allowed_hosts = [[NSArray alloc] init];
        }
        _restricted_verbs = dict[@"restricted_verbs"]; 
        _install_type = dict[@"install_type"]; 
        _install_name = dict[@"install_name"]; 
        _is_hosted = dict[@"is_hosted"]; 
        _is_private = dict[@"is_private"]; 
        _is_guest = dict[@"is_guest"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_open_reg_role_id != nil) dict[@"open_reg_role_id"] = _open_reg_role_id ;
    if(_open_reg_email_service_id != nil) dict[@"open_reg_email_service_id"] = _open_reg_email_service_id ;
    if(_open_reg_email_template_id != nil) dict[@"open_reg_email_template_id"] = _open_reg_email_template_id ;
    if(_invite_email_service_id != nil) dict[@"invite_email_service_id"] = _invite_email_service_id ;
    if(_invite_email_template_id != nil) dict[@"invite_email_template_id"] = _invite_email_template_id ;
    if(_password_email_service_id != nil) dict[@"password_email_service_id"] = _password_email_service_id ;
    if(_password_email_template_id != nil) dict[@"password_email_template_id"] = _password_email_template_id ;
    if(_guest_role_id != nil) dict[@"guest_role_id"] = _guest_role_id ;
    if(_editable_profile_fields != nil) dict[@"editable_profile_fields"] = _editable_profile_fields ;
    if(_allowed_hosts != nil){
        if([_allowed_hosts isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGHostInfo *allowed_hosts in (NSArray*)_allowed_hosts) {
                [array addObject:[(NIKSwaggerObject*)allowed_hosts asDictionary]];
            }
            dict[@"allowed_hosts"] = array;
        }
        else if(_allowed_hosts && [_allowed_hosts isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_allowed_hosts toString];
            if(dateString){
                dict[@"allowed_hosts"] = dateString;
            }
        }
    }
    else {
    if(_allowed_hosts != nil) dict[@"allowed_hosts"] = [(NIKSwaggerObject*)_allowed_hosts asDictionary];
    }
    if(_restricted_verbs != nil) dict[@"restricted_verbs"] = _restricted_verbs ;
    if(_install_type != nil) dict[@"install_type"] = _install_type ;
    if(_install_name != nil) dict[@"install_name"] = _install_name ;
    if(_is_hosted != nil) dict[@"is_hosted"] = _is_hosted ;
    if(_is_private != nil) dict[@"is_private"] = _is_private ;
    if(_is_guest != nil) dict[@"is_guest"] = _is_guest ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "RVBConfigRequest.h"

@implementation RVBConfigRequest

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
                    RVBHostInfo* d = [[RVBHostInfo alloc] initWithValues:dict];
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
            for( RVBHostInfo *allowed_hosts in (NSArray*)_allowed_hosts) {
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
    NSDictionary* output = [dict copy];
    return output;
}

@end


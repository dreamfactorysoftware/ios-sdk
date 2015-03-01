#import "NIKDate.h"
#import "SWGServiceResponse.h"

@implementation SWGServiceResponse

-(id)_id: (NSNumber*) _id
    name: (NSString*) name
    api_name: (NSString*) api_name
    swg_description: (NSString*) swg_description
    is_active: (NSNumber*) is_active
    type: (NSString*) type
    type_id: (NSNumber*) type_id
    storage_type: (NSString*) storage_type
    storage_type_id: (NSNumber*) storage_type_id
    credentials: (NSString*) credentials
    native_format: (NSString*) native_format
    base_url: (NSString*) base_url
    parameters: (NSString*) parameters
    headers: (NSString*) headers
    apps: (SWGRelatedApps*) apps
    roles: (SWGRelatedRoles*) roles
    created_date: (NSString*) created_date
    created_by_id: (NSNumber*) created_by_id
    last_modified_date: (NSString*) last_modified_date
    last_modified_by_id: (NSNumber*) last_modified_by_id
    is_system: (NSNumber*) is_system
{
  __id = _id;
  _name = name;
  _api_name = api_name;
  _swg_description = swg_description;
  _is_active = is_active;
  _type = type;
  _type_id = type_id;
  _storage_type = storage_type;
  _storage_type_id = storage_type_id;
  _credentials = credentials;
  _native_format = native_format;
  _base_url = base_url;
  _parameters = parameters;
  _headers = headers;
  _apps = apps;
  _roles = roles;
  _created_date = created_date;
  _created_by_id = created_by_id;
  _last_modified_date = last_modified_date;
  _last_modified_by_id = last_modified_by_id;
  _is_system = is_system;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __id = dict[@"id"]; 
        _name = dict[@"name"]; 
        _api_name = dict[@"api_name"]; 
        _swg_description = dict[@"description"];
        _is_active = dict[@"is_active"]; 
        _type = dict[@"type"]; 
        _type_id = dict[@"type_id"]; 
        _storage_type = dict[@"storage_type"]; 
        _storage_type_id = dict[@"storage_type_id"]; 
        _credentials = dict[@"credentials"]; 
        _native_format = dict[@"native_format"]; 
        _base_url = dict[@"base_url"]; 
        _parameters = dict[@"parameters"]; 
        _headers = dict[@"headers"]; 
        id apps_dict = dict[@"apps"];
        _apps = [[SWGRelatedApps alloc]initWithValues:apps_dict];
        id roles_dict = dict[@"roles"];
        _roles = [[SWGRelatedRoles alloc]initWithValues:roles_dict];
        _created_date = dict[@"created_date"]; 
        _created_by_id = dict[@"created_by_id"]; 
        _last_modified_date = dict[@"last_modified_date"]; 
        _last_modified_by_id = dict[@"last_modified_by_id"]; 
        _is_system = dict[@"is_system"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__id != nil) dict[@"id"] = __id ;
    if(_name != nil) dict[@"name"] = _name ;
    if(_api_name != nil) dict[@"api_name"] = _api_name ;
    if(_swg_description != nil) dict[@"description"] = _swg_description ;
    if(_is_active != nil) dict[@"is_active"] = _is_active ;
    if(_type != nil) dict[@"type"] = _type ;
    if(_type_id != nil) dict[@"type_id"] = _type_id ;
    if(_storage_type != nil) dict[@"storage_type"] = _storage_type ;
    if(_storage_type_id != nil) dict[@"storage_type_id"] = _storage_type_id ;
    if(_credentials != nil) dict[@"credentials"] = _credentials ;
    if(_native_format != nil) dict[@"native_format"] = _native_format ;
    if(_base_url != nil) dict[@"base_url"] = _base_url ;
    if(_parameters != nil) dict[@"parameters"] = _parameters ;
    if(_headers != nil) dict[@"headers"] = _headers ;
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
    if(_roles != nil){
        if([_roles isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRelatedRoles *roles in (NSArray*)_roles) {
                [array addObject:[(NIKSwaggerObject*)roles asDictionary]];
            }
            dict[@"roles"] = array;
        }
        else if(_roles && [_roles isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_roles toString];
            if(dateString){
                dict[@"roles"] = dateString;
            }
        }
    }
    else {
    if(_roles != nil) dict[@"roles"] = [(NIKSwaggerObject*)_roles asDictionary];
    }
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    if(_is_system != nil) dict[@"is_system"] = _is_system ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


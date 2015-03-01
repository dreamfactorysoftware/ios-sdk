#import "NIKDate.h"
#import "SWGProviderResponse.h"

@implementation SWGProviderResponse

-(id)_id: (NSNumber*) _id
    provider_name: (NSString*) provider_name
    api_name: (NSString*) api_name
    is_active: (NSNumber*) is_active
    is_login_provider: (NSNumber*) is_login_provider
    is_system: (NSNumber*) is_system
    base_provider_id: (NSNumber*) base_provider_id
    config_text: (SWGProviderConfigSettings*) config_text
    created_date: (SWGDate*) created_date
    created_by_id: (NSNumber*) created_by_id
    last_modified_date: (SWGDate*) last_modified_date
    last_modified_by_id: (NSNumber*) last_modified_by_id
{
  __id = _id;
  _provider_name = provider_name;
  _api_name = api_name;
  _is_active = is_active;
  _is_login_provider = is_login_provider;
  _is_system = is_system;
  _base_provider_id = base_provider_id;
  _config_text = config_text;
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
        _provider_name = dict[@"provider_name"]; 
        _api_name = dict[@"api_name"]; 
        _is_active = dict[@"is_active"]; 
        _is_login_provider = dict[@"is_login_provider"]; 
        _is_system = dict[@"is_system"]; 
        _base_provider_id = dict[@"base_provider_id"]; 
        id config_text_dict = dict[@"config_text"];
        _config_text = [[SWGProviderConfigSettings alloc]initWithValues:config_text_dict];
        id created_date_dict = dict[@"created_date"];
        _created_date = [[SWGDate alloc]initWithValues:created_date_dict];
        _created_by_id = dict[@"created_by_id"]; 
        id last_modified_date_dict = dict[@"last_modified_date"];
        _last_modified_date = [[SWGDate alloc]initWithValues:last_modified_date_dict];
        _last_modified_by_id = dict[@"last_modified_by_id"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__id != nil) dict[@"id"] = __id ;
    if(_provider_name != nil) dict[@"provider_name"] = _provider_name ;
    if(_api_name != nil) dict[@"api_name"] = _api_name ;
    if(_is_active != nil) dict[@"is_active"] = _is_active ;
    if(_is_login_provider != nil) dict[@"is_login_provider"] = _is_login_provider ;
    if(_is_system != nil) dict[@"is_system"] = _is_system ;
    if(_base_provider_id != nil) dict[@"base_provider_id"] = _base_provider_id ;
    if(_config_text != nil){
        if([_config_text isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGProviderConfigSettings *config_text in (NSArray*)_config_text) {
                [array addObject:[(NIKSwaggerObject*)config_text asDictionary]];
            }
            dict[@"config_text"] = array;
        }
        else if(_config_text && [_config_text isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_config_text toString];
            if(dateString){
                dict[@"config_text"] = dateString;
            }
        }
    }
    else {
    if(_config_text != nil) dict[@"config_text"] = [(NIKSwaggerObject*)_config_text asDictionary];
    }
    if(_created_date != nil){
        if([_created_date isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGDate *created_date in (NSArray*)_created_date) {
                [array addObject:[(NIKSwaggerObject*)created_date asDictionary]];
            }
            dict[@"created_date"] = array;
        }
        else if(_created_date && [_created_date isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_created_date toString];
            if(dateString){
                dict[@"created_date"] = dateString;
            }
        }
    }
    else {
    if(_created_date != nil) dict[@"created_date"] = [(NIKSwaggerObject*)_created_date asDictionary];
    }
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil){
        if([_last_modified_date isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGDate *last_modified_date in (NSArray*)_last_modified_date) {
                [array addObject:[(NIKSwaggerObject*)last_modified_date asDictionary]];
            }
            dict[@"last_modified_date"] = array;
        }
        else if(_last_modified_date && [_last_modified_date isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_last_modified_date toString];
            if(dateString){
                dict[@"last_modified_date"] = dateString;
            }
        }
    }
    else {
    if(_last_modified_date != nil) dict[@"last_modified_date"] = [(NIKSwaggerObject*)_last_modified_date asDictionary];
    }
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


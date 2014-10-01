#import "NIKDate.h"
#import "SWGScriptResponse.h"

@implementation SWGScriptResponse

-(id)script_id: (NSString*) script_id
    script_body: (NSString*) script_body
    script: (NSString*) script
    is_user_script: (NSNumber*) is_user_script
    language: (NSString*) language
    file_name: (NSString*) file_name
    file_path: (NSString*) file_path
    file_mtime: (NSNumber*) file_mtime
    event_name: (NSString*) event_name
    metadata: (NSArray*) metadata
    created_date: (NSString*) created_date
    created_by_id: (NSNumber*) created_by_id
    last_modified_date: (NSString*) last_modified_date
    last_modified_by_id: (NSNumber*) last_modified_by_id
{
  _script_id = script_id;
  _script_body = script_body;
  _script = script;
  _is_user_script = is_user_script;
  _language = language;
  _file_name = file_name;
  _file_path = file_path;
  _file_mtime = file_mtime;
  _event_name = event_name;
  _metadata = metadata;
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
        _script_id = dict[@"script_id"]; 
        _script_body = dict[@"script_body"]; 
        _script = dict[@"script"]; 
        _is_user_script = dict[@"is_user_script"]; 
        _language = dict[@"language"]; 
        _file_name = dict[@"file_name"]; 
        _file_path = dict[@"file_path"]; 
        _file_mtime = dict[@"file_mtime"]; 
        _event_name = dict[@"event_name"]; 
        _metadata = dict[@"metadata"]; 
        _created_date = dict[@"created_date"]; 
        _created_by_id = dict[@"created_by_id"]; 
        _last_modified_date = dict[@"last_modified_date"]; 
        _last_modified_by_id = dict[@"last_modified_by_id"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_script_id != nil) dict[@"script_id"] = _script_id ;
    if(_script_body != nil) dict[@"script_body"] = _script_body ;
    if(_script != nil) dict[@"script"] = _script ;
    if(_is_user_script != nil) dict[@"is_user_script"] = _is_user_script ;
    if(_language != nil) dict[@"language"] = _language ;
    if(_file_name != nil) dict[@"file_name"] = _file_name ;
    if(_file_path != nil) dict[@"file_path"] = _file_path ;
    if(_file_mtime != nil) dict[@"file_mtime"] = _file_mtime ;
    if(_event_name != nil) dict[@"event_name"] = _event_name ;
    if(_metadata != nil) dict[@"metadata"] = _metadata ;
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


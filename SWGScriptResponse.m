#import "NIKDate.h"
#import "SWGScriptResponse.h"

@implementation SWGScriptResponse

-(id)script_id: (NSString*) script_id
    script_body: (NSString*) script_body
    metadata: (NSArray*) metadata
    created_date: (NSString*) created_date
    created_by_id: (NSNumber*) created_by_id
    last_modified_date: (NSString*) last_modified_date
    last_modified_by_id: (NSNumber*) last_modified_by_id
{
  _script_id = script_id;
  _script_body = script_body;
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
    if(_metadata != nil) dict[@"metadata"] = _metadata ;
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


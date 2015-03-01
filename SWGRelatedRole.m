#import "NIKDate.h"
#import "SWGRelatedRole.h"

@implementation SWGRelatedRole

-(id)_id: (NSNumber*) _id
    name: (NSString*) name
    swg_description: (NSString*) swg_description
    is_active: (NSNumber*) is_active
    default_app_id: (NSNumber*) default_app_id
    created_date: (NSString*) created_date
    created_by_id: (NSNumber*) created_by_id
    last_modified_date: (NSString*) last_modified_date
    last_modified_by_id: (NSNumber*) last_modified_by_id
{
  __id = _id;
  _name = name;
  _swg_description = swg_description;
  _is_active = is_active;
  _default_app_id = default_app_id;
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
        _name = dict[@"name"]; 
        _swg_description = dict[@"description"];
        _is_active = dict[@"is_active"]; 
        _default_app_id = dict[@"default_app_id"]; 
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
    if(_name != nil) dict[@"name"] = _name ;
    if(_swg_description != nil) dict[@"description"] = _swg_description ;
    if(_is_active != nil) dict[@"is_active"] = _is_active ;
    if(_default_app_id != nil) dict[@"default_app_id"] = _default_app_id ;
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_created_by_id != nil) dict[@"created_by_id"] = _created_by_id ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    if(_last_modified_by_id != nil) dict[@"last_modified_by_id"] = _last_modified_by_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


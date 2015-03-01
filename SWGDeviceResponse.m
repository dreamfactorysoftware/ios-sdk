#import "NIKDate.h"
#import "SWGDeviceResponse.h"

@implementation SWGDeviceResponse

-(id)_id: (NSNumber*) _id
    uuid: (NSString*) uuid
    platform: (NSString*) platform
    version: (NSString*) version
    model: (NSString*) model
    extra: (NSString*) extra
    created_date: (NSString*) created_date
    last_modified_date: (NSString*) last_modified_date
{
  __id = _id;
  _uuid = uuid;
  _platform = platform;
  _version = version;
  _model = model;
  _extra = extra;
  _created_date = created_date;
  _last_modified_date = last_modified_date;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __id = dict[@"id"]; 
        _uuid = dict[@"uuid"]; 
        _platform = dict[@"platform"]; 
        _version = dict[@"version"]; 
        _model = dict[@"model"]; 
        _extra = dict[@"extra"]; 
        _created_date = dict[@"created_date"]; 
        _last_modified_date = dict[@"last_modified_date"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__id != nil) dict[@"id"] = __id ;
    if(_uuid != nil) dict[@"uuid"] = _uuid ;
    if(_platform != nil) dict[@"platform"] = _platform ;
    if(_version != nil) dict[@"version"] = _version ;
    if(_model != nil) dict[@"model"] = _model ;
    if(_extra != nil) dict[@"extra"] = _extra ;
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


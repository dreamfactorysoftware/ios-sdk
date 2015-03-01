#import "NIKDate.h"
#import "SWGDeviceRequest.h"

@implementation SWGDeviceRequest

-(id)_id: (NSNumber*) _id
    uuid: (NSString*) uuid
    platform: (NSString*) platform
    version: (NSString*) version
    model: (NSString*) model
    extra: (NSString*) extra
{
  __id = _id;
  _uuid = uuid;
  _platform = platform;
  _version = version;
  _model = model;
  _extra = extra;
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
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "SWGDeviceResponse.h"

@implementation SWGDeviceResponse

-(id)_id: (NSNumber*) _id
    uuid: (NSString*) uuid
    platform: (NSString*) platform
    version: (NSString*) version
    model: (NSString*) model
    extra: (NSString*) extra
    user_id: (NSNumber*) user_id
    user: (SWGRelatedUser*) user
    created_date: (NSString*) created_date
    last_modified_date: (NSString*) last_modified_date
{
  __id = _id;
  _uuid = uuid;
  _platform = platform;
  _version = version;
  _model = model;
  _extra = extra;
  _user_id = user_id;
  _user = user;
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
        _user_id = dict[@"user_id"]; 
        id user_dict = dict[@"user"];
        _user = [[SWGRelatedUser alloc]initWithValues:user_dict];
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
    if(_user_id != nil) dict[@"user_id"] = _user_id ;
    if(_user != nil){
        if([_user isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRelatedUser *user in (NSArray*)_user) {
                [array addObject:[(NIKSwaggerObject*)user asDictionary]];
            }
            dict[@"user"] = array;
        }
        else if(_user && [_user isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_user toString];
            if(dateString){
                dict[@"user"] = dateString;
            }
        }
    }
    else {
    if(_user != nil) dict[@"user"] = [(NIKSwaggerObject*)_user asDictionary];
    }
    if(_created_date != nil) dict[@"created_date"] = _created_date ;
    if(_last_modified_date != nil) dict[@"last_modified_date"] = _last_modified_date ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "RVBFileResponse.h"

@implementation RVBFileResponse

-(id)name: (NSString*) name
    path: (NSString*) path
    content_type: (NSString*) content_type
    _property_: (NSString*) _property_
    metadata: (NSArray*) metadata
    content_length: (NSString*) content_length
    last_modified: (NSString*) last_modified
{
  _name = name;
  _path = path;
  _content_type = content_type;
  __property_ = _property_;
  _metadata = metadata;
  _content_length = content_length;
  _last_modified = last_modified;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        _path = dict[@"path"]; 
        _content_type = dict[@"content_type"]; 
        __property_ = dict[@"_property_"]; 
        _metadata = dict[@"metadata"]; 
        _content_length = dict[@"content_length"]; 
        _last_modified = dict[@"last_modified"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(_path != nil) dict[@"path"] = _path ;
    if(_content_type != nil) dict[@"content_type"] = _content_type ;
    if(__property_ != nil) dict[@"_property_"] = __property_ ;
    if(_metadata != nil) dict[@"metadata"] = _metadata ;
    if(_content_length != nil) dict[@"content_length"] = _content_length ;
    if(_last_modified != nil) dict[@"last_modified"] = _last_modified ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


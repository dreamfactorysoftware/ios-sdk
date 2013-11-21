#import "NIKDate.h"
#import "RVBFile.h"

@implementation RVBFile

-(id)name: (NSString*) name
    path: (NSString*) path
    content_type: (NSString*) content_type
    _property_: (NSString*) _property_
    metadata: (NSArray*) metadata
{
  _name = name;
  _path = path;
  _content_type = content_type;
  __property_ = _property_;
  _metadata = metadata;
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
    NSDictionary* output = [dict copy];
    return output;
}

@end


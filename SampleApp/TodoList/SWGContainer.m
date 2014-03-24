#import "NIKDate.h"
#import "SWGContainer.h"

@implementation SWGContainer

-(id)name: (NSString*) name
    path: (NSString*) path
    _property_: (NSString*) _property_
    metadata: (NSArray*) metadata
{
  _name = name;
  _path = path;
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
        __property_ = dict[@"_property_"]; 
        _metadata = dict[@"metadata"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(_path != nil) dict[@"path"] = _path ;
    if(__property_ != nil) dict[@"_property_"] = __property_ ;
    if(_metadata != nil) dict[@"metadata"] = _metadata ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


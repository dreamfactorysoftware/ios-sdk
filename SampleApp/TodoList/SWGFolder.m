#import "NIKDate.h"
#import "SWGFolder.h"

@implementation SWGFolder

-(id)name: (NSString*) name
    path: (NSString*) path
    metadata: (NSArray*) metadata
{
  _name = name;
  _path = path;
  _metadata = metadata;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        _path = dict[@"path"]; 
        _metadata = dict[@"metadata"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(_path != nil) dict[@"path"] = _path ;
    if(_metadata != nil) dict[@"metadata"] = _metadata ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


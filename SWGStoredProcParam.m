#import "NIKDate.h"
#import "SWGStoredProcParam.h"

@implementation SWGStoredProcParam

-(id)name: (NSString*) name
    param_type: (NSString*) param_type
    value: (NSString*) value
    type: (NSString*) type
    length: (NSNumber*) length
{
  _name = name;
  _param_type = param_type;
  _value = value;
  _type = type;
  _length = length;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        _param_type = dict[@"param_type"]; 
        _value = dict[@"value"]; 
        _type = dict[@"type"]; 
        _length = dict[@"length"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(_param_type != nil) dict[@"param_type"] = _param_type ;
    if(_value != nil) dict[@"value"] = _value ;
    if(_type != nil) dict[@"type"] = _type ;
    if(_length != nil) dict[@"length"] = _length ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "RVBTable.h"

@implementation RVBTable

-(id)name: (NSString*) name
    _property_: (NSString*) _property_
{
  _name = name;
  __property_ = _property_;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        __property_ = dict[@"_property_"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(__property_ != nil) dict[@"_property_"] = __property_ ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


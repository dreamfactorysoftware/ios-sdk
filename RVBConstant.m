#import "NIKDate.h"
#import "RVBConstant.h"

@implementation RVBConstant

-(id)name: (NSArray*) name
{
  _name = name;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


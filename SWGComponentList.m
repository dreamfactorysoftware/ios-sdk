#import "NIKDate.h"
#import "SWGComponentList.h"

@implementation SWGComponentList

-(id)resource: (NSArray*) resource
{
  _resource = resource;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _resource = dict[@"resource"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_resource != nil) dict[@"resource"] = _resource ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


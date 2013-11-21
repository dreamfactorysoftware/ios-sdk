#import "NIKDate.h"
#import "RVBEmailResponse.h"

@implementation RVBEmailResponse

-(id)count: (NSNumber*) count
{
  _count = count;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _count = dict[@"count"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_count != nil) dict[@"count"] = _count ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


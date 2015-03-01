#import "NIKDate.h"
#import "SWGSuccess.h"

@implementation SWGSuccess

-(id)success: (NSNumber*) success
{
  _success = success;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _success = dict[@"success"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_success != nil) dict[@"success"] = _success ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


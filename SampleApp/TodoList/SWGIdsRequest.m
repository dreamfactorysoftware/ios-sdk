#import "NIKDate.h"
#import "SWGIdsRequest.h"

@implementation SWGIdsRequest

-(id)ids: (NSArray*) ids
{
  _ids = ids;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _ids = dict[@"ids"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_ids != nil) dict[@"ids"] = _ids ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


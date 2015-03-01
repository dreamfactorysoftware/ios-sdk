#import "NIKDate.h"
#import "SWGFilterRequest.h"

@implementation SWGFilterRequest

-(id)filter: (NSString*) filter
    params: (NSArray*) params
{
  _filter = filter;
  _params = params;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _filter = dict[@"filter"]; 
        _params = dict[@"params"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_filter != nil) dict[@"filter"] = _filter ;
    if(_params != nil) dict[@"params"] = _params ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


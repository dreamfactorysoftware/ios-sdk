#import "NIKDate.h"
#import "SWGProvidersRequest.h"

@implementation SWGProvidersRequest

-(id)record: (NSArray*) record
    ids: (NSArray*) ids
{
  _record = record;
  _ids = ids;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _record = dict[@"record"]; 
        _ids = dict[@"ids"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_record != nil) dict[@"record"] = _record ;
    if(_ids != nil) dict[@"ids"] = _ids ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


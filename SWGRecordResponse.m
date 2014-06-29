#import "NIKDate.h"
#import "SWGRecordResponse.h"

@implementation SWGRecordResponse

-(id)_id: (NSNumber*) _id
{
  __id = _id;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __id = dict[@"id"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__id != nil) dict[@"id"] = __id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


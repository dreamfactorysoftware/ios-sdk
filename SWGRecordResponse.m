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
        __field_ = dict[@"_field_"];
        __complete=dict[@"complete"];
        _name=dict[@"name"];


    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__field_ != nil) dict[@"_field_"] = __field_ ;
    if(__complete != nil) dict[@"complete"] = __complete ;
    if(_name != nil) dict[@"name"] = _name ;
    if(__id != nil) dict[@"id"] = __id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


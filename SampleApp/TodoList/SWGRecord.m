#import "NIKDate.h"
#import "SWGRecord.h"

@implementation SWGRecord

-(id)_field_: (NSString*) _field_
{
  __field_ = _field_;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __field_ = dict[@"_field_"]; 
        __complete=dict[@"complete"];
        _name=dict[@"name"];
        __id=dict[@"id"];

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


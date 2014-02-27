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
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__field_ != nil) dict[@"_field_"] = __field_ ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "SWGStoredProcResultSchema.h"

@implementation SWGStoredProcResultSchema

-(id)_field_name_: (NSString*) _field_name_
{
  __field_name_ = _field_name_;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __field_name_ = dict[@"_field_name_"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__field_name_ != nil) dict[@"_field_name_"] = __field_name_ ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


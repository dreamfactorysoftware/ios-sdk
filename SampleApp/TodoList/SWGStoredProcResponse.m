#import "NIKDate.h"
#import "SWGStoredProcResponse.h"

@implementation SWGStoredProcResponse

-(id)_wrapper_if_supplied_: (NSArray*) _wrapper_if_supplied_
    _out_param_name_: (NSString*) _out_param_name_
{
  __wrapper_if_supplied_ = _wrapper_if_supplied_;
  __out_param_name_ = _out_param_name_;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __wrapper_if_supplied_ = dict[@"_wrapper_if_supplied_"]; 
        __out_param_name_ = dict[@"_out_param_name_"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__wrapper_if_supplied_ != nil) dict[@"_wrapper_if_supplied_"] = __wrapper_if_supplied_ ;
    if(__out_param_name_ != nil) dict[@"_out_param_name_"] = __out_param_name_ ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


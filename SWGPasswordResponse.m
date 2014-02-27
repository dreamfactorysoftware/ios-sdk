#import "NIKDate.h"
#import "SWGPasswordResponse.h"

@implementation SWGPasswordResponse

-(id)security_question: (NSString*) security_question
    success: (NSNumber*) success
{
  _security_question = security_question;
  _success = success;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _security_question = dict[@"security_question"]; 
        _success = dict[@"success"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_security_question != nil) dict[@"security_question"] = _security_question ;
    if(_success != nil) dict[@"success"] = _success ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


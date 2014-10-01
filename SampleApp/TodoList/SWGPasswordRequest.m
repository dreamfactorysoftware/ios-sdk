#import "NIKDate.h"
#import "SWGPasswordRequest.h"

@implementation SWGPasswordRequest

-(id)old_password: (NSString*) old_password
    _new_password: (NSString*) _new_password
    email: (NSString*) email
    code: (NSString*) code
{
  _old_password = old_password;
  _swgnew_password = _new_password;
  _email = email;
  _code = code;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _old_password = dict[@"old_password"]; 
        _swgnew_password = dict[@"new_password"];
        _email = dict[@"email"]; 
        _code = dict[@"code"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_old_password != nil) dict[@"old_password"] = _old_password ;
    if(_swgnew_password != nil) dict[@"new_password"] = _swgnew_password ;
    if(_email != nil) dict[@"email"] = _email ;
    if(_code != nil) dict[@"code"] = _code ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


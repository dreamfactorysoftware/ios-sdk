#import "NIKDate.h"
#import "RVBPasswordRequest.h"

@implementation RVBPasswordRequest

-(id)old_password: (NSString*) old_password
    new_password: (NSString*) new_password
    email: (NSString*) email
    code: (NSString*) code
{
  _old_password = old_password;
  _new_password = new_password;
  _email = email;
  _code = code;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _old_password = dict[@"old_password"]; 
        _new_password = dict[@"new_password"]; 
        _email = dict[@"email"]; 
        _code = dict[@"code"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_old_password != nil) dict[@"old_password"] = _old_password ;
    if(_new_password != nil) dict[@"new_password"] = _new_password ;
    if(_email != nil) dict[@"email"] = _email ;
    if(_code != nil) dict[@"code"] = _code ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


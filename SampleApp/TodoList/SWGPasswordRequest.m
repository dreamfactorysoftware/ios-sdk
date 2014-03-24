#import "NIKDate.h"
#import "SWGPasswordRequest.h"

@implementation SWGPasswordRequest

-(id)old_password: (NSString*) old_password
    new_password: (NSString*) new_password
    email: (NSString*) email
    code: (NSString*) code
{
  self.old_password = old_password;
  self.newpassword = new_password;
  _email = email;
  _code = code;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        self.old_password = dict[@"old_password"];
        self.newpassword = dict[@"new_password"];
        _email = dict[@"email"]; 
        _code = dict[@"code"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_old_password != nil) dict[@"old_password"] = self.old_password ;
    if(self.newpassword != nil) dict[@"new_password"] = self.newpassword ;
    if(_email != nil) dict[@"email"] = _email ;
    if(_code != nil) dict[@"code"] = _code ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


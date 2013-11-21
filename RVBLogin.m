#import "NIKDate.h"
#import "RVBLogin.h"

@implementation RVBLogin

-(id)email: (NSString*) email
    password: (NSString*) password
{
  _email = email;
  _password = password;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _email = dict[@"email"]; 
        _password = dict[@"password"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_email != nil) dict[@"email"] = _email ;
    if(_password != nil) dict[@"password"] = _password ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "SWGLogin.h"

@implementation SWGLogin

-(id)email: (NSString*) email
    password: (NSString*) password
    duration: (NSNumber*) duration
{
  _email = email;
  _password = password;
  _duration = duration;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _email = dict[@"email"]; 
        _password = dict[@"password"]; 
        _duration = dict[@"duration"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_email != nil) dict[@"email"] = _email ;
    if(_password != nil) dict[@"password"] = _password ;
    if(_duration != nil) dict[@"duration"] = _duration ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


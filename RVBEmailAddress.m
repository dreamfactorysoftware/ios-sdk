#import "NIKDate.h"
#import "RVBEmailAddress.h"

@implementation RVBEmailAddress

-(id)name: (NSString*) name
    email: (NSString*) email
{
  _name = name;
  _email = email;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        _email = dict[@"email"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(_email != nil) dict[@"email"] = _email ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


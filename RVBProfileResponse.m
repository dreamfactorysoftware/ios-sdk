#import "NIKDate.h"
#import "RVBProfileResponse.h"

@implementation RVBProfileResponse

-(id)email: (NSString*) email
    first_name: (NSString*) first_name
    last_name: (NSString*) last_name
    display_name: (NSString*) display_name
    phone: (NSString*) phone
    security_question: (NSString*) security_question
    default_app_id: (NSNumber*) default_app_id
{
  _email = email;
  _first_name = first_name;
  _last_name = last_name;
  _display_name = display_name;
  _phone = phone;
  _security_question = security_question;
  _default_app_id = default_app_id;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _email = dict[@"email"]; 
        _first_name = dict[@"first_name"]; 
        _last_name = dict[@"last_name"]; 
        _display_name = dict[@"display_name"]; 
        _phone = dict[@"phone"]; 
        _security_question = dict[@"security_question"]; 
        _default_app_id = dict[@"default_app_id"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_email != nil) dict[@"email"] = _email ;
    if(_first_name != nil) dict[@"first_name"] = _first_name ;
    if(_last_name != nil) dict[@"last_name"] = _last_name ;
    if(_display_name != nil) dict[@"display_name"] = _display_name ;
    if(_phone != nil) dict[@"phone"] = _phone ;
    if(_security_question != nil) dict[@"security_question"] = _security_question ;
    if(_default_app_id != nil) dict[@"default_app_id"] = _default_app_id ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


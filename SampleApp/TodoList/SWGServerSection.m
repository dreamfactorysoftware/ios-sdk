#import "NIKDate.h"
#import "SWGServerSection.h"

@implementation SWGServerSection

-(id)server_os: (NSString*) server_os
    uname: (NSString*) uname
{
  _server_os = server_os;
  _uname = uname;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _server_os = dict[@"server_os"]; 
        _uname = dict[@"uname"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_server_os != nil) dict[@"server_os"] = _server_os ;
    if(_uname != nil) dict[@"uname"] = _uname ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


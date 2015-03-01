#import "NIKDate.h"
#import "SWGReleaseSection.h"

@implementation SWGReleaseSection

-(id)_id: (NSString*) _id
    swgrelease: (NSString*) swgrelease
    codename: (NSString*) codename
    swg_description: (NSString*) swg_description
{
  _swg_id = _id;
  _swgrelease = swgrelease;
  _codename = codename;
  _swg_description = swg_description;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _swg_id = dict[@"id"];
        _swgrelease = dict[@"release"];
        _codename = dict[@"codename"]; 
        _swg_description = dict[@"description"];
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_swg_id != nil) dict[@"id"] = _swg_id ;
    if(_swgrelease != nil) dict[@"release"] = _swgrelease ;
    if(_codename != nil) dict[@"codename"] = _codename ;
    if(_swg_description != nil) dict[@"description"] = _swg_description ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


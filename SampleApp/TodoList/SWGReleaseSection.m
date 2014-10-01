#import "NIKDate.h"
#import "SWGReleaseSection.h"

@implementation SWGReleaseSection

-(id)_id: (NSString*) _id
    swgrelease: (NSString*) swgrelease
    codename: (NSString*) codename
    description: (NSString*) description
{
  _swg_id = _id;
  _swgrelease = swgrelease;
  _codename = codename;
  _description = description;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _swg_id = dict[@"id"];
        _swgrelease = dict[@"release"];
        _codename = dict[@"codename"]; 
        _description = dict[@"description"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_swg_id != nil) dict[@"id"] = _swg_id ;
    if(_swgrelease != nil) dict[@"release"] = _swgrelease ;
    if(_codename != nil) dict[@"codename"] = _codename ;
    if(_description != nil) dict[@"description"] = _description ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


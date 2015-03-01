#import "NIKDate.h"
#import "SWGPlatformSection.h"

@implementation SWGPlatformSection

-(id)is_hosted: (NSNumber*) is_hosted
    is_private: (NSNumber*) is_private
    dsp_version_current: (NSString*) dsp_version_current
    dsp_version_latest: (NSString*) dsp_version_latest
    upgrade_available: (NSNumber*) upgrade_available
{
  _is_hosted = is_hosted;
  _is_private = is_private;
  _dsp_version_current = dsp_version_current;
  _dsp_version_latest = dsp_version_latest;
  _upgrade_available = upgrade_available;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _is_hosted = dict[@"is_hosted"]; 
        _is_private = dict[@"is_private"]; 
        _dsp_version_current = dict[@"dsp_version_current"]; 
        _dsp_version_latest = dict[@"dsp_version_latest"]; 
        _upgrade_available = dict[@"upgrade_available"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_is_hosted != nil) dict[@"is_hosted"] = _is_hosted ;
    if(_is_private != nil) dict[@"is_private"] = _is_private ;
    if(_dsp_version_current != nil) dict[@"dsp_version_current"] = _dsp_version_current ;
    if(_dsp_version_latest != nil) dict[@"dsp_version_latest"] = _dsp_version_latest ;
    if(_upgrade_available != nil) dict[@"upgrade_available"] = _upgrade_available ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


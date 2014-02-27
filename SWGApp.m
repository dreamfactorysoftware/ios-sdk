#import "NIKDate.h"
#import "SWGApp.h"

@implementation SWGApp

-(id)_id: (NSNumber*) _id
    name: (NSString*) name
    description: (NSString*) description
    is_url_external: (NSNumber*) is_url_external
    launch_url: (NSString*) launch_url
    requires_fullscreen: (NSNumber*) requires_fullscreen
    allow_fullscreen_toggle: (NSNumber*) allow_fullscreen_toggle
    toggle_location: (NSString*) toggle_location
    is_default: (NSNumber*) is_default
{
  __id = _id;
  _name = name;
  _description = description;
  _is_url_external = is_url_external;
  _launch_url = launch_url;
  _requires_fullscreen = requires_fullscreen;
  _allow_fullscreen_toggle = allow_fullscreen_toggle;
  _toggle_location = toggle_location;
  _is_default = is_default;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __id = dict[@"id"]; 
        _name = dict[@"name"]; 
        _description = dict[@"description"]; 
        _is_url_external = dict[@"is_url_external"]; 
        _launch_url = dict[@"launch_url"]; 
        _requires_fullscreen = dict[@"requires_fullscreen"]; 
        _allow_fullscreen_toggle = dict[@"allow_fullscreen_toggle"]; 
        _toggle_location = dict[@"toggle_location"]; 
        _is_default = dict[@"is_default"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__id != nil) dict[@"id"] = __id ;
    if(_name != nil) dict[@"name"] = _name ;
    if(_description != nil) dict[@"description"] = _description ;
    if(_is_url_external != nil) dict[@"is_url_external"] = _is_url_external ;
    if(_launch_url != nil) dict[@"launch_url"] = _launch_url ;
    if(_requires_fullscreen != nil) dict[@"requires_fullscreen"] = _requires_fullscreen ;
    if(_allow_fullscreen_toggle != nil) dict[@"allow_fullscreen_toggle"] = _allow_fullscreen_toggle ;
    if(_toggle_location != nil) dict[@"toggle_location"] = _toggle_location ;
    if(_is_default != nil) dict[@"is_default"] = _is_default ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "SWGAppGroupRequest.h"

@implementation SWGAppGroupRequest

-(id)_id: (NSNumber*) _id
    name: (NSString*) name
    description: (NSString*) description
    apps: (SWGRelatedApps*) apps
{
  __id = _id;
  _name = name;
  _swgdescription = description;
  _apps = apps;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        __id = dict[@"id"]; 
        _name = dict[@"name"]; 
        _swgdescription = dict[@"description"];
        id apps_dict = dict[@"apps"];
        _apps = [[SWGRelatedApps alloc]initWithValues:apps_dict];
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(__id != nil) dict[@"id"] = __id ;
    if(_name != nil) dict[@"name"] = _name ;
    if(_swgdescription != nil) dict[@"description"] = _swgdescription ;
    if(_apps != nil){
        if([_apps isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRelatedApps *apps in (NSArray*)_apps) {
                [array addObject:[(NIKSwaggerObject*)apps asDictionary]];
            }
            dict[@"apps"] = array;
        }
        else if(_apps && [_apps isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_apps toString];
            if(dateString){
                dict[@"apps"] = dateString;
            }
        }
    }
    else {
    if(_apps != nil) dict[@"apps"] = [(NIKSwaggerObject*)_apps asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


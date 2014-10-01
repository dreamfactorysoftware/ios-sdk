#import "NIKDate.h"
#import "SWGCustomSettings.h"

@implementation SWGCustomSettings

-(id)name: (NSArray*) name
{
  _name = name;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id name_dict = dict[@"name"];
        if([name_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)name_dict count]];

            if([(NSArray*)name_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)name_dict) {
                    SWGCustomSetting* d = [[SWGCustomSetting alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _name = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _name = [[NSArray alloc] init];
            }
        }
        else {
            _name = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil){
        if([_name isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGCustomSetting *name in (NSArray*)_name) {
                [array addObject:[(NIKSwaggerObject*)name asDictionary]];
            }
            dict[@"name"] = array;
        }
        else if(_name && [_name isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_name toString];
            if(dateString){
                dict[@"name"] = dateString;
            }
        }
    }
    else {
    if(_name != nil) dict[@"name"] = [(NIKSwaggerObject*)_name asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "RVBCustomSettings.h"

@implementation RVBCustomSettings

-(id)type_name: (NSArray*) type_name
{
  _type_name = type_name;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id type_name_dict = dict[@"type_name"];
        if([type_name_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)type_name_dict count]];

            if([(NSArray*)type_name_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)type_name_dict) {
                    RVBCustomSetting* d = [[RVBCustomSetting alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _type_name = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _type_name = [[NSArray alloc] init];
            }
        }
        else {
            _type_name = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_type_name != nil){
        if([_type_name isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBCustomSetting *type_name in (NSArray*)_type_name) {
                [array addObject:[(NIKSwaggerObject*)type_name asDictionary]];
            }
            dict[@"type_name"] = array;
        }
        else if(_type_name && [_type_name isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_type_name toString];
            if(dateString){
                dict[@"type_name"] = dateString;
            }
        }
    }
    else {
    if(_type_name != nil) dict[@"type_name"] = [(NIKSwaggerObject*)_type_name asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


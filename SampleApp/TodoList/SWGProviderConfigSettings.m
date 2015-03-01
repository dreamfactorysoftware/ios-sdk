#import "NIKDate.h"
#import "SWGProviderConfigSettings.h"

@implementation SWGProviderConfigSettings

-(id)settings: (NSArray*) settings
{
  _settings = settings;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id settings_dict = dict[@"settings"];
        if([settings_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)settings_dict count]];

            if([(NSArray*)settings_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)settings_dict) {
                    SWGProviderConfigSetting* d = [[SWGProviderConfigSetting alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _settings = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _settings = [[NSArray alloc] init];
            }
        }
        else {
            _settings = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_settings != nil){
        if([_settings isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGProviderConfigSetting *settings in (NSArray*)_settings) {
                [array addObject:[(NIKSwaggerObject*)settings asDictionary]];
            }
            dict[@"settings"] = array;
        }
        else if(_settings && [_settings isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_settings toString];
            if(dateString){
                dict[@"settings"] = dateString;
            }
        }
    }
    else {
    if(_settings != nil) dict[@"settings"] = [(NIKSwaggerObject*)_settings asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


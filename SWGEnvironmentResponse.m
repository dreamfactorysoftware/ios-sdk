#import "NIKDate.h"
#import "SWGEnvironmentResponse.h"

@implementation SWGEnvironmentResponse

-(id)server: (SWGServerSection*) server
    release: (SWGReleaseSection*) release
    platform: (SWGPlatformSection*) platform
    php_info: (NSArray*) php_info
{
  _server = server;
  _swgrelease = release;
  _platform = platform;
  _php_info = php_info;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id server_dict = dict[@"server"];
        _server = [[SWGServerSection alloc]initWithValues:server_dict];
        id release_dict = dict[@"release"];
        _swgrelease = [[SWGReleaseSection alloc]initWithValues:release_dict];
        id platform_dict = dict[@"platform"];
        _platform = [[SWGPlatformSection alloc]initWithValues:platform_dict];
        id php_info_dict = dict[@"php_info"];
        if([php_info_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)php_info_dict count]];

            if([(NSArray*)php_info_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)php_info_dict) {
                    SWGPhpInfoSection* d = [[SWGPhpInfoSection alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _php_info = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _php_info = [[NSArray alloc] init];
            }
        }
        else {
            _php_info = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_server != nil){
        if([_server isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGServerSection *server in (NSArray*)_server) {
                [array addObject:[(NIKSwaggerObject*)server asDictionary]];
            }
            dict[@"server"] = array;
        }
        else if(_server && [_server isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_server toString];
            if(dateString){
                dict[@"server"] = dateString;
            }
        }
    }
    else {
    if(_server != nil) dict[@"server"] = [(NIKSwaggerObject*)_server asDictionary];
    }
    if(_swgrelease != nil){
        if([_swgrelease isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGReleaseSection *release in (NSArray*)_swgrelease) {
                [array addObject:[(NIKSwaggerObject*)release asDictionary]];
            }
            dict[@"release"] = array;
        }
        else if(_swgrelease && [_swgrelease isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_swgrelease toString];
            if(dateString){
                dict[@"release"] = dateString;
            }
        }
    }
    else {
    if(_swgrelease != nil) dict[@"release"] = [(NIKSwaggerObject*)_swgrelease asDictionary];
    }
    if(_platform != nil){
        if([_platform isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGPlatformSection *platform in (NSArray*)_platform) {
                [array addObject:[(NIKSwaggerObject*)platform asDictionary]];
            }
            dict[@"platform"] = array;
        }
        else if(_platform && [_platform isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_platform toString];
            if(dateString){
                dict[@"platform"] = dateString;
            }
        }
    }
    else {
    if(_platform != nil) dict[@"platform"] = [(NIKSwaggerObject*)_platform asDictionary];
    }
    if(_php_info != nil){
        if([_php_info isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGPhpInfoSection *php_info in (NSArray*)_php_info) {
                [array addObject:[(NIKSwaggerObject*)php_info asDictionary]];
            }
            dict[@"php_info"] = array;
        }
        else if(_php_info && [_php_info isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_php_info toString];
            if(dateString){
                dict[@"php_info"] = dateString;
            }
        }
    }
    else {
    if(_php_info != nil) dict[@"php_info"] = [(NIKSwaggerObject*)_php_info asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


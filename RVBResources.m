#import "NIKDate.h"
#import "RVBResources.h"

@implementation RVBResources

-(id)resource: (NSArray*) resource
{
  _resource = resource;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id resource_dict = dict[@"resource"];
        if([resource_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)resource_dict count]];

            if([(NSArray*)resource_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)resource_dict) {
                    RVBResource* d = [[RVBResource alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _resource = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _resource = [[NSArray alloc] init];
            }
        }
        else {
            _resource = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_resource != nil){
        if([_resource isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBResource *resource in (NSArray*)_resource) {
                [array addObject:[(NIKSwaggerObject*)resource asDictionary]];
            }
            dict[@"resource"] = array;
        }
        else if(_resource && [_resource isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_resource toString];
            if(dateString){
                dict[@"resource"] = dateString;
            }
        }
    }
    else {
    if(_resource != nil) dict[@"resource"] = [(NIKSwaggerObject*)_resource asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


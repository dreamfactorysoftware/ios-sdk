#import "NIKDate.h"
#import "SWGEventCacheResponse.h"

@implementation SWGEventCacheResponse

-(id)name: (NSString*) name
    paths: (NSArray*) paths
{
  _name = name;
  _paths = paths;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        id paths_dict = dict[@"paths"];
        if([paths_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)paths_dict count]];

            if([(NSArray*)paths_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)paths_dict) {
                    SWGEventPaths* d = [[SWGEventPaths alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _paths = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _paths = [[NSArray alloc] init];
            }
        }
        else {
            _paths = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(_paths != nil){
        if([_paths isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGEventPaths *paths in (NSArray*)_paths) {
                [array addObject:[(NIKSwaggerObject*)paths asDictionary]];
            }
            dict[@"paths"] = array;
        }
        else if(_paths && [_paths isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_paths toString];
            if(dateString){
                dict[@"paths"] = dateString;
            }
        }
    }
    else {
    if(_paths != nil) dict[@"paths"] = [(NIKSwaggerObject*)_paths asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "SWGEventPaths.h"

@implementation SWGEventPaths

-(id)path: (NSString*) path
    verbs: (NSArray*) verbs
{
  _path = path;
  _verbs = verbs;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _path = dict[@"path"]; 
        id verbs_dict = dict[@"verbs"];
        if([verbs_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)verbs_dict count]];

            if([(NSArray*)verbs_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)verbs_dict) {
                    SWGEventVerbs* d = [[SWGEventVerbs alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _verbs = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _verbs = [[NSArray alloc] init];
            }
        }
        else {
            _verbs = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_path != nil) dict[@"path"] = _path ;
    if(_verbs != nil){
        if([_verbs isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGEventVerbs *verbs in (NSArray*)_verbs) {
                [array addObject:[(NIKSwaggerObject*)verbs asDictionary]];
            }
            dict[@"verbs"] = array;
        }
        else if(_verbs && [_verbs isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_verbs toString];
            if(dateString){
                dict[@"verbs"] = dateString;
            }
        }
    }
    else {
    if(_verbs != nil) dict[@"verbs"] = [(NIKSwaggerObject*)_verbs asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


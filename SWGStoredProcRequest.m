#import "NIKDate.h"
#import "SWGStoredProcRequest.h"

@implementation SWGStoredProcRequest

-(id)params: (NSArray*) params
    schema: (SWGStoredProcResultSchema*) schema
    wrapper: (NSString*) wrapper
{
  _params = params;
  _schema = schema;
  _wrapper = wrapper;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id params_dict = dict[@"params"];
        if([params_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)params_dict count]];

            if([(NSArray*)params_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)params_dict) {
                    SWGStoredProcParam* d = [[SWGStoredProcParam alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _params = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _params = [[NSArray alloc] init];
            }
        }
        else {
            _params = [[NSArray alloc] init];
        }
        id schema_dict = dict[@"schema"];
        _schema = [[SWGStoredProcResultSchema alloc]initWithValues:schema_dict];
        _wrapper = dict[@"wrapper"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_params != nil){
        if([_params isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGStoredProcParam *params in (NSArray*)_params) {
                [array addObject:[(NIKSwaggerObject*)params asDictionary]];
            }
            dict[@"params"] = array;
        }
        else if(_params && [_params isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_params toString];
            if(dateString){
                dict[@"params"] = dateString;
            }
        }
    }
    else {
    if(_params != nil) dict[@"params"] = [(NIKSwaggerObject*)_params asDictionary];
    }
    if(_schema != nil){
        if([_schema isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGStoredProcResultSchema *schema in (NSArray*)_schema) {
                [array addObject:[(NIKSwaggerObject*)schema asDictionary]];
            }
            dict[@"schema"] = array;
        }
        else if(_schema && [_schema isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_schema toString];
            if(dateString){
                dict[@"schema"] = dateString;
            }
        }
    }
    else {
    if(_schema != nil) dict[@"schema"] = [(NIKSwaggerObject*)_schema asDictionary];
    }
    if(_wrapper != nil) dict[@"wrapper"] = _wrapper ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


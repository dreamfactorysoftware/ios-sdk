#import "NIKDate.h"
#import "SWGRolesRequest.h"

@implementation SWGRolesRequest

-(id)record: (NSArray*) record
    ids: (NSArray*) ids
{
  _record = record;
  _ids = ids;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id record_dict = dict[@"record"];
        if([record_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)record_dict count]];

            if([(NSArray*)record_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)record_dict) {
                    SWGRoleRequest* d = [[SWGRoleRequest alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _record = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _record = [[NSArray alloc] init];
            }
        }
        else {
            _record = [[NSArray alloc] init];
        }
        _ids = dict[@"ids"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_record != nil){
        if([_record isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRoleRequest *record in (NSArray*)_record) {
                [array addObject:[(NIKSwaggerObject*)record asDictionary]];
            }
            dict[@"record"] = array;
        }
        else if(_record && [_record isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_record toString];
            if(dateString){
                dict[@"record"] = dateString;
            }
        }
    }
    else {
    if(_record != nil) dict[@"record"] = [(NIKSwaggerObject*)_record asDictionary];
    }
    if(_ids != nil) dict[@"ids"] = _ids ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


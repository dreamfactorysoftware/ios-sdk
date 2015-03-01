#import "NIKDate.h"
#import "SWGEventsRequest.h"

@implementation SWGEventsRequest

-(id)record: (NSArray*) record
{
  _record = record;
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
                    SWGEventRequest* d = [[SWGEventRequest alloc] initWithValues:dict];
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
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_record != nil){
        if([_record isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGEventRequest *record in (NSArray*)_record) {
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
    NSDictionary* output = [dict copy];
    return output;
}

@end


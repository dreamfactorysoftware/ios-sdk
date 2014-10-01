#import "NIKDate.h"
#import "SWGFilterRecordRequest.h"

@implementation SWGFilterRecordRequest

-(id)record: (SWGRecordRequest*) record
    filter: (NSString*) filter
    params: (NSArray*) params
{
  _record = record;
  _filter = filter;
  _params = params;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id record_dict = dict[@"record"];
        _record = [[SWGRecordRequest alloc]initWithValues:record_dict];
        _filter = dict[@"filter"]; 
        _params = dict[@"params"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_record != nil){
        if([_record isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRecordRequest *record in (NSArray*)_record) {
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
    if(_filter != nil) dict[@"filter"] = _filter ;
    if(_params != nil) dict[@"params"] = _params ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


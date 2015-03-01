#import "NIKDate.h"
#import "SWGIdsRecordRequest.h"

@implementation SWGIdsRecordRequest

-(id)record: (SWGRecordRequest*) record
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
        _record = [[SWGRecordRequest alloc]initWithValues:record_dict];
        _ids = dict[@"ids"]; 
        

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
    if(_ids != nil) dict[@"ids"] = _ids ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


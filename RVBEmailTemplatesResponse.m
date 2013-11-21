#import "NIKDate.h"
#import "RVBEmailTemplatesResponse.h"

@implementation RVBEmailTemplatesResponse

-(id)record: (NSArray*) record
    meta: (RVBMetadata*) meta
{
  _record = record;
  _meta = meta;
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
                    RVBEmailTemplateResponse* d = [[RVBEmailTemplateResponse alloc] initWithValues:dict];
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
        id meta_dict = dict[@"meta"];
        _meta = [[RVBMetadata alloc]initWithValues:meta_dict];
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_record != nil){
        if([_record isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBEmailTemplateResponse *record in (NSArray*)_record) {
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
    if(_meta != nil){
        if([_meta isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBMetadata *meta in (NSArray*)_meta) {
                [array addObject:[(NIKSwaggerObject*)meta asDictionary]];
            }
            dict[@"meta"] = array;
        }
        else if(_meta && [_meta isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_meta toString];
            if(dateString){
                dict[@"meta"] = dateString;
            }
        }
    }
    else {
    if(_meta != nil) dict[@"meta"] = [(NIKSwaggerObject*)_meta asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


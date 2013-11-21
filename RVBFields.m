#import "NIKDate.h"
#import "RVBFields.h"

@implementation RVBFields

-(id)field: (NSArray*) field
{
  _field = field;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id field_dict = dict[@"field"];
        if([field_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)field_dict count]];

            if([(NSArray*)field_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)field_dict) {
                    RVBFieldSchema* d = [[RVBFieldSchema alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _field = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _field = [[NSArray alloc] init];
            }
        }
        else {
            _field = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_field != nil){
        if([_field isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBFieldSchema *field in (NSArray*)_field) {
                [array addObject:[(NIKSwaggerObject*)field asDictionary]];
            }
            dict[@"field"] = array;
        }
        else if(_field && [_field isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_field toString];
            if(dateString){
                dict[@"field"] = dateString;
            }
        }
    }
    else {
    if(_field != nil) dict[@"field"] = [(NIKSwaggerObject*)_field asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


#import "NIKDate.h"
#import "RVBTables.h"

@implementation RVBTables

-(id)table: (NSArray*) table
{
  _table = table;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id table_dict = dict[@"table"];
        if([table_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)table_dict count]];

            if([(NSArray*)table_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)table_dict) {
                    RVBTable* d = [[RVBTable alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _table = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _table = [[NSArray alloc] init];
            }
        }
        else {
            _table = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_table != nil){
        if([_table isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBTable *table in (NSArray*)_table) {
                [array addObject:[(NIKSwaggerObject*)table asDictionary]];
            }
            dict[@"table"] = array;
        }
        else if(_table && [_table isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_table toString];
            if(dateString){
                dict[@"table"] = dateString;
            }
        }
    }
    else {
    if(_table != nil) dict[@"table"] = [(NIKSwaggerObject*)_table asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


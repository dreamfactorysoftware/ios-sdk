#import "NIKDate.h"
#import "RVBMetadata.h"

@implementation RVBMetadata

-(id)schema: (NSArray*) schema
    count: (NSNumber*) count
{
  _schema = schema;
  _count = count;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _schema = dict[@"schema"]; 
        _count = dict[@"count"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_schema != nil) dict[@"schema"] = _schema ;
    if(_count != nil) dict[@"count"] = _count ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


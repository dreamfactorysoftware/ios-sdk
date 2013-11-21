#import "NIKDate.h"
#import "RVBRelatedSchema.h"

@implementation RVBRelatedSchema

-(id)name: (NSString*) name
    type: (NSString*) type
    ref_table: (NSString*) ref_table
    ref_field: (NSString*) ref_field
    join: (NSString*) join
    field: (NSString*) field
{
  _name = name;
  _type = type;
  _ref_table = ref_table;
  _ref_field = ref_field;
  _join = join;
  _field = field;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        _type = dict[@"type"]; 
        _ref_table = dict[@"ref_table"]; 
        _ref_field = dict[@"ref_field"]; 
        _join = dict[@"join"]; 
        _field = dict[@"field"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(_type != nil) dict[@"type"] = _type ;
    if(_ref_table != nil) dict[@"ref_table"] = _ref_table ;
    if(_ref_field != nil) dict[@"ref_field"] = _ref_field ;
    if(_join != nil) dict[@"join"] = _join ;
    if(_field != nil) dict[@"field"] = _field ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


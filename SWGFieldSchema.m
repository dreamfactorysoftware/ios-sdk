#import "NIKDate.h"
#import "SWGFieldSchema.h"

@implementation SWGFieldSchema

-(id)name: (NSString*) name
    label: (NSString*) label
    type: (NSString*) type
    db_type: (NSString*) db_type
    length: (NSNumber*) length
    precision: (NSNumber*) precision
    scale: (NSNumber*) scale
    default_value: (NSString*) default_value
    required: (NSNumber*) required
    allow_null: (NSNumber*) allow_null
    fixed_length: (NSNumber*) fixed_length
    supports_multibyte: (NSNumber*) supports_multibyte
    auto_increment: (NSNumber*) auto_increment
    is_primary_key: (NSNumber*) is_primary_key
    is_foreign_key: (NSNumber*) is_foreign_key
    ref_table: (NSString*) ref_table
    ref_fields: (NSString*) ref_fields
    validation: (NSArray*) validation
    values: (NSArray*) values
{
  _name = name;
  _label = label;
  _type = type;
  _db_type = db_type;
  _length = length;
  _precision = precision;
  _scale = scale;
  _default_value = default_value;
  _required = required;
  _allow_null = allow_null;
  _fixed_length = fixed_length;
  _supports_multibyte = supports_multibyte;
  _auto_increment = auto_increment;
  _is_primary_key = is_primary_key;
  _is_foreign_key = is_foreign_key;
  _ref_table = ref_table;
  _ref_fields = ref_fields;
  _validation = validation;
  _values = values;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        _label = dict[@"label"]; 
        _type = dict[@"type"]; 
        _db_type = dict[@"db_type"]; 
        _length = dict[@"length"]; 
        _precision = dict[@"precision"]; 
        _scale = dict[@"scale"]; 
        _default_value = dict[@"default_value"]; 
        _required = dict[@"required"]; 
        _allow_null = dict[@"allow_null"]; 
        _fixed_length = dict[@"fixed_length"]; 
        _supports_multibyte = dict[@"supports_multibyte"]; 
        _auto_increment = dict[@"auto_increment"]; 
        _is_primary_key = dict[@"is_primary_key"]; 
        _is_foreign_key = dict[@"is_foreign_key"]; 
        _ref_table = dict[@"ref_table"]; 
        _ref_fields = dict[@"ref_fields"]; 
        _validation = dict[@"validation"]; 
        _values = dict[@"values"]; 
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(_label != nil) dict[@"label"] = _label ;
    if(_type != nil) dict[@"type"] = _type ;
    if(_db_type != nil) dict[@"db_type"] = _db_type ;
    if(_length != nil) dict[@"length"] = _length ;
    if(_precision != nil) dict[@"precision"] = _precision ;
    if(_scale != nil) dict[@"scale"] = _scale ;
    if(_default_value != nil) dict[@"default_value"] = _default_value ;
    if(_required != nil) dict[@"required"] = _required ;
    if(_allow_null != nil) dict[@"allow_null"] = _allow_null ;
    if(_fixed_length != nil) dict[@"fixed_length"] = _fixed_length ;
    if(_supports_multibyte != nil) dict[@"supports_multibyte"] = _supports_multibyte ;
    if(_auto_increment != nil) dict[@"auto_increment"] = _auto_increment ;
    if(_is_primary_key != nil) dict[@"is_primary_key"] = _is_primary_key ;
    if(_is_foreign_key != nil) dict[@"is_foreign_key"] = _is_foreign_key ;
    if(_ref_table != nil) dict[@"ref_table"] = _ref_table ;
    if(_ref_fields != nil) dict[@"ref_fields"] = _ref_fields ;
    if(_validation != nil) dict[@"validation"] = _validation ;
    if(_values != nil) dict[@"values"] = _values ;
    NSDictionary* output = [dict copy];
    return output;
}

@end


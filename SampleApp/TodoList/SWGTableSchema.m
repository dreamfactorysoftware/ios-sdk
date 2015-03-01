#import "NIKDate.h"
#import "SWGTableSchema.h"

@implementation SWGTableSchema

-(id)name: (NSString*) name
    label: (NSString*) label
    plural: (NSString*) plural
    primary_key: (NSString*) primary_key
    name_field: (NSString*) name_field
    field: (NSArray*) field
    related: (NSArray*) related
{
  _name = name;
  _label = label;
  _plural = plural;
  _primary_key = primary_key;
  _name_field = name_field;
  _field = field;
  _related = related;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _name = dict[@"name"]; 
        _label = dict[@"label"]; 
        _plural = dict[@"plural"]; 
        _primary_key = dict[@"primary_key"]; 
        _name_field = dict[@"name_field"]; 
        id field_dict = dict[@"field"];
        if([field_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)field_dict count]];

            if([(NSArray*)field_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)field_dict) {
                    SWGFieldSchema* d = [[SWGFieldSchema alloc] initWithValues:dict];
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
        id related_dict = dict[@"related"];
        if([related_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)related_dict count]];

            if([(NSArray*)related_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)related_dict) {
                    SWGRelatedSchema* d = [[SWGRelatedSchema alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _related = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _related = [[NSArray alloc] init];
            }
        }
        else {
            _related = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_name != nil) dict[@"name"] = _name ;
    if(_label != nil) dict[@"label"] = _label ;
    if(_plural != nil) dict[@"plural"] = _plural ;
    if(_primary_key != nil) dict[@"primary_key"] = _primary_key ;
    if(_name_field != nil) dict[@"name_field"] = _name_field ;
    if(_field != nil){
        if([_field isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGFieldSchema *field in (NSArray*)_field) {
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
    if(_related != nil){
        if([_related isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGRelatedSchema *related in (NSArray*)_related) {
                [array addObject:[(NIKSwaggerObject*)related asDictionary]];
            }
            dict[@"related"] = array;
        }
        else if(_related && [_related isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_related toString];
            if(dateString){
                dict[@"related"] = dateString;
            }
        }
    }
    else {
    if(_related != nil) dict[@"related"] = [(NIKSwaggerObject*)_related asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


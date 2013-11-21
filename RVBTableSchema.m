#import "NIKDate.h"
#import "RVBTableSchema.h"

@implementation RVBTableSchema

-(id)name: (NSString*) name
    label: (NSArray*) label
    plural: (NSArray*) plural
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
        id label_dict = dict[@"label"];
        if([label_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)label_dict count]];

            if([(NSArray*)label_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)label_dict) {
                    RVBEmailAddress* d = [[RVBEmailAddress alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _label = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _label = [[NSArray alloc] init];
            }
        }
        else {
            _label = [[NSArray alloc] init];
        }
        id plural_dict = dict[@"plural"];
        if([plural_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)plural_dict count]];

            if([(NSArray*)plural_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)plural_dict) {
                    RVBEmailAddress* d = [[RVBEmailAddress alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _plural = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _plural = [[NSArray alloc] init];
            }
        }
        else {
            _plural = [[NSArray alloc] init];
        }
        _primary_key = dict[@"primary_key"]; 
        _name_field = dict[@"name_field"]; 
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
        id related_dict = dict[@"related"];
        if([related_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)related_dict count]];

            if([(NSArray*)related_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)related_dict) {
                    RVBRelatedSchema* d = [[RVBRelatedSchema alloc] initWithValues:dict];
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
    if(_label != nil){
        if([_label isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBEmailAddress *label in (NSArray*)_label) {
                [array addObject:[(NIKSwaggerObject*)label asDictionary]];
            }
            dict[@"label"] = array;
        }
        else if(_label && [_label isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_label toString];
            if(dateString){
                dict[@"label"] = dateString;
            }
        }
    }
    else {
    if(_label != nil) dict[@"label"] = [(NIKSwaggerObject*)_label asDictionary];
    }
    if(_plural != nil){
        if([_plural isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBEmailAddress *plural in (NSArray*)_plural) {
                [array addObject:[(NIKSwaggerObject*)plural asDictionary]];
            }
            dict[@"plural"] = array;
        }
        else if(_plural && [_plural isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_plural toString];
            if(dateString){
                dict[@"plural"] = dateString;
            }
        }
    }
    else {
    if(_plural != nil) dict[@"plural"] = [(NIKSwaggerObject*)_plural asDictionary];
    }
    if(_primary_key != nil) dict[@"primary_key"] = _primary_key ;
    if(_name_field != nil) dict[@"name_field"] = _name_field ;
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
    if(_related != nil){
        if([_related isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( RVBRelatedSchema *related in (NSArray*)_related) {
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


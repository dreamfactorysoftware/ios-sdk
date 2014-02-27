#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGRelatedRole : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* description;
@property(nonatomic) NSNumber* is_active;
@property(nonatomic) NSNumber* default_app_id;
@property(nonatomic) NSString* created_date;
@property(nonatomic) NSNumber* created_by_id;
@property(nonatomic) NSString* last_modified_date;
@property(nonatomic) NSNumber* last_modified_by_id;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     description: (NSString*) description
     is_active: (NSNumber*) is_active
     default_app_id: (NSNumber*) default_app_id
     created_date: (NSString*) created_date
     created_by_id: (NSNumber*) created_by_id
     last_modified_date: (NSString*) last_modified_date
     last_modified_by_id: (NSNumber*) last_modified_by_id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


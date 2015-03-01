#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRelatedApps.h"

@interface SWGAppGroupResponse : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* swg_description;
@property(nonatomic) SWGRelatedApps* apps;
@property(nonatomic) NSString* created_date;
@property(nonatomic) NSNumber* created_by_id;
@property(nonatomic) NSString* last_modified_date;
@property(nonatomic) NSNumber* last_modified_by_id;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     swg_description: (NSString*) swg_description
     apps: (SWGRelatedApps*) apps
     created_date: (NSString*) created_date
     created_by_id: (NSNumber*) created_by_id
     last_modified_date: (NSString*) last_modified_date
     last_modified_by_id: (NSNumber*) last_modified_by_id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


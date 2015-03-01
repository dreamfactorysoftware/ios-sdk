#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRelatedApps.h"
#import "SWGRelatedServices.h"
#import "SWGRelatedApp.h"
#import "SWGRelatedUsers.h"

@interface SWGRoleResponse : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* swgdescription;
@property(nonatomic) NSNumber* is_active;
@property(nonatomic) NSNumber* default_app_id;
@property(nonatomic) SWGRelatedApp* default_app;
@property(nonatomic) SWGRelatedUsers* users;
@property(nonatomic) SWGRelatedApps* apps;
@property(nonatomic) SWGRelatedServices* services;
@property(nonatomic) NSString* created_date;
@property(nonatomic) NSNumber* created_by_id;
@property(nonatomic) NSString* last_modified_date;
@property(nonatomic) NSNumber* last_modified_by_id;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     description: (NSString*) description
     is_active: (NSNumber*) is_active
     default_app_id: (NSNumber*) default_app_id
     default_app: (SWGRelatedApp*) default_app
     users: (SWGRelatedUsers*) users
     apps: (SWGRelatedApps*) apps
     services: (SWGRelatedServices*) services
     created_date: (NSString*) created_date
     created_by_id: (NSNumber*) created_by_id
     last_modified_date: (NSString*) last_modified_date
     last_modified_by_id: (NSNumber*) last_modified_by_id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


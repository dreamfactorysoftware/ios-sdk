#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRelatedServices.h"
#import "SWGRelatedAppGroups.h"
#import "SWGRelatedRoles.h"
#import "SWGRelatedUsers.h"

@interface SWGAppRequest : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* api_name;
@property(nonatomic) NSString* swg_description;
@property(nonatomic) NSNumber* is_active;
@property(nonatomic) NSString* url;
@property(nonatomic) NSNumber* is_url_external;
@property(nonatomic) NSString* import_url;
@property(nonatomic) NSString* storage_service_id;
@property(nonatomic) NSString* storage_container;
@property(nonatomic) NSNumber* requires_fullscreen;
@property(nonatomic) NSNumber* allow_fullscreen_toggle;
@property(nonatomic) NSString* toggle_location;
@property(nonatomic) NSNumber* requires_plugin;
@property(nonatomic) SWGRelatedRoles* roles_default_app;
@property(nonatomic) SWGRelatedUsers* users_default_app;
@property(nonatomic) SWGRelatedAppGroups* app_groups;
@property(nonatomic) SWGRelatedRoles* roles;
@property(nonatomic) SWGRelatedServices* services;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     api_name: (NSString*) api_name
     swg_description: (NSString*) swg_description
     is_active: (NSNumber*) is_active
     url: (NSString*) url
     is_url_external: (NSNumber*) is_url_external
     import_url: (NSString*) import_url
     storage_service_id: (NSString*) storage_service_id
     storage_container: (NSString*) storage_container
     requires_fullscreen: (NSNumber*) requires_fullscreen
     allow_fullscreen_toggle: (NSNumber*) allow_fullscreen_toggle
     toggle_location: (NSString*) toggle_location
     requires_plugin: (NSNumber*) requires_plugin
     roles_default_app: (SWGRelatedRoles*) roles_default_app
     users_default_app: (SWGRelatedUsers*) users_default_app
     app_groups: (SWGRelatedAppGroups*) app_groups
     roles: (SWGRelatedRoles*) roles
     services: (SWGRelatedServices*) services;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


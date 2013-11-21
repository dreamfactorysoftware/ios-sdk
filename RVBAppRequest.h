#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "Integer.h"

@interface RVBAppRequest : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* api_name;
@property(nonatomic) NSString* description;
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
@property(nonatomic) NSArray* roles_default_app;
@property(nonatomic) NSArray* users_default_app;
@property(nonatomic) NSArray* app_groups;
@property(nonatomic) NSArray* roles;
@property(nonatomic) NSArray* services;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     api_name: (NSString*) api_name
     description: (NSString*) description
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
     roles_default_app: (NSArray*) roles_default_app
     users_default_app: (NSArray*) users_default_app
     app_groups: (NSArray*) app_groups
     roles: (NSArray*) roles
     services: (NSArray*) services;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


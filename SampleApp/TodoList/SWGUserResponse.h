#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRelatedApp.h"
#import "SWGRelatedRole.h"

@interface SWGUserResponse : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* email;
@property(nonatomic) NSString* password;
@property(nonatomic) NSString* first_name;
@property(nonatomic) NSString* last_name;
@property(nonatomic) NSString* display_name;
@property(nonatomic) NSString* phone;
@property(nonatomic) NSNumber* is_active;
@property(nonatomic) NSNumber* is_sys_admin;
@property(nonatomic) NSString* default_app_id;
@property(nonatomic) NSString* role_id;
@property(nonatomic) SWGRelatedApp* default_app;
@property(nonatomic) SWGRelatedRole* role;
@property(nonatomic) NSString* created_date;
@property(nonatomic) NSNumber* created_by_id;
@property(nonatomic) NSString* last_modified_date;
@property(nonatomic) NSNumber* last_modified_by_id;
@property(nonatomic) NSString* last_login_date;
- (id) _id: (NSNumber*) _id
     email: (NSString*) email
     password: (NSString*) password
     first_name: (NSString*) first_name
     last_name: (NSString*) last_name
     display_name: (NSString*) display_name
     phone: (NSString*) phone
     is_active: (NSNumber*) is_active
     is_sys_admin: (NSNumber*) is_sys_admin
     default_app_id: (NSString*) default_app_id
     role_id: (NSString*) role_id
     default_app: (SWGRelatedApp*) default_app
     role: (SWGRelatedRole*) role
     created_date: (NSString*) created_date
     created_by_id: (NSNumber*) created_by_id
     last_modified_date: (NSString*) last_modified_date
     last_modified_by_id: (NSNumber*) last_modified_by_id
     last_login_date: (NSString*) last_login_date;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


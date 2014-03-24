#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGSessionApp.h"

@interface SWGSession : NIKSwaggerObject

@property(nonatomic) NSString* _id;
@property(nonatomic) NSString* email;
@property(nonatomic) NSString* first_name;
@property(nonatomic) NSString* last_name;
@property(nonatomic) NSString* display_name;
@property(nonatomic) NSNumber* is_sys_admin;
@property(nonatomic) NSString* role;
@property(nonatomic) NSString* last_login_date;
@property(nonatomic) NSArray* app_groups;
@property(nonatomic) NSArray* no_group_apps;
@property(nonatomic) NSString* session_id;
@property(nonatomic) NSString* ticket;
@property(nonatomic) NSString* ticket_expiry;
- (id) _id: (NSString*) _id
     email: (NSString*) email
     first_name: (NSString*) first_name
     last_name: (NSString*) last_name
     display_name: (NSString*) display_name
     is_sys_admin: (NSNumber*) is_sys_admin
     role: (NSString*) role
     last_login_date: (NSString*) last_login_date
     app_groups: (NSArray*) app_groups
     no_group_apps: (NSArray*) no_group_apps
     session_id: (NSString*) session_id
     ticket: (NSString*) ticket
     ticket_expiry: (NSString*) ticket_expiry;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


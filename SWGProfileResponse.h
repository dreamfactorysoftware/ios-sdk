#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGProfileResponse : NIKSwaggerObject

@property(nonatomic) NSString* email;
@property(nonatomic) NSString* first_name;
@property(nonatomic) NSString* last_name;
@property(nonatomic) NSString* display_name;
@property(nonatomic) NSString* phone;
@property(nonatomic) NSString* security_question;
@property(nonatomic) NSNumber* default_app_id;
- (id) email: (NSString*) email
     first_name: (NSString*) first_name
     last_name: (NSString*) last_name
     display_name: (NSString*) display_name
     phone: (NSString*) phone
     security_question: (NSString*) security_question
     default_app_id: (NSNumber*) default_app_id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


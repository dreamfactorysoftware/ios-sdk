#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGRegister : NIKSwaggerObject

@property(nonatomic,retain) NSString* email;
@property(nonatomic,retain) NSString* first_name;
@property(nonatomic,retain) NSString* last_name;
@property(nonatomic,retain) NSString* display_name;
@property(nonatomic,retain) NSString *newpassword;
@property(nonatomic,retain) NSString* code;
- (id) email: (NSString*) email
     first_name: (NSString*) first_name
     last_name: (NSString*) last_name
     display_name: (NSString*) display_name
     new_password: (NSString*) new_password
     code: (NSString*) code;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


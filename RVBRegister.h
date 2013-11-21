#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface RVBRegister : NIKSwaggerObject

@property(nonatomic) NSString* email;
@property(nonatomic) NSString* first_name;
@property(nonatomic) NSString* last_name;
@property(nonatomic) NSString* display_name;
@property(nonatomic) NSString* new_password;
@property(nonatomic) NSString* code;
- (id) email: (NSString*) email
     first_name: (NSString*) first_name
     last_name: (NSString*) last_name
     display_name: (NSString*) display_name
     new_password: (NSString*) new_password
     code: (NSString*) code;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


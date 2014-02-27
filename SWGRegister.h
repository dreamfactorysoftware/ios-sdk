#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGRegister : NIKSwaggerObject

@property(nonatomic) NSString* email;
@property(nonatomic) NSString* first_name;
@property(nonatomic) NSString* last_name;
@property(nonatomic) NSString* display_name;
@property(nonatomic) NSString* _new_password;
@property(nonatomic) NSString* code;
- (id) email: (NSString*) email
     first_name: (NSString*) first_name
     last_name: (NSString*) last_name
     display_name: (NSString*) display_name
     _new_password: (NSString*) _new_password
     code: (NSString*) code;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


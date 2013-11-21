#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface RVBPasswordRequest : NIKSwaggerObject

@property(nonatomic) NSString* old_password;
@property(nonatomic) NSString* new_password;
@property(nonatomic) NSString* email;
@property(nonatomic) NSString* code;
- (id) old_password: (NSString*) old_password
     new_password: (NSString*) new_password
     email: (NSString*) email
     code: (NSString*) code;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


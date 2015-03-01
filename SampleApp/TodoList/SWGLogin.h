#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGLogin : NIKSwaggerObject

@property(nonatomic) NSString* email;
@property(nonatomic) NSString* password;
@property(nonatomic) NSNumber* duration;
- (id) email: (NSString*) email
     password: (NSString*) password
     duration: (NSNumber*) duration;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


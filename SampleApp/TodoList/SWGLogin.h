#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGLogin : NIKSwaggerObject

@property(nonatomic) NSString* email;
@property(nonatomic) NSString* password;
- (id) email: (NSString*) email
     password: (NSString*) password;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


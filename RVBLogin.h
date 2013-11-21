#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface RVBLogin : NIKSwaggerObject

@property(nonatomic) NSString* email;
@property(nonatomic) NSString* password;
- (id) email: (NSString*) email
     password: (NSString*) password;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


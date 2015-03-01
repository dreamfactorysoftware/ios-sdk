#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGPasswordResponse : NIKSwaggerObject

@property(nonatomic) NSString* security_question;
@property(nonatomic) NSNumber* success;
- (id) security_question: (NSString*) security_question
     success: (NSNumber*) success;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


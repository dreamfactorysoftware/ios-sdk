#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGEmailAddress.h"

@interface SWGEmailRequest : NIKSwaggerObject

@property(nonatomic) NSString* template;
@property(nonatomic) NSNumber* template_id;
@property(nonatomic) NSArray* to;
@property(nonatomic) NSArray* cc;
@property(nonatomic) NSArray* bcc;
@property(nonatomic) NSString* subject;
@property(nonatomic) NSString* body_text;
@property(nonatomic) NSString* body_html;
@property(nonatomic) NSString* from_name;
@property(nonatomic) NSString* from_email;
@property(nonatomic) NSString* reply_to_name;
@property(nonatomic) NSString* reply_to_email;
- (id) template: (NSString*) template
     template_id: (NSNumber*) template_id
     to: (NSArray*) to
     cc: (NSArray*) cc
     bcc: (NSArray*) bcc
     subject: (NSString*) subject
     body_text: (NSString*) body_text
     body_html: (NSString*) body_html
     from_name: (NSString*) from_name
     from_email: (NSString*) from_email
     reply_to_name: (NSString*) reply_to_name
     reply_to_email: (NSString*) reply_to_email;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


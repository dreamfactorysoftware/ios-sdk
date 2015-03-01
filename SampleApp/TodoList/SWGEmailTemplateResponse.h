#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGEmailAddress.h"

@interface SWGEmailTemplateResponse : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* swgdescription;
@property(nonatomic) NSArray* to;
@property(nonatomic) NSArray* cc;
@property(nonatomic) NSArray* bcc;
@property(nonatomic) NSString* subject;
@property(nonatomic) NSString* body_text;
@property(nonatomic) NSString* body_html;
@property(nonatomic) SWGEmailAddress* from;
@property(nonatomic) SWGEmailAddress* reply_to;
@property(nonatomic) NSArray* defaults;
@property(nonatomic) NSString* created_date;
@property(nonatomic) NSNumber* created_by_id;
@property(nonatomic) NSString* last_modified_date;
@property(nonatomic) NSNumber* last_modified_by_id;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     description: (NSString*) description
     to: (NSArray*) to
     cc: (NSArray*) cc
     bcc: (NSArray*) bcc
     subject: (NSString*) subject
     body_text: (NSString*) body_text
     body_html: (NSString*) body_html
     from: (SWGEmailAddress*) from
     reply_to: (SWGEmailAddress*) reply_to
     defaults: (NSArray*) defaults
     created_date: (NSString*) created_date
     created_by_id: (NSNumber*) created_by_id
     last_modified_date: (NSString*) last_modified_date
     last_modified_by_id: (NSNumber*) last_modified_by_id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


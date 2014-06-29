#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGScriptResponse : NIKSwaggerObject

@property(nonatomic) NSString* script_id;
@property(nonatomic) NSString* script_body;
@property(nonatomic) NSArray* metadata;
@property(nonatomic) NSString* created_date;
@property(nonatomic) NSNumber* created_by_id;
@property(nonatomic) NSString* last_modified_date;
@property(nonatomic) NSNumber* last_modified_by_id;
- (id) script_id: (NSString*) script_id
     script_body: (NSString*) script_body
     metadata: (NSArray*) metadata
     created_date: (NSString*) created_date
     created_by_id: (NSNumber*) created_by_id
     last_modified_date: (NSString*) last_modified_date
     last_modified_by_id: (NSNumber*) last_modified_by_id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


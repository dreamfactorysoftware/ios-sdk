#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "Integer.h"

@interface SWGScriptResponse : NIKSwaggerObject

@property(nonatomic) NSString* script_id;
@property(nonatomic) NSString* script_body;
@property(nonatomic) NSString* script;
@property(nonatomic) NSNumber* is_user_script;
@property(nonatomic) NSString* language;
@property(nonatomic) NSString* file_name;
@property(nonatomic) NSString* file_path;
@property(nonatomic) NSNumber* file_mtime;
@property(nonatomic) NSString* event_name;
@property(nonatomic) NSArray* metadata;
@property(nonatomic) NSString* created_date;
@property(nonatomic) NSNumber* created_by_id;
@property(nonatomic) NSString* last_modified_date;
@property(nonatomic) NSNumber* last_modified_by_id;
- (id) script_id: (NSString*) script_id
     script_body: (NSString*) script_body
     script: (NSString*) script
     is_user_script: (NSNumber*) is_user_script
     language: (NSString*) language
     file_name: (NSString*) file_name
     file_path: (NSString*) file_path
     file_mtime: (NSNumber*) file_mtime
     event_name: (NSString*) event_name
     metadata: (NSArray*) metadata
     created_date: (NSString*) created_date
     created_by_id: (NSNumber*) created_by_id
     last_modified_date: (NSString*) last_modified_date
     last_modified_by_id: (NSNumber*) last_modified_by_id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGFileResponse : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* path;
@property(nonatomic) NSString* content_type;
@property(nonatomic) NSArray* metadata;
@property(nonatomic) NSString* content_length;
@property(nonatomic) NSString* last_modified;
- (id) name: (NSString*) name
     path: (NSString*) path
     content_type: (NSString*) content_type
     metadata: (NSArray*) metadata
     content_length: (NSString*) content_length
     last_modified: (NSString*) last_modified;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


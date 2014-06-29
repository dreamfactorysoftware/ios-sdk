#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGFileRequest : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* path;
@property(nonatomic) NSString* content_type;
@property(nonatomic) NSArray* metadata;
- (id) name: (NSString*) name
     path: (NSString*) path
     content_type: (NSString*) content_type
     metadata: (NSArray*) metadata;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


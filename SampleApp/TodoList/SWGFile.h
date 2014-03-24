#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGFile : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* path;
@property(nonatomic) NSString* content_type;
@property(nonatomic) NSString* _property_;
@property(nonatomic) NSArray* metadata;
- (id) name: (NSString*) name
     path: (NSString*) path
     content_type: (NSString*) content_type
     _property_: (NSString*) _property_
     metadata: (NSArray*) metadata;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


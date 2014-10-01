#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGFileResponse.h"
#import "SWGFolderResponse.h"

@interface SWGFolderResponse : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* path;
@property(nonatomic) NSArray* metadata;
@property(nonatomic) NSString* last_modified;
@property(nonatomic) NSArray* folder;
@property(nonatomic) NSArray* file;
- (id) name: (NSString*) name
     path: (NSString*) path
     metadata: (NSArray*) metadata
     last_modified: (NSString*) last_modified
     folder: (NSArray*) folder
     file: (NSArray*) file;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


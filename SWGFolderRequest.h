#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGFolderRequest.h"
#import "SWGFileRequest.h"

@interface SWGFolderRequest : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* path;
@property(nonatomic) NSArray* metadata;
@property(nonatomic) NSArray* folder;
@property(nonatomic) NSArray* file;
- (id) name: (NSString*) name
     path: (NSString*) path
     metadata: (NSArray*) metadata
     folder: (NSArray*) folder
     file: (NSArray*) file;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


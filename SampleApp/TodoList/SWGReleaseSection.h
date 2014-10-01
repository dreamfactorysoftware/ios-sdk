#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGReleaseSection : NIKSwaggerObject

@property(nonatomic) NSString* swg_id;
@property(nonatomic) NSString* swgrelease;
@property(nonatomic) NSString* codename;
@property(nonatomic) NSString* description;
- (id) _id: (NSString*) _id
     swgrelease: (NSString*) swgrelease
     codename: (NSString*) codename
     description: (NSString*) description;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


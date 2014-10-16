#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGReleaseSection : NIKSwaggerObject

@property(nonatomic) NSString* swg_id;
@property(nonatomic) NSString* swgrelease;
@property(nonatomic) NSString* codename;
@property(nonatomic) NSString* swg_description;
- (id) _id: (NSString*) _id
     swgrelease: (NSString*) swgrelease
     codename: (NSString*) codename
     swg_description: (NSString*) swg_description;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


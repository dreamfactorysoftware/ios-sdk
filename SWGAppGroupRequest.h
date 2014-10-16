#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRelatedApps.h"

@interface SWGAppGroupRequest : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* swg_description;
@property(nonatomic) SWGRelatedApps* apps;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     swg_description: (NSString*) swg_description
     apps: (SWGRelatedApps*) apps;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


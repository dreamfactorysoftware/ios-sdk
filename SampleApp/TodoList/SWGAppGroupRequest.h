#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRelatedApps.h"

@interface SWGAppGroupRequest : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* swgdescription;
@property(nonatomic) SWGRelatedApps* apps;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     description: (NSString*) description
     apps: (SWGRelatedApps*) apps;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


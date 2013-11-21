#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBApp.h"
#import "RVBRVBApp*.h"
#import "Integer.h"

@interface RVBAppGroupRequest : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* description;
@property(nonatomic) NSArray* apps;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     description: (NSString*) description
     apps: (NSArray*) apps;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


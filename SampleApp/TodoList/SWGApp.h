#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
//#import "Integer.h"

@interface SWGApp : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* description;
@property(nonatomic) NSNumber* is_url_external;
@property(nonatomic) NSString* launch_url;
@property(nonatomic) NSNumber* requires_fullscreen;
@property(nonatomic) NSNumber* allow_fullscreen_toggle;
@property(nonatomic) NSString* toggle_location;
@property(nonatomic) NSNumber* is_default;
- (id) _id: (NSNumber*) _id
     name: (NSString*) name
     description: (NSString*) description
     is_url_external: (NSNumber*) is_url_external
     launch_url: (NSString*) launch_url
     requires_fullscreen: (NSNumber*) requires_fullscreen
     allow_fullscreen_toggle: (NSNumber*) allow_fullscreen_toggle
     toggle_location: (NSString*) toggle_location
     is_default: (NSNumber*) is_default;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


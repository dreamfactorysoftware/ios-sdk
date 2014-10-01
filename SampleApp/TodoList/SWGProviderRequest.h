#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRelatedApps.h"
#import "SWGProviderConfigSettings.h"

@interface SWGProviderRequest : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* provider_name;
@property(nonatomic) NSString* api_name;
@property(nonatomic) NSNumber* is_active;
@property(nonatomic) NSNumber* is_login_provider;
@property(nonatomic) NSNumber* is_system;
@property(nonatomic) NSNumber* base_provider_id;
@property(nonatomic) SWGProviderConfigSettings* config_text;
@property(nonatomic) SWGRelatedApps* apps;
- (id) _id: (NSNumber*) _id
     provider_name: (NSString*) provider_name
     api_name: (NSString*) api_name
     is_active: (NSNumber*) is_active
     is_login_provider: (NSNumber*) is_login_provider
     is_system: (NSNumber*) is_system
     base_provider_id: (NSNumber*) base_provider_id
     config_text: (SWGProviderConfigSettings*) config_text
     apps: (SWGRelatedApps*) apps;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGDate.h"
#import "SWGProviderConfigSettings.h"

@interface SWGProviderResponse : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* provider_name;
@property(nonatomic) NSString* api_name;
@property(nonatomic) NSNumber* is_active;
@property(nonatomic) NSNumber* is_login_provider;
@property(nonatomic) NSNumber* is_system;
@property(nonatomic) NSNumber* base_provider_id;
@property(nonatomic) SWGProviderConfigSettings* config_text;
@property(nonatomic) SWGDate* created_date;
@property(nonatomic) NSNumber* created_by_id;
@property(nonatomic) SWGDate* last_modified_date;
@property(nonatomic) NSNumber* last_modified_by_id;
- (id) _id: (NSNumber*) _id
     provider_name: (NSString*) provider_name
     api_name: (NSString*) api_name
     is_active: (NSNumber*) is_active
     is_login_provider: (NSNumber*) is_login_provider
     is_system: (NSNumber*) is_system
     base_provider_id: (NSNumber*) base_provider_id
     config_text: (SWGProviderConfigSettings*) config_text
     created_date: (SWGDate*) created_date
     created_by_id: (NSNumber*) created_by_id
     last_modified_date: (SWGDate*) last_modified_date
     last_modified_by_id: (NSNumber*) last_modified_by_id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


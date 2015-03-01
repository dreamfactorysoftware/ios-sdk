#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGReleaseSection.h"
#import "SWGPlatformSection.h"
#import "SWGPhpInfoSection.h"
#import "SWGServerSection.h"

@interface SWGEnvironmentResponse : NIKSwaggerObject

@property(nonatomic) SWGServerSection* server;
@property(nonatomic) SWGReleaseSection* swgrelease;
@property(nonatomic) SWGPlatformSection* platform;
@property(nonatomic) NSArray* php_info;
- (id) server: (SWGServerSection*) server
     swgrelease: (SWGReleaseSection*) swgrelease
     platform: (SWGPlatformSection*) platform
     php_info: (NSArray*) php_info;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


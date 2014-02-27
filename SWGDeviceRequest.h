#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGDeviceRequest : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* uuid;
@property(nonatomic) NSString* platform;
@property(nonatomic) NSString* version;
@property(nonatomic) NSString* model;
@property(nonatomic) NSString* extra;
- (id) _id: (NSNumber*) _id
     uuid: (NSString*) uuid
     platform: (NSString*) platform
     version: (NSString*) version
     model: (NSString*) model
     extra: (NSString*) extra;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


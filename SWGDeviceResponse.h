#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRelatedUser.h"

@interface SWGDeviceResponse : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* uuid;
@property(nonatomic) NSString* platform;
@property(nonatomic) NSString* version;
@property(nonatomic) NSString* model;
@property(nonatomic) NSString* extra;
@property(nonatomic) NSNumber* user_id;
@property(nonatomic) SWGRelatedUser* user;
@property(nonatomic) NSString* created_date;
@property(nonatomic) NSString* last_modified_date;
- (id) _id: (NSNumber*) _id
     uuid: (NSString*) uuid
     platform: (NSString*) platform
     version: (NSString*) version
     model: (NSString*) model
     extra: (NSString*) extra
     user_id: (NSNumber*) user_id
     user: (SWGRelatedUser*) user
     created_date: (NSString*) created_date
     last_modified_date: (NSString*) last_modified_date;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


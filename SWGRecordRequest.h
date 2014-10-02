#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGRecordRequest : NIKSwaggerObject

@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* _complete;
@property(nonatomic) NSString* _field_;

- (id) _id: (NSNumber*) _id;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


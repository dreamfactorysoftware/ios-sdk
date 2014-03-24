#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGRecord : NIKSwaggerObject

@property(nonatomic) NSString* _field_;
@property(nonatomic) NSString* _complete;
@property(nonatomic) NSNumber  *_id;
@property(nonatomic) NSString* name;


- (id) _field_: (NSString*) _field_;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


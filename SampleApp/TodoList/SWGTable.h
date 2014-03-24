#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGTable : NIKSwaggerObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* _property_;
- (id) name: (NSString*) name
     _property_: (NSString*) _property_;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


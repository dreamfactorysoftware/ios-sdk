#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGStoredProcResponse : NIKSwaggerObject

@property(nonatomic) NSArray* _wrapper_if_supplied_;
@property(nonatomic) NSString* _out_param_name_;
- (id) _wrapper_if_supplied_: (NSArray*) _wrapper_if_supplied_
     _out_param_name_: (NSString*) _out_param_name_;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


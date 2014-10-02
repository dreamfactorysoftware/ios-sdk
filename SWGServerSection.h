#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGServerSection : NIKSwaggerObject

@property(nonatomic) NSString* server_os;
@property(nonatomic) NSString* uname;
- (id) server_os: (NSString*) server_os
     uname: (NSString*) uname;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


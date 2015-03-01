#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"

@interface SWGEventVerbs : NIKSwaggerObject

@property(nonatomic) NSString* type;
@property(nonatomic) NSArray* event;
@property(nonatomic) NSArray* scripts;
@property(nonatomic) NSArray* listeners;
- (id) type: (NSString*) type
     event: (NSArray*) event
     scripts: (NSArray*) scripts
     listeners: (NSArray*) listeners;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


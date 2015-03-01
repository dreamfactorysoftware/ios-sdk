#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGServiceRequest.h"

@interface SWGServicesRequest : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) NSArray* ids;
- (id) record: (NSArray*) record
     ids: (NSArray*) ids;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


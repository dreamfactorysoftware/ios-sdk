#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRoleRequest.h"

@interface SWGRolesRequest : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) NSArray* ids;
- (id) record: (NSArray*) record
     ids: (NSArray*) ids;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


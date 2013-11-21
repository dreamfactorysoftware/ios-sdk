#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBRVBAppGroupRequest*.h"
#import "RVBAppGroupRequest.h"

@interface RVBAppGroupsRequest : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) NSArray* ids;
- (id) record: (NSArray*) record
     ids: (NSArray*) ids;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


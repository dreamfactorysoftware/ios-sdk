#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBRVBAppGroupResponse*.h"
#import "RVBMetadata.h"
#import "RVBAppGroupResponse.h"
#import "RVBRVBMetadata*.h"

@interface RVBAppGroupsResponse : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) RVBMetadata* meta;
- (id) record: (NSArray*) record
     meta: (RVBMetadata*) meta;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


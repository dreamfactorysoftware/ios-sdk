#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBRVBAppResponse*.h"
#import "RVBMetadata.h"
#import "RVBRVBMetadata*.h"
#import "RVBAppResponse.h"

@interface RVBAppsResponse : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) RVBMetadata* meta;
- (id) record: (NSArray*) record
     meta: (RVBMetadata*) meta;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


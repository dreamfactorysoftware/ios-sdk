#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBMetadata.h"
#import "RVBServiceResponse.h"
#import "RVBRVBMetadata*.h"
#import "RVBRVBServiceResponse*.h"

@interface RVBServicesResponse : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) RVBMetadata* meta;
- (id) record: (NSArray*) record
     meta: (RVBMetadata*) meta;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


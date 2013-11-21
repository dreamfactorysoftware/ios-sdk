#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBRVBRecord*.h"
#import "RVBMetadata.h"
#import "RVBRecord.h"
#import "RVBRVBMetadata*.h"

@interface RVBRecords : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) RVBMetadata* meta;
- (id) record: (NSArray*) record
     meta: (RVBMetadata*) meta;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


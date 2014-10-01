#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRecordRequest.h"

@interface SWGIdsRecordRequest : NIKSwaggerObject

@property(nonatomic) SWGRecordRequest* record;
@property(nonatomic) NSArray* ids;
- (id) record: (SWGRecordRequest*) record
     ids: (NSArray*) ids;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


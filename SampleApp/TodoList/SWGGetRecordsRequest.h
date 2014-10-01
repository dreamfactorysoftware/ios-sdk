#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRecordRequest.h"

@interface SWGGetRecordsRequest : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) NSArray* ids;
@property(nonatomic) NSString* filter;
@property(nonatomic) NSArray* params;
- (id) record: (NSArray*) record
     ids: (NSArray*) ids
     filter: (NSString*) filter
     params: (NSArray*) params;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


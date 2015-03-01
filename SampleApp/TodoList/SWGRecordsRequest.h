#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRecordRequest.h"

@interface SWGRecordsRequest : NIKSwaggerObject

@property(nonatomic) NSArray* record;
- (id) record: (NSArray*) record;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


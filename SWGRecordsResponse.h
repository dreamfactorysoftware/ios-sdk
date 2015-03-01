#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRecordResponse.h"
#import "SWGMetadata.h"

@interface SWGRecordsResponse : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) SWGMetadata* meta;
- (id) record: (NSArray*) record
     meta: (SWGMetadata*) meta;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


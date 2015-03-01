#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGRecordRequest.h"

@interface SWGFilterRecordRequest : NIKSwaggerObject

@property(nonatomic) SWGRecordRequest* record;
@property(nonatomic) NSString* filter;
@property(nonatomic) NSArray* params;
- (id) record: (SWGRecordRequest*) record
     filter: (NSString*) filter
     params: (NSArray*) params;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


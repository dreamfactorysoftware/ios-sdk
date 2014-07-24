#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGStoredProcResultSchema.h"
#import "SWGStoredProcParam.h"

@interface SWGStoredProcRequest : NIKSwaggerObject

@property(nonatomic) NSArray* params;
@property(nonatomic) SWGStoredProcResultSchema* schema;
@property(nonatomic) NSString* wrapper;
- (id) params: (NSArray*) params
     schema: (SWGStoredProcResultSchema*) schema
     wrapper: (NSString*) wrapper;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


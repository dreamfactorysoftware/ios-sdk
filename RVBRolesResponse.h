#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBRVBRole*.h"
#import "RVBRole.h"
#import "RVBMetadata.h"
#import "RVBRVBMetadata*.h"

@interface RVBRolesResponse : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) RVBMetadata* meta;
- (id) record: (NSArray*) record
     meta: (RVBMetadata*) meta;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


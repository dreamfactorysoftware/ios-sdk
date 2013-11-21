#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBRVBEmailTemplateResponse*.h"
#import "RVBMetadata.h"
#import "RVBEmailTemplateResponse.h"
#import "RVBRVBMetadata*.h"

@interface RVBEmailTemplatesResponse : NIKSwaggerObject

@property(nonatomic) NSArray* record;
@property(nonatomic) RVBMetadata* meta;
- (id) record: (NSArray*) record
     meta: (RVBMetadata*) meta;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


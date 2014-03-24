#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "SWGTable.h"

@interface SWGTables : NIKSwaggerObject

@property(nonatomic) NSArray* table;
- (id) table: (NSArray*) table;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


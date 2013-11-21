#import <Foundation/Foundation.h>
#import "NIKSwaggerObject.h"
#import "RVBRVBTable*.h"
#import "RVBTable.h"

@interface RVBTables : NIKSwaggerObject

@property(nonatomic) NSArray* table;
- (id) table: (NSArray*) table;

- (id) initWithValues: (NSDictionary*)dict;
- (NSDictionary*) asDictionary;


@end


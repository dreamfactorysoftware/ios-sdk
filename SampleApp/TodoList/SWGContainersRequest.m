#import "NIKDate.h"
#import "SWGContainersRequest.h"

@implementation SWGContainersRequest

-(id)container: (NSArray*) container
{
  _container = container;
  return self;
}

-(id) initWithValues:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        id container_dict = dict[@"container"];
        if([container_dict isKindOfClass:[NSArray class]]) {

            NSMutableArray * objs = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)container_dict count]];

            if([(NSArray*)container_dict count] > 0) {
                for (NSDictionary* dict in (NSArray*)container_dict) {
                    SWGContainer* d = [[SWGContainer alloc] initWithValues:dict];
                    [objs addObject:d];
                }
                
                _container = [[NSArray alloc] initWithArray:objs];
            }
            else {
                _container = [[NSArray alloc] init];
            }
        }
        else {
            _container = [[NSArray alloc] init];
        }
        

    }
    return self;
}

-(NSDictionary*) asDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(_container != nil){
        if([_container isKindOfClass:[NSArray class]]){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            for( SWGContainer *container in (NSArray*)_container) {
                [array addObject:[(NIKSwaggerObject*)container asDictionary]];
            }
            dict[@"container"] = array;
        }
        else if(_container && [_container isKindOfClass:[NIKDate class]]) {
            NSString * dateString = [(NIKDate*)_container toString];
            if(dateString){
                dict[@"container"] = dateString;
            }
        }
    }
    else {
    if(_container != nil) dict[@"container"] = [(NIKSwaggerObject*)_container asDictionary];
    }
    NSDictionary* output = [dict copy];
    return output;
}

@end


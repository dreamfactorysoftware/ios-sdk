#import "SWGDbApi.h"
#import "NIKFile.h"
#import "SWGTableSchemas.h"
#import "SWGStoredProcRequest.h"
#import "SWGRecordsRequest.h"
#import "SWGRecordResponse.h"
#import "SWGFieldSchema.h"
#import "SWGIdsRequest.h"
#import "SWGRecordRequest.h"
#import "SWGFilterRequest.h"
#import "SWGGetRecordsRequest.h"
#import "SWGIdsRecordRequest.h"
#import "SWGTableSchema.h"
#import "SWGResources.h"
#import "SWGFilterRecordRequest.h"
#import "SWGSuccess.h"
#import "SWGRecordsResponse.h"
#import "SWGStoredProcResponse.h"
#import "SWGComponentList.h"



@implementation SWGDbApi
static NSString * basePath = @"http://localhost/rest";

@synthesize queue = _queue;
@synthesize api = _api;

+(SWGDbApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {
    static SWGDbApi* singletonAPI = nil;

    if (singletonAPI == nil) {
        singletonAPI = [[SWGDbApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

-(id) init {
    self = [super init];
    _queue = [[NSOperationQueue alloc] init];
    _api = [NIKApiInvoker sharedInstance];

    return self;
}

-(void)setBaseUrlPath:(NSString*)baseUrl{
    
    NSString *lastPathComponent=[baseUrl lastPathComponent];
    
    if(![lastPathComponent isEqualToString:@"rest"])
        
        basePath=[baseUrl stringByAppendingString:@"/rest"];
    
    else{
        
        basePath=baseUrl;
        
    }
    
}

-(void) addHeader:(NSString*) value
           forKey:(NSString*)key {
    [_api addHeader:value forKey:key];
}

-(void) getResourcesWithCompletionBlock: (void (^)(SWGResources* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGResources alloc]initWithValues: data], nil);}];
    

}

-(void) getTablesWithCompletionBlock:(NSNumber*) names_only
        include_schemas:(NSNumber*) include_schemas
        completionHandler: (void (^)(SWGComponentList* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(names_only != nil)
        queryParams[@"names_only"] = names_only;
    if(include_schemas != nil)
        queryParams[@"include_schemas"] = include_schemas;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(names_only == nil) {
        // error
    }
    if(include_schemas == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGComponentList alloc]initWithValues: data], nil);}];
    

}

-(void) getAccessComponentsWithCompletionBlock:(NSNumber*) as_access_components
        completionHandler: (void (^)(SWGComponentList* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(as_access_components != nil)
        queryParams[@"as_access_components"] = as_access_components;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(as_access_components == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGComponentList alloc]initWithValues: data], nil);}];
    

}

-(void) getRecordsByFilterWithCompletionBlock:(NSString*) table_name
        filter:(NSString*) filter
        limit:(NSNumber*) limit
        offset:(NSNumber*) offset
        order:(NSString*) order
        fields:(NSString*) fields
        include_count:(NSNumber*) include_count
        include_schema:(NSNumber*) include_schema
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(limit != nil)
        queryParams[@"limit"] = limit;
    if(offset != nil)
        queryParams[@"offset"] = offset;
    if(order != nil)
        queryParams[@"order"] = order;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(include_count != nil)
        queryParams[@"include_count"] = include_count;
    if(include_schema != nil)
        queryParams[@"include_schema"] = include_schema;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getRecordsByIdsWithCompletionBlock:(NSString*) table_name
        ids:(NSString*) ids
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(table_name == nil) {
        // error
    }
    if(ids == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getRecordsByPostWithCompletionBlock:(NSString*) table_name
        body:(SWGGetRecordsRequest*) body
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    if(X_HTTP_METHOD != nil)
        headerParams[@"X-HTTP-METHOD"] = X_HTTP_METHOD;
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    if(X_HTTP_METHOD == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getRecordsWithCompletionBlock:(NSString*) table_name
        ids:(NSString*) ids
        filter:(NSString*) filter
        limit:(NSNumber*) limit
        offset:(NSNumber*) offset
        order:(NSString*) order
        fields:(NSString*) fields
        include_count:(NSNumber*) include_count
        include_schema:(NSNumber*) include_schema
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(limit != nil)
        queryParams[@"limit"] = limit;
    if(offset != nil)
        queryParams[@"offset"] = offset;
    if(order != nil)
        queryParams[@"order"] = order;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(include_count != nil)
        queryParams[@"include_count"] = include_count;
    if(include_schema != nil)
        queryParams[@"include_schema"] = include_schema;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) createRecordsWithCompletionBlock:(NSString*) table_name
        body:(SWGRecordsRequest*) body
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        rollback:(NSNumber*) rollback
        X_HTTP_METHOD:(NSString*) X_HTTP_METHOD
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    if(X_HTTP_METHOD != nil)
        headerParams[@"X-HTTP-METHOD"] = X_HTTP_METHOD;
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) replaceRecordsByIdsWithCompletionBlock:(NSString*) table_name
        body:(SWGIdsRecordRequest*) body
        ids:(NSString*) ids
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        rollback:(NSNumber*) rollback
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) replaceRecordsByFilterWithCompletionBlock:(NSString*) table_name
        body:(SWGFilterRecordRequest*) body
        filter:(NSString*) filter
        fields:(NSString*) fields
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) replaceRecordsWithCompletionBlock:(NSString*) table_name
        body:(SWGRecordsRequest*) body
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        rollback:(NSNumber*) rollback
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) updateRecordsByIdsWithCompletionBlock:(NSString*) table_name
        body:(SWGIdsRecordRequest*) body
        ids:(NSString*) ids
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        rollback:(NSNumber*) rollback
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) updateRecordsByFilterWithCompletionBlock:(NSString*) table_name
        body:(SWGFilterRecordRequest*) body
        filter:(NSString*) filter
        fields:(NSString*) fields
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) updateRecordsWithCompletionBlock:(NSString*) table_name
        body:(SWGRecordsRequest*) body
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        rollback:(NSNumber*) rollback
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) deleteRecordsByIdsWithCompletionBlock:(NSString*) table_name
        ids:(NSString*) ids
        body:(SWGIdsRequest*) body
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        rollback:(NSNumber*) rollback
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) deleteRecordsByFilterWithCompletionBlock:(NSString*) table_name
        filter:(NSString*) filter
        body:(SWGFilterRequest*) body
        force:(NSNumber*) force
        fields:(NSString*) fields
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(force != nil)
        queryParams[@"force"] = force;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) deleteRecordsWithCompletionBlock:(NSString*) table_name
        body:(SWGRecordsRequest*) body
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        continue:(NSNumber*) swgcontinue
        rollback:(NSNumber*) rollback
        filter:(NSString*) filter
        ids:(NSString*) ids
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordsResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordsResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getRecordWithCompletionBlock:(NSString*) table_name
        _id:(NSString*) _id
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordResponse alloc]initWithValues: data], nil);}];
    

}

-(void) createRecordWithCompletionBlock:(NSString*) table_name
        _id:(NSString*) _id
        body:(SWGRecordRequest*) body
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordResponse alloc]initWithValues: data], nil);}];
    

}

-(void) replaceRecordWithCompletionBlock:(NSString*) table_name
        _id:(NSString*) _id
        body:(SWGRecordRequest*) body
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordResponse alloc]initWithValues: data], nil);}];
    

}

-(void) updateRecordWithCompletionBlock:(NSString*) table_name
        _id:(NSString*) _id
        body:(SWGRecordRequest*) body
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordResponse alloc]initWithValues: data], nil);}];
    

}

-(void) deleteRecordWithCompletionBlock:(NSString*) table_name
        _id:(NSString*) _id
        fields:(NSString*) fields
        id_field:(NSString*) id_field
        id_type:(NSString*) id_type
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecordResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGRecordResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getSchemasWithCompletionBlock: (void (^)(SWGResources* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGResources alloc]initWithValues: data], nil);}];
    

}

-(void) createTablesWithCompletionBlock:(SWGTableSchemas*) body
        completionHandler: (void (^)(SWGResources* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGResources alloc]initWithValues: data], nil);}];
    

}

-(void) replaceTablesWithCompletionBlock:(SWGTableSchemas*) body
        completionHandler: (void (^)(SWGResources* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGResources alloc]initWithValues: data], nil);}];
    

}

-(void) updateTablesWithCompletionBlock:(SWGTableSchemas*) body
        completionHandler: (void (^)(SWGResources* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGResources alloc]initWithValues: data], nil);}];
    

}

-(void) describeTableWithCompletionBlock:(NSString*) table_name
        refresh:(NSNumber*) refresh
        completionHandler: (void (^)(SWGTableSchema* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(refresh != nil)
        queryParams[@"refresh"] = refresh;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGTableSchema alloc]initWithValues: data], nil);}];
    

}

-(void) createTableWithCompletionBlock:(NSString*) table_name
        body:(SWGTableSchema*) body
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGSuccess alloc]initWithValues: data], nil);}];
    

}

-(void) replaceTableWithCompletionBlock:(NSString*) table_name
        body:(SWGTableSchema*) body
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGSuccess alloc]initWithValues: data], nil);}];
    

}

-(void) updateTableWithCompletionBlock:(NSString*) table_name
        body:(SWGTableSchema*) body
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGSuccess alloc]initWithValues: data], nil);}];
    

}

-(void) deleteTableWithCompletionBlock:(NSString*) table_name
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGSuccess alloc]initWithValues: data], nil);}];
    

}

-(void) describeFieldWithCompletionBlock:(NSString*) table_name
        field_name:(NSString*) field_name
        refresh:(NSNumber*) refresh
        completionHandler: (void (^)(SWGFieldSchema* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}/{field_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"field_name", @"}"]] withString: [_api escapeString:field_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(refresh != nil)
        queryParams[@"refresh"] = refresh;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(table_name == nil) {
        // error
    }
    if(field_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGFieldSchema alloc]initWithValues: data], nil);}];
    

}

-(void) replaceFieldWithCompletionBlock:(NSString*) table_name
        field_name:(NSString*) field_name
        body:(SWGFieldSchema*) body
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}/{field_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"field_name", @"}"]] withString: [_api escapeString:field_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(field_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGSuccess alloc]initWithValues: data], nil);}];
    

}

-(void) updateFieldWithCompletionBlock:(NSString*) table_name
        field_name:(NSString*) field_name
        body:(SWGFieldSchema*) body
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}/{field_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"field_name", @"}"]] withString: [_api escapeString:field_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(field_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGSuccess alloc]initWithValues: data], nil);}];
    

}

-(void) deleteFieldWithCompletionBlock:(NSString*) table_name
        field_name:(NSString*) field_name
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}/{field_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"field_name", @"}"]] withString: [_api escapeString:field_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(table_name == nil) {
        // error
    }
    if(field_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGSuccess alloc]initWithValues: data], nil);}];
    

}

-(void) getStoredProcsWithCompletionBlock: (void (^)(SWGResources* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_proc", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGResources alloc]initWithValues: data], nil);}];
    

}

-(void) callStoredProcWithCompletionBlock:(NSString*) procedure_name
        wrapper:(NSString*) wrapper
        completionHandler: (void (^)(SWGStoredProcResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_proc/{procedure_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"procedure_name", @"}"]] withString: [_api escapeString:procedure_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(wrapper != nil)
        queryParams[@"wrapper"] = wrapper;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(procedure_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGStoredProcResponse alloc]initWithValues: data], nil);}];
    

}

-(void) callStoredProcWithParamsWithCompletionBlock:(NSString*) procedure_name
        body:(SWGStoredProcRequest*) body
        wrapper:(NSString*) wrapper
        completionHandler: (void (^)(SWGStoredProcResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_proc/{procedure_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"procedure_name", @"}"]] withString: [_api escapeString:procedure_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(wrapper != nil)
        queryParams[@"wrapper"] = wrapper;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else if([body isKindOfClass: [NIKFile class]]) {
        contentType = @"form-data";
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(procedure_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        completionBlock( [[SWGStoredProcResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getResourcesAsJsonWithCompletionBlock :

        completionHandler :(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) getTablesAsJsonWithCompletionBlock :(NSNumber*) names_only 
include_schemas:(NSNumber*) include_schemas 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(names_only != nil)
        queryParams[@"names_only"] = names_only;
    if(include_schemas != nil)
        queryParams[@"include_schemas"] = include_schemas;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(names_only == nil) {
        // error
    }
    if(include_schemas == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) getAccessComponentsAsJsonWithCompletionBlock :(NSNumber*) as_access_components 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(as_access_components != nil)
        queryParams[@"as_access_components"] = as_access_components;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(as_access_components == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) getRecordsByFilterAsJsonWithCompletionBlock :(NSString*) table_name 
filter:(NSString*) filter 
limit:(NSNumber*) limit 
offset:(NSNumber*) offset 
order:(NSString*) order 
fields:(NSString*) fields 
include_count:(NSNumber*) include_count 
include_schema:(NSNumber*) include_schema 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(limit != nil)
        queryParams[@"limit"] = limit;
    if(offset != nil)
        queryParams[@"offset"] = offset;
    if(order != nil)
        queryParams[@"order"] = order;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(include_count != nil)
        queryParams[@"include_count"] = include_count;
    if(include_schema != nil)
        queryParams[@"include_schema"] = include_schema;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) getRecordsByIdsAsJsonWithCompletionBlock :(NSString*) table_name 
ids:(NSString*) ids 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(table_name == nil) {
        // error
    }
    if(ids == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) getRecordsByPostAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGGetRecordsRequest*) body 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
X_HTTP_METHOD:(NSString*) X_HTTP_METHOD

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    if(X_HTTP_METHOD != nil)
        headerParams[@"X-HTTP-METHOD"] = X_HTTP_METHOD;
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    if(X_HTTP_METHOD == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) getRecordsAsJsonWithCompletionBlock :(NSString*) table_name 
ids:(NSString*) ids 
filter:(NSString*) filter 
limit:(NSNumber*) limit 
offset:(NSNumber*) offset 
order:(NSString*) order 
fields:(NSString*) fields 
include_count:(NSNumber*) include_count 
include_schema:(NSNumber*) include_schema 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(limit != nil)
        queryParams[@"limit"] = limit;
    if(offset != nil)
        queryParams[@"offset"] = offset;
    if(order != nil)
        queryParams[@"order"] = order;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(include_count != nil)
        queryParams[@"include_count"] = include_count;
    if(include_schema != nil)
        queryParams[@"include_schema"] = include_schema;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) createRecordsAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGRecordsRequest*) body 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
rollback:(NSNumber*) rollback 
X_HTTP_METHOD:(NSString*) X_HTTP_METHOD
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    if(X_HTTP_METHOD != nil)
        headerParams[@"X-HTTP-METHOD"] = X_HTTP_METHOD;
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) replaceRecordsByIdsAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGIdsRecordRequest*) body 
ids:(NSString*) ids 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
rollback:(NSNumber*) rollback 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) replaceRecordsByFilterAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGFilterRecordRequest*) body 
filter:(NSString*) filter 
fields:(NSString*) fields 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) replaceRecordsAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGRecordsRequest*) body 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
rollback:(NSNumber*) rollback 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) updateRecordsByIdsAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGIdsRecordRequest*) body 
ids:(NSString*) ids 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
rollback:(NSNumber*) rollback 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) updateRecordsByFilterAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGFilterRecordRequest*) body 
filter:(NSString*) filter 
fields:(NSString*) fields 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) updateRecordsAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGRecordsRequest*) body 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
rollback:(NSNumber*) rollback 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) deleteRecordsByIdsAsJsonWithCompletionBlock :(NSString*) table_name 
ids:(NSString*) ids 
body:(SWGIdsRequest*) body 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
rollback:(NSNumber*) rollback 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) deleteRecordsByFilterAsJsonWithCompletionBlock :(NSString*) table_name 
filter:(NSString*) filter 
body:(SWGFilterRequest*) body 
force:(NSNumber*) force 
fields:(NSString*) fields 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(force != nil)
        queryParams[@"force"] = force;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) deleteRecordsAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGRecordsRequest*) body 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
continue:(NSNumber*) swgcontinue
rollback:(NSNumber*) rollback 
filter:(NSString*) filter 
ids:(NSString*) ids 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(swgcontinue != nil)
        queryParams[@"continue"] = swgcontinue;
    if(rollback != nil)
        queryParams[@"rollback"] = rollback;
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) getRecordAsJsonWithCompletionBlock :(NSString*) table_name 
_id:(NSString*) _id 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) createRecordAsJsonWithCompletionBlock :(NSString*) table_name 
_id:(NSString*) _id 
body:(SWGRecordRequest*) body 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) replaceRecordAsJsonWithCompletionBlock :(NSString*) table_name 
_id:(NSString*) _id 
body:(SWGRecordRequest*) body 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) updateRecordAsJsonWithCompletionBlock :(NSString*) table_name 
_id:(NSString*) _id 
body:(SWGRecordRequest*) body 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) deleteRecordAsJsonWithCompletionBlock :(NSString*) table_name 
_id:(NSString*) _id 
fields:(NSString*) fields 
id_field:(NSString*) id_field 
id_type:(NSString*) id_type 
related:(NSString*) related 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(id_type != nil)
        queryParams[@"id_type"] = id_type;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(table_name == nil) {
        // error
    }
    if(_id == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) getSchemasAsJsonWithCompletionBlock :

        completionHandler :(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) createTablesAsJsonWithCompletionBlock :(SWGTableSchemas*) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) replaceTablesAsJsonWithCompletionBlock :(SWGTableSchemas*) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) updateTablesAsJsonWithCompletionBlock :(SWGTableSchemas*) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) describeTableAsJsonWithCompletionBlock :(NSString*) table_name 
refresh:(NSNumber*) refresh 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(refresh != nil)
        queryParams[@"refresh"] = refresh;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) createTableAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGTableSchema*) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) replaceTableAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGTableSchema*) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) updateTableAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGTableSchema*) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) deleteTableAsJsonWithCompletionBlock :(NSString*) table_name 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(table_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) describeFieldAsJsonWithCompletionBlock :(NSString*) table_name 
field_name:(NSString*) field_name 
refresh:(NSNumber*) refresh 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}/{field_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"field_name", @"}"]] withString: [_api escapeString:field_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(refresh != nil)
        queryParams[@"refresh"] = refresh;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(table_name == nil) {
        // error
    }
    if(field_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) replaceFieldAsJsonWithCompletionBlock :(NSString*) table_name 
field_name:(NSString*) field_name 
body:(SWGFieldSchema*) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}/{field_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"field_name", @"}"]] withString: [_api escapeString:field_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(field_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PUT" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) updateFieldAsJsonWithCompletionBlock :(NSString*) table_name 
field_name:(NSString*) field_name 
body:(SWGFieldSchema*) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}/{field_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"field_name", @"}"]] withString: [_api escapeString:field_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(table_name == nil) {
        // error
    }
    if(field_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"PATCH" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) deleteFieldAsJsonWithCompletionBlock :(NSString*) table_name 
field_name:(NSString*) field_name 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_schema/{table_name}/{field_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"field_name", @"}"]] withString: [_api escapeString:field_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(table_name == nil) {
        // error
    }
    if(field_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"DELETE" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) getStoredProcsAsJsonWithCompletionBlock :

        completionHandler :(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_proc", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) callStoredProcAsJsonWithCompletionBlock :(NSString*) procedure_name
wrapper:(NSString*) wrapper 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_proc/{procedure_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"procedure_name", @"}"]] withString: [_api escapeString:procedure_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(wrapper != nil)
        queryParams[@"wrapper"] = wrapper;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(procedure_name == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"GET" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}

-(void) callStoredProcWithParamsAsJsonWithCompletionBlock :(NSString*) procedure_name
body:(SWGStoredProcRequest*) body 
wrapper:(NSString*) wrapper 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/_proc/{procedure_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"procedure_name", @"}"]] withString: [_api escapeString:procedure_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(wrapper != nil)
        queryParams[@"wrapper"] = wrapper;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(body != nil && [body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)body) {
            if([dict respondsToSelector:@selector(asDictionary)]) {
                [objs addObject:[(NIKSwaggerObject*)dict asDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([body respondsToSelector:@selector(asDictionary)]) {
        bodyDictionary = [(NIKSwaggerObject*)body asDictionary];
    }
    else if([body isKindOfClass:[NSString class]]) {
        bodyDictionary = body;
    }
    else{
        NSLog(@"don't know what to do with %@", body);
    }

    if(procedure_name == nil) {
        // error
    }
    if(body == nil) {
        // error
    }
    [_api dictionary:requestUrl 
              method:@"POST" 
         queryParams:queryParams 
                body:bodyDictionary 
        headerParams:headerParams
         contentType:contentType
     completionBlock:^(NSDictionary *data, NSError *error) {
        if (error) {
            completionBlock(nil, error);return;
        }

        NSData * responseData = nil;
            if([data isKindOfClass:[NSDictionary class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            else if ([data isKindOfClass:[NSArray class]]){
                responseData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:kNilOptions error:&error];
            }
            NSString * json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            completionBlock(json, nil);
        

    }];


}


@end

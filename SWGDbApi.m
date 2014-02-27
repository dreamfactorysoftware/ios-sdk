#import "SWGDbApi.h"
#import "NIKFile.h"
#import "SWGRecords.h"
#import "SWGRecord.h"
#import "SWGTables.h"



@implementation SWGDbApi
static NSString * basePath = @"https://next.cloud.dreamfactory.com/rest";

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

-(void) addHeader:(NSString*) value
           forKey:(NSString*)key {
    [_api addHeader:value forKey:key];
}

-(void) getTablesWithCompletionBlock:(NSNumber*) include_properties
        names:(NSString*) names
        completionHandler: (void (^)(SWGTables* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
    if(names != nil)
        queryParams[@"names"] = names;
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

        completionBlock( [[SWGTables alloc]initWithValues: data], nil);}];
    

}

-(void) getRecordsWithCompletionBlock:(NSString*) table_name
        ids:(NSString*) ids
        filter:(NSString*) filter
        limit:(NSNumber*) limit
        offset:(NSNumber*) offset
        order:(NSString*) order
        fields:(NSString*) fields
        related:(NSString*) related
        include_count:(NSNumber*) include_count
        include_schema:(NSNumber*) include_schema
        id_field:(NSString*) id_field
        completionHandler: (void (^)(SWGRecords* output, NSError* error))completionBlock{

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
    if(related != nil)
        queryParams[@"related"] = related;
    if(include_count != nil)
        queryParams[@"include_count"] = include_count;
    if(include_schema != nil)
        queryParams[@"include_schema"] = include_schema;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
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

        completionBlock( [[SWGRecords alloc]initWithValues: data], nil);}];
    

}

-(void) createRecordsWithCompletionBlock:(NSString*) table_name
        body:(SWGRecords*) body
        id_field:(NSString*) id_field
        fields:(NSString*) fields
        related:(NSString*) related
        X-HTTP-METHOD:(NSString*) X-HTTP-METHOD
        completionHandler: (void (^)(SWGRecords* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    if(X-HTTP-METHOD != nil)
        headerParams[@"X-HTTP-METHOD"] = X-HTTP-METHOD;
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

        completionBlock( [[SWGRecords alloc]initWithValues: data], nil);}];
    

}

-(void) updateRecordsWithCompletionBlock:(NSString*) table_name
        body:(SWGRecords*) body
        ids:(NSString*) ids
        filter:(NSString*) filter
        id_field:(NSString*) id_field
        fields:(NSString*) fields
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecords* output, NSError* error))completionBlock{

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
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
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

        completionBlock( [[SWGRecords alloc]initWithValues: data], nil);}];
    

}

-(void) deleteRecordsWithCompletionBlock:(NSString*) table_name
        ids:(NSString*) ids
        filter:(NSString*) filter
        force:(NSNumber*) force
        id_field:(NSString*) id_field
        fields:(NSString*) fields
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecords* output, NSError* error))completionBlock{

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
    if(force != nil)
        queryParams[@"force"] = force;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
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

        completionBlock( [[SWGRecords alloc]initWithValues: data], nil);}];
    

}

-(void) getRecordWithCompletionBlock:(NSString*) table_name
        _id:(NSString*) _id
        id_field:(NSString*) id_field
        fields:(NSString*) fields
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecord* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(fields != nil)
        queryParams[@"fields"] = fields;
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

        completionBlock( [[SWGRecord alloc]initWithValues: data], nil);}];
    

}

-(void) createRecordWithCompletionBlock:(NSString*) table_name
        _id:(NSString*) _id
        id_field:(NSString*) id_field
        body:(SWGRecord*) body
        fields:(NSString*) fields
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecord* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
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

        completionBlock( [[SWGRecord alloc]initWithValues: data], nil);}];
    

}

-(void) updateRecordWithCompletionBlock:(NSString*) table_name
        _id:(NSString*) _id
        id_field:(NSString*) id_field
        body:(SWGRecord*) body
        fields:(NSString*) fields
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecord* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
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

        completionBlock( [[SWGRecord alloc]initWithValues: data], nil);}];
    

}

-(void) deleteRecordWithCompletionBlock:(NSString*) table_name
        _id:(NSString*) _id
        id_field:(NSString*) id_field
        fields:(NSString*) fields
        related:(NSString*) related
        completionHandler: (void (^)(SWGRecord* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}/{id}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"id", @"}"]] withString: [_api escapeString:_id]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(fields != nil)
        queryParams[@"fields"] = fields;
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

        completionBlock( [[SWGRecord alloc]initWithValues: data], nil);}];
    

}

-(void) getTablesAsJsonWithCompletionBlock :(NSNumber*) include_properties 
names:(NSString*) names 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
    if(names != nil)
        queryParams[@"names"] = names;
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

-(void) getRecordsAsJsonWithCompletionBlock :(NSString*) table_name 
ids:(NSString*) ids 
filter:(NSString*) filter 
limit:(NSNumber*) limit 
offset:(NSNumber*) offset 
order:(NSString*) order 
fields:(NSString*) fields 
related:(NSString*) related 
include_count:(NSNumber*) include_count 
include_schema:(NSNumber*) include_schema 
id_field:(NSString*) id_field 

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
    if(related != nil)
        queryParams[@"related"] = related;
    if(include_count != nil)
        queryParams[@"include_count"] = include_count;
    if(include_schema != nil)
        queryParams[@"include_schema"] = include_schema;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
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
body:(SWGRecords*) body 
id_field:(NSString*) id_field 
fields:(NSString*) fields 
related:(NSString*) related 
X-HTTP-METHOD:(NSString*) X-HTTP-METHOD 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/db/{table_name}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"table_name", @"}"]] withString: [_api escapeString:table_name]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    if(X-HTTP-METHOD != nil)
        headerParams[@"X-HTTP-METHOD"] = X-HTTP-METHOD;
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

-(void) updateRecordsAsJsonWithCompletionBlock :(NSString*) table_name 
body:(SWGRecords*) body 
ids:(NSString*) ids 
filter:(NSString*) filter 
id_field:(NSString*) id_field 
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
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
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

-(void) deleteRecordsAsJsonWithCompletionBlock :(NSString*) table_name 
ids:(NSString*) ids 
filter:(NSString*) filter 
force:(NSNumber*) force 
id_field:(NSString*) id_field 
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
    if(ids != nil)
        queryParams[@"ids"] = ids;
    if(filter != nil)
        queryParams[@"filter"] = filter;
    if(force != nil)
        queryParams[@"force"] = force;
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(fields != nil)
        queryParams[@"fields"] = fields;
    if(related != nil)
        queryParams[@"related"] = related;
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

-(void) getRecordAsJsonWithCompletionBlock :(NSString*) table_name 
_id:(NSString*) _id 
id_field:(NSString*) id_field 
fields:(NSString*) fields 
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
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(fields != nil)
        queryParams[@"fields"] = fields;
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
id_field:(NSString*) id_field 
body:(SWGRecord*) body 
fields:(NSString*) fields 
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
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
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

-(void) updateRecordAsJsonWithCompletionBlock :(NSString*) table_name 
_id:(NSString*) _id 
id_field:(NSString*) id_field 
body:(SWGRecord*) body 
fields:(NSString*) fields 
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
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
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
id_field:(NSString*) id_field 
fields:(NSString*) fields 
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
    if(id_field != nil)
        queryParams[@"id_field"] = id_field;
    if(fields != nil)
        queryParams[@"fields"] = fields;
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


@end

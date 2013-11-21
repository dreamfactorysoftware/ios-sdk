#import "RVBAppApi.h"
#import "NIKFile.h"
#import "RVBFileResponse.h"
#import "RVBContainer.h"
#import "RVBFolderRequest.h"
#import "RVBContainerRequest.h"
#import "RVBFolder.h"
#import "RVBContainersResponse.h"
#import "RVBFileRequest.h"
#import "RVBContainersRequest.h"
#import "RVBFolderResponse.h"
#import "RVBFile.h"
#import "RVBContainerResponse.h"



@implementation RVBAppApi
static NSString * basePath = @"https://next.cloud.dreamfactory.com/rest";

@synthesize queue = _queue;
@synthesize api = _api;

+(RVBAppApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {
    static RVBAppApi* singletonAPI = nil;

    if (singletonAPI == nil) {
        singletonAPI = [[RVBAppApi alloc] init];
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

-(void) getContainersWithCompletionBlock:(RVBNSNumber**) include_properties
        completionHandler: (void (^)(RVBContainersResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
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

        completionBlock( [[RVBContainersResponse alloc]initWithValues: data], nil);}];
    

}

-(void) createContainersWithCompletionBlock:(RVBRVBContainersRequest**) body
        check_exist:(RVBNSNumber**) check_exist
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD
        completionHandler: (void (^)(RVBContainersResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(check_exist != nil)
        queryParams[@"check_exist"] = check_exist;
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

        completionBlock( [[RVBContainersResponse alloc]initWithValues: data], nil);}];
    

}

-(void) deleteContainersWithCompletionBlock:(RVBNSString**) names
        force:(RVBNSNumber**) force
        completionHandler: (void (^)(RVBContainersResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(names != nil)
        queryParams[@"names"] = names;
    if(force != nil)
        queryParams[@"force"] = force;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
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

        completionBlock( [[RVBContainersResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getContainerWithCompletionBlock:(RVBNSString**) container
        include_properties:(RVBNSNumber**) include_properties
        include_folders:(RVBNSNumber**) include_folders
        include_files:(RVBNSNumber**) include_files
        full_tree:(RVBNSNumber**) full_tree
        zip:(RVBNSNumber**) zip
        completionHandler: (void (^)(RVBContainerResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
    if(include_folders != nil)
        queryParams[@"include_folders"] = include_folders;
    if(include_files != nil)
        queryParams[@"include_files"] = include_files;
    if(full_tree != nil)
        queryParams[@"full_tree"] = full_tree;
    if(zip != nil)
        queryParams[@"zip"] = zip;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(container == nil) {
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

        completionBlock( [[RVBContainerResponse alloc]initWithValues: data], nil);}];
    

}

-(void) createContainerWithCompletionBlock:(RVBNSString**) container
        body:(RVBRVBContainerRequest**) body
        url:(RVBNSString**) url
        extract:(RVBNSNumber**) extract
        clean:(RVBNSNumber**) clean
        check_exist:(RVBNSNumber**) check_exist
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD
        completionHandler: (void (^)(RVBContainerResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(url != nil)
        queryParams[@"url"] = url;
    if(extract != nil)
        queryParams[@"extract"] = extract;
    if(clean != nil)
        queryParams[@"clean"] = clean;
    if(check_exist != nil)
        queryParams[@"check_exist"] = check_exist;
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

    if(container == nil) {
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

        completionBlock( [[RVBContainerResponse alloc]initWithValues: data], nil);}];
    

}

-(void) updateContainerPropertiesWithCompletionBlock:(RVBNSString**) container
        body:(RVBRVBContainer**) body
        completionHandler: (void (^)(RVBContainer* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
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

    if(container == nil) {
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

        completionBlock( [[RVBContainer alloc]initWithValues: data], nil);}];
    

}

-(void) deleteContainerWithCompletionBlock:(RVBNSString**) container
        force:(RVBNSNumber**) force
        content_only:(RVBNSNumber**) content_only
        completionHandler: (void (^)(RVBContainerResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(force != nil)
        queryParams[@"force"] = force;
    if(content_only != nil)
        queryParams[@"content_only"] = content_only;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(container == nil) {
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

        completionBlock( [[RVBContainerResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getFolderWithCompletionBlock:(RVBNSString**) container
        folder_path:(RVBNSString**) folder_path
        include_properties:(RVBNSNumber**) include_properties
        include_folders:(RVBNSNumber**) include_folders
        include_files:(RVBNSNumber**) include_files
        full_tree:(RVBNSNumber**) full_tree
        zip:(RVBNSNumber**) zip
        completionHandler: (void (^)(RVBFolderResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{folder_path}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"folder_path", @"}"]] withString: [_api escapeString:folder_path]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
    if(include_folders != nil)
        queryParams[@"include_folders"] = include_folders;
    if(include_files != nil)
        queryParams[@"include_files"] = include_files;
    if(full_tree != nil)
        queryParams[@"full_tree"] = full_tree;
    if(zip != nil)
        queryParams[@"zip"] = zip;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(container == nil) {
        // error
    }
    if(folder_path == nil) {
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

        completionBlock( [[RVBFolderResponse alloc]initWithValues: data], nil);}];
    

}

-(void) createFolderWithCompletionBlock:(RVBNSString**) container
        folder_path:(RVBNSString**) folder_path
        body:(RVBRVBFolderRequest**) body
        url:(RVBNSString**) url
        extract:(RVBNSNumber**) extract
        clean:(RVBNSNumber**) clean
        check_exist:(RVBNSNumber**) check_exist
        X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD
        completionHandler: (void (^)(RVBFolderResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{folder_path}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"folder_path", @"}"]] withString: [_api escapeString:folder_path]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(url != nil)
        queryParams[@"url"] = url;
    if(extract != nil)
        queryParams[@"extract"] = extract;
    if(clean != nil)
        queryParams[@"clean"] = clean;
    if(check_exist != nil)
        queryParams[@"check_exist"] = check_exist;
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

    if(container == nil) {
        // error
    }
    if(folder_path == nil) {
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

        completionBlock( [[RVBFolderResponse alloc]initWithValues: data], nil);}];
    

}

-(void) updateFolderPropertiesWithCompletionBlock:(RVBNSString**) container
        folder_path:(RVBNSString**) folder_path
        body:(RVBRVBFolder**) body
        completionHandler: (void (^)(RVBFolder* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{folder_path}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"folder_path", @"}"]] withString: [_api escapeString:folder_path]];
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

    if(container == nil) {
        // error
    }
    if(folder_path == nil) {
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

        completionBlock( [[RVBFolder alloc]initWithValues: data], nil);}];
    

}

-(void) deleteFolderWithCompletionBlock:(RVBNSString**) container
        folder_path:(RVBNSString**) folder_path
        force:(RVBNSNumber**) force
        content_only:(RVBNSNumber**) content_only
        completionHandler: (void (^)(RVBFolderResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{folder_path}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"folder_path", @"}"]] withString: [_api escapeString:folder_path]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(force != nil)
        queryParams[@"force"] = force;
    if(content_only != nil)
        queryParams[@"content_only"] = content_only;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(container == nil) {
        // error
    }
    if(folder_path == nil) {
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

        completionBlock( [[RVBFolderResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getFileWithCompletionBlock:(RVBNSString**) container
        file_path:(RVBNSString**) file_path
        include_properties:(RVBNSNumber**) include_properties
        content:(RVBNSNumber**) content
        download:(RVBNSNumber**) download
        completionHandler: (void (^)(RVBFileResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
    if(content != nil)
        queryParams[@"content"] = content;
    if(download != nil)
        queryParams[@"download"] = download;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

        completionBlock( [[RVBFileResponse alloc]initWithValues: data], nil);}];
    

}

-(void) createFileWithCompletionBlock:(RVBNSString**) container
        file_path:(RVBNSString**) file_path
        check_exist:(RVBNSNumber**) check_exist
        body:(RVBRVBFileRequest**) body
        completionHandler: (void (^)(RVBFileResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(check_exist != nil)
        queryParams[@"check_exist"] = check_exist;
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

    if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

        completionBlock( [[RVBFileResponse alloc]initWithValues: data], nil);}];
    

}

-(void) replaceFileWithCompletionBlock:(RVBNSString**) container
        file_path:(RVBNSString**) file_path
        body:(RVBRVBFileRequest**) body
        completionHandler: (void (^)(RVBFileResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
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

    if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

        completionBlock( [[RVBFileResponse alloc]initWithValues: data], nil);}];
    

}

-(void) updateFilePropertiesWithCompletionBlock:(RVBNSString**) container
        file_path:(RVBNSString**) file_path
        body:(RVBRVBFile**) body
        completionHandler: (void (^)(RVBFile* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
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

    if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

        completionBlock( [[RVBFile alloc]initWithValues: data], nil);}];
    

}

-(void) deleteFileWithCompletionBlock:(RVBNSString**) container
        file_path:(RVBNSString**) file_path
        completionHandler: (void (^)(RVBFileResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
        if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

        completionBlock( [[RVBFileResponse alloc]initWithValues: data], nil);}];
    

}

-(void) getContainersAsJsonWithCompletionBlock :(RVBNSNumber**) include_properties 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
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

-(void) createContainersAsJsonWithCompletionBlock :(RVBRVBContainersRequest**) body 
check_exist:(RVBNSNumber**) check_exist 
X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(check_exist != nil)
        queryParams[@"check_exist"] = check_exist;
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

-(void) deleteContainersAsJsonWithCompletionBlock :(RVBNSString**) names 
force:(RVBNSNumber**) force 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(names != nil)
        queryParams[@"names"] = names;
    if(force != nil)
        queryParams[@"force"] = force;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
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

-(void) getContainerAsJsonWithCompletionBlock :(RVBNSString**) container 
include_properties:(RVBNSNumber**) include_properties 
include_folders:(RVBNSNumber**) include_folders 
include_files:(RVBNSNumber**) include_files 
full_tree:(RVBNSNumber**) full_tree 
zip:(RVBNSNumber**) zip 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
    if(include_folders != nil)
        queryParams[@"include_folders"] = include_folders;
    if(include_files != nil)
        queryParams[@"include_files"] = include_files;
    if(full_tree != nil)
        queryParams[@"full_tree"] = full_tree;
    if(zip != nil)
        queryParams[@"zip"] = zip;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(container == nil) {
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

-(void) createContainerAsJsonWithCompletionBlock :(RVBNSString**) container 
body:(RVBRVBContainerRequest**) body 
url:(RVBNSString**) url 
extract:(RVBNSNumber**) extract 
clean:(RVBNSNumber**) clean 
check_exist:(RVBNSNumber**) check_exist 
X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(url != nil)
        queryParams[@"url"] = url;
    if(extract != nil)
        queryParams[@"extract"] = extract;
    if(clean != nil)
        queryParams[@"clean"] = clean;
    if(check_exist != nil)
        queryParams[@"check_exist"] = check_exist;
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

    if(container == nil) {
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

-(void) updateContainerPropertiesAsJsonWithCompletionBlock :(RVBNSString**) container 
body:(RVBRVBContainer**) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
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

    if(container == nil) {
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

-(void) deleteContainerAsJsonWithCompletionBlock :(RVBNSString**) container 
force:(RVBNSNumber**) force 
content_only:(RVBNSNumber**) content_only 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(force != nil)
        queryParams[@"force"] = force;
    if(content_only != nil)
        queryParams[@"content_only"] = content_only;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(container == nil) {
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

-(void) getFolderAsJsonWithCompletionBlock :(RVBNSString**) container 
folder_path:(RVBNSString**) folder_path 
include_properties:(RVBNSNumber**) include_properties 
include_folders:(RVBNSNumber**) include_folders 
include_files:(RVBNSNumber**) include_files 
full_tree:(RVBNSNumber**) full_tree 
zip:(RVBNSNumber**) zip 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{folder_path}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"folder_path", @"}"]] withString: [_api escapeString:folder_path]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
    if(include_folders != nil)
        queryParams[@"include_folders"] = include_folders;
    if(include_files != nil)
        queryParams[@"include_files"] = include_files;
    if(full_tree != nil)
        queryParams[@"full_tree"] = full_tree;
    if(zip != nil)
        queryParams[@"zip"] = zip;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(container == nil) {
        // error
    }
    if(folder_path == nil) {
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

-(void) createFolderAsJsonWithCompletionBlock :(RVBNSString**) container 
folder_path:(RVBNSString**) folder_path 
body:(RVBRVBFolderRequest**) body 
url:(RVBNSString**) url 
extract:(RVBNSNumber**) extract 
clean:(RVBNSNumber**) clean 
check_exist:(RVBNSNumber**) check_exist 
X-HTTP-METHOD:(RVBNSString**) X-HTTP-METHOD 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{folder_path}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"folder_path", @"}"]] withString: [_api escapeString:folder_path]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(url != nil)
        queryParams[@"url"] = url;
    if(extract != nil)
        queryParams[@"extract"] = extract;
    if(clean != nil)
        queryParams[@"clean"] = clean;
    if(check_exist != nil)
        queryParams[@"check_exist"] = check_exist;
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

    if(container == nil) {
        // error
    }
    if(folder_path == nil) {
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

-(void) updateFolderPropertiesAsJsonWithCompletionBlock :(RVBNSString**) container 
folder_path:(RVBNSString**) folder_path 
body:(RVBRVBFolder**) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{folder_path}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"folder_path", @"}"]] withString: [_api escapeString:folder_path]];
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

    if(container == nil) {
        // error
    }
    if(folder_path == nil) {
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

-(void) deleteFolderAsJsonWithCompletionBlock :(RVBNSString**) container 
folder_path:(RVBNSString**) folder_path 
force:(RVBNSNumber**) force 
content_only:(RVBNSNumber**) content_only 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{folder_path}/", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"folder_path", @"}"]] withString: [_api escapeString:folder_path]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(force != nil)
        queryParams[@"force"] = force;
    if(content_only != nil)
        queryParams[@"content_only"] = content_only;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(container == nil) {
        // error
    }
    if(folder_path == nil) {
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

-(void) getFileAsJsonWithCompletionBlock :(RVBNSString**) container 
file_path:(RVBNSString**) file_path 
include_properties:(RVBNSNumber**) include_properties 
content:(RVBNSNumber**) content 
download:(RVBNSNumber**) download 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(include_properties != nil)
        queryParams[@"include_properties"] = include_properties;
    if(content != nil)
        queryParams[@"content"] = content;
    if(download != nil)
        queryParams[@"download"] = download;
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

-(void) createFileAsJsonWithCompletionBlock :(RVBNSString**) container 
file_path:(RVBNSString**) file_path 
check_exist:(RVBNSNumber**) check_exist 
body:(RVBRVBFileRequest**) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(check_exist != nil)
        queryParams[@"check_exist"] = check_exist;
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

    if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

-(void) replaceFileAsJsonWithCompletionBlock :(RVBNSString**) container 
file_path:(RVBNSString**) file_path 
body:(RVBRVBFileRequest**) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
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

    if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

-(void) updateFilePropertiesAsJsonWithCompletionBlock :(RVBNSString**) container 
file_path:(RVBNSString**) file_path 
body:(RVBRVBFile**) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
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

    if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

-(void) deleteFileAsJsonWithCompletionBlock :(RVBNSString**) container 
file_path:(RVBNSString**) file_path 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/app/{container}/{file_path}", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"container", @"}"]] withString: [_api escapeString:container]];
    [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", @"file_path", @"}"]] withString: [_api escapeString:file_path]];
    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* headerParams = [[NSMutableDictionary alloc] init];
    id bodyDictionary = nil;
    if(container == nil) {
        // error
    }
    if(file_path == nil) {
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

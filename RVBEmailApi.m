#import "RVBEmailApi.h"
#import "NIKFile.h"
#import "RVBEmailRequest.h"
#import "RVBEmailResponse.h"



@implementation RVBEmailApi
static NSString * basePath = @"https://next.cloud.dreamfactory.com/rest";

@synthesize queue = _queue;
@synthesize api = _api;

+(RVBEmailApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {
    static RVBEmailApi* singletonAPI = nil;

    if (singletonAPI == nil) {
        singletonAPI = [[RVBEmailApi alloc] init];
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

-(void) sendEmailWithCompletionBlock:(RVBNSString**) template
        template_id:(RVBNSNumber**) template_id
        body:(RVBRVBEmailRequest**) body
        completionHandler: (void (^)(RVBEmailResponse* output, NSError* error))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/email", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    NSString* contentType = @"application/json";


        NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(template != nil)
        queryParams[@"template"] = template;
    if(template_id != nil)
        queryParams[@"template_id"] = template_id;
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

        completionBlock( [[RVBEmailResponse alloc]initWithValues: data], nil);}];
    

}

-(void) sendEmailAsJsonWithCompletionBlock :(RVBNSString**) template 
template_id:(RVBNSNumber**) template_id 
body:(RVBRVBEmailRequest**) body 

        completionHandler:(void (^)(NSString*, NSError *))completionBlock{

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/email", basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@""];

    NSString* contentType = @"application/json";

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(template != nil)
        queryParams[@"template"] = template;
    if(template_id != nil)
        queryParams[@"template_id"] = template_id;
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

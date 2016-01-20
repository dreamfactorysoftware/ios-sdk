#import "NIKApiInvoker.h"
#import <UIKit/UIKit.h>
#import "NIKFile.h"

@implementation NIKApiInvoker

@synthesize queue = _queue;

static NSInteger __LoadingObjectsCount = 0;

+ (NIKApiInvoker*)sharedInstance {
    static NIKApiInvoker *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)updateLoadCountWithDelta:(NSInteger)countDelta {
    @synchronized(self) {
        __LoadingObjectsCount += countDelta;
        __LoadingObjectsCount = (__LoadingObjectsCount < 0) ? 0 : __LoadingObjectsCount ;
        
#if TARGET_OS_IPHONE
        [UIApplication sharedApplication].networkActivityIndicatorVisible = __LoadingObjectsCount > 0;
#endif
    }
}

- (void)startLoad {
    [self updateLoadCountWithDelta:1];
}

- (void)stopLoad {
    [self updateLoadCountWithDelta:-1];
}


- (id) init {
    self = [super init];
    _queue = [[NSOperationQueue alloc] init];
    _cachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    return self;
}

-(void) restPath: (NSString*) path
          method: (NSString*) method
     queryParams: (NSDictionary*) queryParams
            body: (id) body
    headerParams: (NSDictionary*) headerParams
     contentType: (NSString*) contentType
 completionBlock: (void (^)(NSDictionary*, NSError *))completionBlock
{
    NSURLRequest* request = [NIKRequestBuilder restPath:path
                                                 method:method
                                            queryParams:queryParams
                                                   body:body
                                           headerParams:headerParams
                                            contentType:contentType];
    
    /*******************************************************************
     *
     *  NOTE: apple added App Transport Security in iOS 9.0+ to improve
     *          security. As of this writing (7/15) all plain text http
     *          connections fail by default. For more info about App
     *          Transport Security and how to handle this issue here:
     *          https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/index.html
     *
     *******************************************************************/
    
    // Handle caching on GET requests
    if ((_cachePolicy == NSURLRequestReturnCacheDataElseLoad || _cachePolicy == NSURLRequestReturnCacheDataDontLoad) && [method isEqualToString:@"GET"]) {
        NSCachedURLResponse *cacheResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
        NSData *data = [cacheResponse data];
        if (data) {
            NSError *error = nil;
            NSDictionary* results = [NSJSONSerialization
                                     JSONObjectWithData:data
                                     options:kNilOptions
                                     error:&error];
            completionBlock(results, nil);
        }
    }
    
    if (_cachePolicy == NSURLRequestReturnCacheDataDontLoad){
        return;
    }
    [self startLoad]; // for network activity indicator
    
    NSDate *date = [NSDate date];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:self.queue
                           completionHandler:
     ^(NSURLResponse *response, NSData *response_data, NSError *response_error) {
         [self stopLoad];
         long statusCode = [(NSHTTPURLResponse*)response statusCode];
         if (response_error) {
             if (response_data) {
                 NSDictionary* results = [NSJSONSerialization
                                          JSONObjectWithData:response_data
                                          options:kNilOptions
                                          error:nil];
                 if (results != nil) {
                     completionBlock(nil, [NSError errorWithDomain:response_error.domain code:response_error.code userInfo:results]);
                 } else {
                     completionBlock(nil, response_error);
                 }
             } else {
                 completionBlock(nil, response_error);
             }
             return;
         }
         else if (!NSLocationInRange(statusCode, NSMakeRange(200, 99))){
             response_error = [NSError errorWithDomain:@"swagger"
                                                  code:statusCode
                                              userInfo:[NSJSONSerialization JSONObjectWithData:response_data
                                                                                       options:kNilOptions
                                                                                         error:&response_error]];
             
             completionBlock(nil, response_error);
             return;
         }
         else {
             NSDictionary* results = [NSJSONSerialization
                                      JSONObjectWithData:response_data
                                      options:kNilOptions
                                      error:&response_error];
             
             if ([[NSUserDefaults standardUserDefaults] boolForKey:@"RVBLogging"]) {
                 NSLog(@"fetched results (%f seconds): %@", [[NSDate date] timeIntervalSinceDate:date], results);
             }
             completionBlock(results, nil);
         }
     }];
}
@end

@implementation NIKRequestBuilder

+ (NSURLRequest *) restPath:(NSString *)path
                     method:(NSString *)method
                queryParams:(NSDictionary *)queryParams
                       body:(id)body
               headerParams:(NSDictionary *)headerParams
                contentType:(NSString *)contentType
{
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    @autoreleasepool {
        NSMutableString * requestUrl = [NSMutableString stringWithFormat:@"%@", path];
        NSString * separator = nil;
        int counter = 0;
        if(queryParams != nil){
            // build the query params into the URL
            // ie @"filter" = "id=5" becomes "<url>?filter=id=5
            for(NSString * key in [queryParams keyEnumerator]){
                @autoreleasepool {
                    if(counter == 0) separator = @"?";
                    else separator = @"&";
                    NSString * value;
                    if([[queryParams valueForKey:key] isKindOfClass:[NSString class]]){
                        value = [NIKRequestBuilder escapeString:[queryParams valueForKey:key]];
                    }
                    else {
                        value = [NSString stringWithFormat:@"%@", [queryParams valueForKey:key]];
                    }
                    [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                                              [self escapeString:key], value]];
                    counter += 1;
                }
            }
        }
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"RVBLogging"]) {
            NSLog(@"request url: %@", requestUrl);
        }
        
        NSURL* URL = [NSURL URLWithString:requestUrl];
        [request setURL:URL];
        // The cache settings get set by the ApiInvoker
        [request setTimeoutInterval:30];
        
        if(headerParams != nil){
            for(NSString * key in [headerParams keyEnumerator]){
                @autoreleasepool {
                    [request setValue:[headerParams valueForKey:key] forHTTPHeaderField:key];
                }
            }
        }
        
        [request setHTTPMethod:method];
        if(body != nil) {
            // build the body into JSON
            NSError* __autoreleasing error = nil;
            NSData * data = nil;
            if([body isKindOfClass:[NSDictionary class]]){
                data = [NSJSONSerialization dataWithJSONObject:body
                                                       options:kNilOptions error:&error];
            }
            else if ([body isKindOfClass:[NIKFile class]]){
                NIKFile * file = (NIKFile*) body;
                data = file.data;
            }
            else if ([body isKindOfClass:[NSArray class]]){
                data = [NSJSONSerialization dataWithJSONObject:body
                                                       options:kNilOptions error:&error];
            }
            else {
                data = [body dataUsingEncoding:NSUTF8StringEncoding];
            }
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:data];
            
            [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        }
    }
    return request;
}

+ (NSString*) escapeString:(NSString *)unescaped {
    // bridge CF obj to get ARC and release to cancel retain from create
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef) unescaped,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
}
@end
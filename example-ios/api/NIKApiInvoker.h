#import <Foundation/Foundation.h>


@interface NIKApiInvoker : NSObject {
    
@private
    NSOperationQueue *_queue;
}

@property(nonatomic, readonly) NSOperationQueue* queue;
@property(nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

/*
 * get the shared singleton
 */
+ (NIKApiInvoker*)sharedInstance;

/*
 * primary way to access and use the API
 * builds and sends an async NSUrl request
 *
 *  @param path url to service, general form is <base instance url>/api/v2/<service>/<path>
 *  @param method http verb
 *  @param querryParams varies by call, can be put into path instead of here
 *  @param body request body, varies by call
 *  @param headerParams user should pass in the app api key and a session token
 *  @param contentType json or xml
 *  @param completionBlock block to be executed once call is done
 */
-(void) restPath: (NSString*) path
          method: (NSString*) method
     queryParams: (NSDictionary*) queryParams
            body: (id)body
    headerParams: (NSDictionary*) headerParams
     contentType: (NSString*) contentType
 completionBlock: (void (^)(NSDictionary*, NSError *))completionBlock;

@end

@interface NIKRequestBuilder : NSObject
/*
 * Builds NSURLRequests with the format for the DreamFactory Rest API
 *
 * This will play nice if you want to roll your own set up or use a
 * third party library like AFNetworking to send the REST requests
 *
 *  @param path url to service, general form is <base instance url>/api/v2/<service>/<path>
 *  @param method http verb
 *  @param querryParams varies by call, can be put into path instead of here
 *  @param body request body, varies by call
 *  @param headerParams user should pass in the app api key and a session token
 *  @param contentType json or xml
 *  @param completionBlock block to be executed once call is done
 */
+ (NSURLRequest*) restPath: (NSString*) path
                    method: (NSString*) method
               queryParams: (NSDictionary*) queryParams
                      body: (id)body
              headerParams: (NSDictionary*) headerParams
               contentType: (NSString*) contentType;

/*
 * Formats a string to be escaped. Used to put query params into the
 * request url
 */
+ (NSString*) escapeString:(NSString *)unescaped;
@end
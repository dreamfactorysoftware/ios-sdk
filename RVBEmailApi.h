#import <Foundation/Foundation.h>
#import "NIKApiInvoker.h"
#import "RVBEmailRequest.h"
#import "RVBEmailResponse.h"


@interface RVBEmailApi: NSObject {

@private
    NSOperationQueue *_queue;
    NIKApiInvoker * _api;
}
@property(nonatomic, readonly) NSOperationQueue* queue;
@property(nonatomic, readonly) NIKApiInvoker* api;

-(void) addHeader:(NSString*)value forKey:(NSString*)key;

/**

 sendEmail() - Send an email created from posted data and/or a template.
 If a template is not used with all required fields, then they must be included in the request. If the 'from' address is not provisioned in the service, then it must be included in the request.
 @param template Optional template name to base email on.
 @param template_id Optional template id to base email on.
 @param body Data containing name-value pairs used for provisioning emails.
 */
-(void) sendEmailWithCompletionBlock :(RVBNSString**) template 
        template_id:(RVBNSNumber**) template_id 
        body:(RVBRVBEmailRequest**) body 
        completionHandler: (void (^)(RVBEmailResponse* output, NSError* error))completionBlock;

@end

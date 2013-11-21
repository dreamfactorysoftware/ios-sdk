#import <Foundation/Foundation.h>
#import "NIKApiInvoker.h"
#import "RVBRegister.h"
#import "RVBCustomSettings.h"
#import "RVBLogin.h"
#import "RVBPasswordResponse.h"
#import "RVBProfileResponse.h"
#import "RVBSession.h"
#import "RVBCustomSetting.h"
#import "RVBPasswordRequest.h"
#import "RVBResources.h"
#import "RVBSuccess.h"
#import "RVBProfileRequest.h"


@interface RVBUserApi: NSObject {

@private
    NSOperationQueue *_queue;
    NIKApiInvoker * _api;
}
@property(nonatomic, readonly) NSOperationQueue* queue;
@property(nonatomic, readonly) NIKApiInvoker* api;

-(void) addHeader:(NSString*)value forKey:(NSString*)key;

/**

 getResources() - List resources available for user session management.
 See listed operations for each resource available.
 */
-(void) getResourcesWithCompletionBlock :(void (^)(RVBResources* output, NSError* error))completionBlock;

/**

 getCustomSettings() - Retrieve all custom user settings.
 Returns an object containing name-value pairs for custom user settings
 */
-(void) getCustomSettingsWithCompletionBlock :(void (^)(RVBCustomSettings* output, NSError* error))completionBlock;

/**

 setCustomSettings() - Set or update one or more custom user settings.
 A valid session is required to edit settings. Post body should be an array of name-value pairs.
 @param body Data containing name-value pairs of desired settings.
 */
-(void) setCustomSettingsWithCompletionBlock :(RVBRVBCustomSettings**) body 
        completionHandler: (void (^)(RVBSuccess* output, NSError* error))completionBlock;

/**

 getCustomSetting() - Retrieve one custom user setting.
 Setting will be returned as an object containing name-value pair. A value of null is returned for settings that are not found.
 @param setting Name of the setting to retrieve.
 */
-(void) getCustomSettingWithCompletionBlock :(RVBNSString**) setting 
        completionHandler: (void (^)(RVBCustomSetting* output, NSError* error))completionBlock;

/**

 deleteCustomSetting() - Delete one custom setting.
 A valid session is required to delete settings.
 @param setting Name of the setting to delete.
 */
-(void) deleteCustomSettingWithCompletionBlock :(RVBNSString**) setting 
        completionHandler: (void (^)(RVBSuccess* output, NSError* error))completionBlock;

/**

 changePassword() - Change or reset the current user's password.
 A valid current session along with old and new password are required to change the password directly posting 'old_password' and 'new_password'. <br/>To request password reset, post 'email' and set 'reset' to true. <br/>To reset the password from an email confirmation, post 'email', 'code', and 'new_password'. <br/>To reset the password from a security question, post 'email', 'security_answer', and 'new_password'.
 @param reset Set to true to perform password reset.
 @param body Data containing name-value pairs for password change.
 */
-(void) changePasswordWithCompletionBlock :(RVBNSNumber**) reset 
        body:(RVBRVBPasswordRequest**) body 
        completionHandler: (void (^)(RVBPasswordResponse* output, NSError* error))completionBlock;

/**

 getProfile() - Retrieve the current user's profile information.
 A valid current session is required to use this API. This profile, along with password, is the only things that the user can directly change.
 */
-(void) getProfileWithCompletionBlock :(void (^)(RVBProfileResponse* output, NSError* error))completionBlock;

/**

 updateProfile() - Update the current user's profile information.
 Update the display name, phone, etc., as well as, security question and answer.
 @param body Data containing name-value pairs for the user profile.
 */
-(void) updateProfileWithCompletionBlock :(RVBRVBProfileRequest**) body 
        completionHandler: (void (^)(RVBSuccess* output, NSError* error))completionBlock;

/**

 register() - Register a new user in the system.
 The new user is created and, if required, sent an email for confirmation. This also handles the registration confirmation by posting email, confirmation code and new password.
 @param body Data containing name-value pairs for new user registration.
 */
-(void) registerWithCompletionBlock :(RVBRVBRegister**) body 
        completionHandler: (void (^)(RVBSuccess* output, NSError* error))completionBlock;

/**

 getSession() - Retrieve the current user session information.
 Calling this refreshes the current session, or returns an error for timed-out or invalid sessions.
 */
-(void) getSessionWithCompletionBlock :(void (^)(RVBSession* output, NSError* error))completionBlock;

/**

 login() - Login and create a new user session.
 Calling this creates a new session and logs in the user.
 @param body Data containing name-value pairs used for logging into the system.
 */
-(void) loginWithCompletionBlock :(RVBRVBLogin**) body 
        completionHandler: (void (^)(RVBSession* output, NSError* error))completionBlock;

/**

 logout() - Logout and destroy the current user session.
 Calling this deletes the current session and logs out the user.
 */
-(void) logoutWithCompletionBlock :(void (^)(RVBSuccess* output, NSError* error))completionBlock;

@end

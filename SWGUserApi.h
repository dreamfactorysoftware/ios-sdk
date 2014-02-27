#import <Foundation/Foundation.h>
#import "NIKApiInvoker.h"
#import "SWGRegister.h"
#import "SWGCustomSettings.h"
#import "SWGLogin.h"
#import "SWGPasswordResponse.h"
#import "SWGProfileResponse.h"
#import "SWGSession.h"
#import "SWGCustomSetting.h"
#import "SWGDeviceRequest.h"
#import "SWGPasswordRequest.h"
#import "SWGResources.h"
#import "SWGSuccess.h"
#import "SWGProfileRequest.h"
#import "SWGDevicesResponse.h"


@interface SWGUserApi: NSObject {

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
-(void) getResourcesWithCompletionBlock :(void (^)(SWGResources* output, NSError* error))completionBlock;

/**

 getCustomSettings() - Retrieve all custom user settings.
 Returns an object containing name-value pairs for custom user settings
 */
-(void) getCustomSettingsWithCompletionBlock :(void (^)(SWGCustomSettings* output, NSError* error))completionBlock;

/**

 setCustomSettings() - Set or update one or more custom user settings.
 A valid session is required to edit settings. Post body should be an array of name-value pairs.
 @param body Data containing name-value pairs of desired settings.
 */
-(void) setCustomSettingsWithCompletionBlock :(SWGCustomSettings*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 getCustomSetting() - Retrieve one custom user setting.
 Setting will be returned as an object containing name-value pair. A value of null is returned for settings that are not found.
 @param setting Name of the setting to retrieve.
 */
-(void) getCustomSettingWithCompletionBlock :(NSString*) setting 
        completionHandler: (void (^)(SWGCustomSetting* output, NSError* error))completionBlock;

/**

 deleteCustomSetting() - Delete one custom setting.
 A valid session is required to delete settings.
 @param setting Name of the setting to delete.
 */
-(void) deleteCustomSettingWithCompletionBlock :(NSString*) setting 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 getDevices() - Retrieve the current user's device information.
 A valid current session is required to use this API.
 */
-(void) getDevicesWithCompletionBlock :(void (^)(SWGDevicesResponse* output, NSError* error))completionBlock;

/**

 setDevice() - Create a record of the current user's device information.
 Record the device information for this session. This method is idempotent and will only create one entry per uuid.
 @param body Data containing name-value pairs for the user device.
 */
-(void) setDeviceWithCompletionBlock :(SWGDeviceRequest*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 changePassword() - Change or reset the current user's password.
 A valid current session along with old and new password are required to change the password directly posting 'old_password' and 'new_password'. <br/>To request password reset, post 'email' and set 'reset' to true. <br/>To reset the password from an email confirmation, post 'email', 'code', and 'new_password'. <br/>To reset the password from a security question, post 'email', 'security_answer', and 'new_password'.
 @param reset Set to true to perform password reset.
 @param body Data containing name-value pairs for password change.
 */
-(void) changePasswordWithCompletionBlock :(NSNumber*) reset 
        body:(SWGPasswordRequest*) body 
        completionHandler: (void (^)(SWGPasswordResponse* output, NSError* error))completionBlock;

/**

 getProfile() - Retrieve the current user's profile information.
 A valid current session is required to use this API. This profile, along with password, is the only things that the user can directly change.
 */
-(void) getProfileWithCompletionBlock :(void (^)(SWGProfileResponse* output, NSError* error))completionBlock;

/**

 updateProfile() - Update the current user's profile information.
 Update the display name, phone, etc., as well as, security question and answer.
 @param body Data containing name-value pairs for the user profile.
 */
-(void) updateProfileWithCompletionBlock :(SWGProfileRequest*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 register() - Register a new user in the system.
 The new user is created and, if required, sent an email for confirmation. This also handles the registration confirmation by posting email, confirmation code and new password.
 @param body Data containing name-value pairs for new user registration.
 */
-(void) registerWithCompletionBlock :(SWGRegister*) body 
        completionHandler: (void (^)(SWGSuccess* output, NSError* error))completionBlock;

/**

 getSession() - Retrieve the current user session information.
 Calling this refreshes the current session, or returns an error for timed-out or invalid sessions.
 */
-(void) getSessionWithCompletionBlock :(void (^)(SWGSession* output, NSError* error))completionBlock;

/**

 login() - Login and create a new user session.
 Calling this creates a new session and logs in the user.
 @param body Data containing name-value pairs used for logging into the system.
 */
-(void) loginWithCompletionBlock :(SWGLogin*) body 
        completionHandler: (void (^)(SWGSession* output, NSError* error))completionBlock;

/**

 logout() - Logout and destroy the current user session.
 Calling this deletes the current session and logs out the user.
 */
-(void) logoutWithCompletionBlock :(void (^)(SWGSuccess* output, NSError* error))completionBlock;

@end

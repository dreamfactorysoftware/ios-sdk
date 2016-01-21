//
//  RESTEngine.h
//  SampleApp
//
//  Created by Timur Umayev on 1/12/16.
//  Copyright © 2016 dreamfactory. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAppVersion @"2.0.2"

// change kApiKey and kBaseInstanceUrl to match your app and instance

// API key for your app goes here, see apps tab in admin console
#define kApiKey @"e917301b79a9da1e9dd90f0d8e1cf4aecb4a6295785167a80759aaacf1190ede"
#define kSessionTokenKey @"SessionToken"
#define kBaseInstanceUrl @"http://localhost:8080/api/v2"
#define kDbServiceName @"db/_table"
#define kUserEmail @"UserEmail"
#define kPassword @"UserPassword"
#define kContainerName @"profile_images"

typedef void (^SuccessBlock)(NSDictionary *response);
typedef void (^FailureBlock)(NSError *error);

@interface NSError (APIMessage)

- (NSString *)errorMessage;

@end

@implementation NSError (APIMessage)

- (NSString *)errorMessage
{
    NSString *errorMessage = self.userInfo[@"error"][@"message"];
    if(!errorMessage) {
        errorMessage = @"Unknown error occurred";
    }
    return errorMessage;
}

@end

@interface RESTEngine : NSObject

@property (nonatomic, copy) NSString *sessionToken;

+ (instancetype)sharedEngine;

/**
 Sign in user
 */
- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Register new user
 */
- (void)registerWithEmail:(NSString *)email password:(NSString *)password success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Get all the groups from the database
 */
- (void)getAddressBookContentFromServerWithSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Remove group from server
 */
- (void)removeGroupFromServerWithGroupId:(NSNumber *)groupId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Add new group with name and contacts
 */
- (void)addGroupToServerWithName:(NSString *)name contactIds:(NSArray *)contactIds success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Update group with new name and contacts
 */
- (void)updateGroupWithId:(NSNumber *)groupId name:(NSString *)name oldName:(NSString *)oldName removedContactIds:(NSArray *)removedContactIds addedContactIds:(NSArray *)addedContactIds success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Get all the contacts from the database
 */
- (void)getContactListFromServerWithSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Get the list of contacts related to the group
 */
- (void)getContactGroupRelationListFromServerWithGroupId:(NSNumber *)groupId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Get all the contacts in the group using relational queries
 */
- (void)getContactsListFromServerWithRelationWithGroupId:(NSNumber *)groupId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Remove contact from server
 */
- (void)removeContactWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Get contact info from server
 */
- (void)getContactInfoFromServerWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Get profile image for contact
 */
- (void)getProfileImageFromServerWithContactId:(NSNumber *)contactId fileName:(NSString *)fileName success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Get all the group the contact is in using relational queries
 */
- (void)getContactGroupsWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Create contact on server
 */
- (void)addContactToServerWithDetails:(NSDictionary *)contactDetails success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;


/**
 Create contact groupr relations on server
 */
- (void)addContactGroupRelationToServerWithContactId:(NSNumber *)contactId groupId:(NSNumber *)groupId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;


/**
 Create contact info on server
 */
- (void)addContactInfoToServer:(NSArray *)info success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Create contact image on server
 */
- (void)addContactImageWithContactId:(NSNumber *)contactId image:(UIImage *)image imageName:(NSString *)imageName success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

- (void)putImageToFolderWithPath:(NSString *)folderPath image:(UIImage *)image fileName:(NSString *)fileName success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Update an existing contact with the server
 */
- (void)updateContactWithContactId:(NSNumber *)contactId contactDetails:(NSDictionary *)contactDetails success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Update an existing contact info with the server
 */
- (void)updateContactInfo: (NSArray *)info success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

/**
 Get list of contact images from server
 */
- (void)getImageListFromServerWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end

//
//  RESTEngine.h
//  SampleApp
//
//  Created by Timur Umayev on 1/12/16.
//  Copyright © 2016 dreamfactory. All rights reserved.
//

#import <UIKit/UIKit.h>

// change these values to match your instance

#define kAppVersion @"2.0.2"

// API key for your app goes here, see apps tab in admin console
#define kApiKey @"47f611bfd5da6bc33e01a473142ea048409adb970839c95fa32af28e4c002e79"
#define kSessionTokenKey @"SessionToken"
#define kBaseInstanceUrl @"https://df-test-gm.enterprise.dreamfactory.com/api/v2"
#define kDbServiceName @"db/_table"
#define kUserEmail @"UserEmail"
#define kPassword @"UserPassword"
#define kContainerName @"profile_images"

typedef void (^SuccessBlock)(NSDictionary *response);
typedef void (^FailureBlock)(NSError *error);

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

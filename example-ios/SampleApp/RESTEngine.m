//
//  RESTEngine.m
//  SampleApp
//
//  Created by Timur Umayev on 1/12/16.
//  Copyright © 2016 dreamfactory. All rights reserved.
//

#import "RESTEngine.h"
#import "NIKApiInvoker.h"
#import "NIKFile.h"

/**
 Routing to different type of API resources
 */
@interface Routing : NSObject

/**
 rest path for request, form is <base instance url>/api/v2/user/resourceName
 */
+ (NSString *)userWithResourceName: (NSString *)resourceName;

/**
 rest path for request, form is <base instance url>/api/v2/<serviceName>/<tableName>
 */
+ (NSString *)serviceWithTableName: (NSString *)tableName;

/**
 rest path for request, form is <base instance url>/api/v2/files/container/<folder path>/
 */
+ (NSString *)resourceFolderWithFolderPath: (NSString *)folderPath;

/**
 rest path for request, form is <base instance url>/api/v2/files/container/<folder path>/filename
 */
+ (NSString *)resourceFileWithFolderPath: (NSString *)folderPath fileName:(NSString *)fileName;

@end

@implementation Routing

+ (NSString *)userWithResourceName: (NSString *)resourceName
{
    return [NSString stringWithFormat:@"%@/user/%@", kBaseInstanceUrl, resourceName];
}

+ (NSString *)serviceWithTableName: (NSString *)tableName
{
    return [NSString stringWithFormat:@"%@/%@/%@", kBaseInstanceUrl, kDbServiceName, tableName];
}

+ (NSString *)resourceFolderWithFolderPath: (NSString *)folderPath
{
    return [NSString stringWithFormat:@"%@/files/%@/%@/", kBaseInstanceUrl, kContainerName, folderPath];
}

+ (NSString *)resourceFileWithFolderPath: (NSString *)folderPath fileName:(NSString *)fileName
{
    return [NSString stringWithFormat:@"%@/files/%@/%@/%@", kBaseInstanceUrl, kContainerName, folderPath, fileName];
}

@end

@interface RESTEngine ()

@property (nonatomic, strong, readonly) NSDictionary *headerParams;
@property (nonatomic, strong, readonly) NSDictionary *sessionHeaderParams;
@property (nonatomic, strong) NIKApiInvoker *api;

@end

@implementation RESTEngine

@synthesize sessionToken = _sessionToken;
@synthesize headerParams = _headerParams;

+ (instancetype)sharedEngine
{
    static dispatch_once_t once;
    static id sharedInstance = nil;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    if (self = [super init]) {
        _api = [NIKApiInvoker sharedInstance];
    }
    return self;
}

- (NSString *)sessionToken
{
    if (_sessionToken == nil) {
        _sessionToken = [[NSUserDefaults standardUserDefaults] stringForKey:kSessionTokenKey];
    }
    return _sessionToken;
}

- (void)setSessionToken:(NSString *)sessionToken
{
    _sessionToken = sessionToken;
    if(sessionToken) {
        [[NSUserDefaults standardUserDefaults] setObject:_sessionToken forKey:kSessionTokenKey];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSessionTokenKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)headerParams
{
    if (_headerParams == nil) {
        _headerParams = @{@"X-DreamFactory-Api-Key": kApiKey};
    }
    return _headerParams;
}

- (NSDictionary *)sessionHeaderParams
{
    NSMutableDictionary *dict = self.headerParams.mutableCopy;
    dict[@"X-DreamFactory-Session-Token"] = self.sessionToken;
    return dict;
}

- (void)callApiWithPath:(NSString *)restApiPath method:(NSString *)method queryParams:(NSDictionary *)queryParams body:(id)body headerParams: (NSDictionary *)headerParams success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.api restPath:restApiPath method:method queryParams:queryParams body:body headerParams:headerParams contentType:@"application/json" completionBlock:^(NSDictionary *response, NSError *error) {
        if (error !=nil && failureBlock != nil) {
            failureBlock(error);
        } else if (successBlock != nil) {
            successBlock(response);
        }
    }];
}

#pragma mark - Authorization methods

- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    id requestBody = @{@"email": email,
                       @"password": password};
    
    [self callApiWithPath:[Routing userWithResourceName:@"session"] method:@"POST" queryParams:nil body:requestBody headerParams:self.headerParams success:successBlock failure:failureBlock];
}


- (void)registerWithEmail:(NSString *)email password:(NSString *)password success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    //login after signup
    NSDictionary *queryParams = @{@"login": @"1"};
    id requestBody = @{@"email": email,
                       @"password": password,
                       @"first_name": @"Address",
                       @"last_name": @"Book",
                       @"name": @"Address Book User"};
    
    [self callApiWithPath:[Routing userWithResourceName:@"register"] method:@"POST" queryParams:queryParams body:requestBody headerParams:self.headerParams success:successBlock failure:failureBlock];
}

#pragma mark - Group methods

- (void)getAddressBookContentFromServerWithSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group"] method:@"GET" queryParams:nil body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)removeContactGroupRelationsForGroupId:(NSNumber *)groupId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // remove all contact-group relations for the group being deleted
    
    // create filter to select all contact_group_relationship records that
    // reference the group being deleted
    NSDictionary *queryParams = @{@"filter": [NSString stringWithFormat:@"contact_group_id=%@", groupId]};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group_relationship"] method:@"DELETE" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)removeGroupFromServerWithGroupId:(NSNumber *)groupId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // can not delete group until all references to it are removed
    // remove relations -> remove group
    // pass record ID so it knows what group we are removing
    
    [self removeContactGroupRelationsForGroupId:groupId success:^(NSDictionary *response) {
        // delete the record by the record ID
        // form is "ids":"1,2,3"
        NSDictionary *queryParams = @{@"ids": groupId.stringValue};
        
        [self callApiWithPath:[Routing serviceWithTableName:@"contact_group"] method:@"DELETE" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
        
    } failure:failureBlock];
}

- (void)addGroupToServerWithName:(NSString *)name contactIds:(NSArray *)contactIds success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    id body = @{@"name": name};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group"] method:@"POST" queryParams:nil body:body headerParams:self.sessionHeaderParams success:^(NSDictionary *response) {
        // get the id of the new group, then add the relations
        NSArray *records = response[@"resource"];
        for(NSDictionary *recordInfo in records) {
            [self addGroupContactRelationsForGroupWithId:recordInfo[@"id"] contactIds:contactIds success:successBlock failure:failureBlock];
        }
    } failure:failureBlock];
}

- (void)addGroupContactRelationsForGroupWithId:(NSNumber *)groupId contactIds:(NSArray *)contactIds success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    
    // if there are contacts to add skip server update
    if (contactIds == nil || contactIds.count == 0) {
        successBlock(nil);
        return;
    }
    
    // build request body
    /*
     *  structure of request is:
     *  {
     *      "resource":[
     *          {
     *             "contact_group_id":id,
     *             "contact_id":id"
     *          },
     *          {...}
     *      ]
     *  }
     */
    
    NSMutableArray *records = [[NSMutableArray alloc] init];
    for (NSNumber *contactId in contactIds) {
        [records addObject:@{@"contact_group_id": groupId, @"contact_id": contactId}];
    }
    
    id body = @{@"resource": records};
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group_relationship"] method:@"POST" queryParams:nil body:body headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)updateGroupWithId:(NSNumber *)groupId name:(NSString *)name oldName:(NSString *)oldName removedContactIds:(NSArray *)removedContactIds addedContactIds:(NSArray *)addedContactIds success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    //if name didn't change skip server update
    if([oldName isEqualToString:name]) {
        [self removeGroupContactRelationsForGroupWithId:groupId contactIds:removedContactIds success:^(NSDictionary *response) {
            
            [self addGroupContactRelationsForGroupWithId:groupId contactIds:addedContactIds success:successBlock failure:failureBlock];
            
        } failure:failureBlock];
        return;
    }
    
    // update name
    NSDictionary *queryParams = @{@"ids": groupId};
    id body = @{@"name": name};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group"] method:@"PATCH" queryParams:queryParams body:body headerParams:self.sessionHeaderParams success:^(NSDictionary *response) {
        
        [self removeGroupContactRelationsForGroupWithId:groupId contactIds:removedContactIds success:^(NSDictionary *response) {
            
            [self addGroupContactRelationsForGroupWithId:groupId contactIds:addedContactIds success:successBlock failure:failureBlock];
            
        } failure:failureBlock];
        
    } failure:failureBlock];
}

- (void)removeGroupContactRelationsForGroupWithId:(NSNumber *)groupId contactIds:(NSArray *)contactIds success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // if there are no contacts to remove skip server update
    if (contactIds == nil || contactIds.count == 0) {
        successBlock(nil);
        return;
    }
    
    // remove contact-group relations
    
    // do not know the ID of the record to remove
    // one value for groupId, but many values for contactId
    // instead of making a long SQL query, change what we use as identifiers
    NSDictionary *queryParams = @{@"id_field": @"contact_group_id,contact_id"};
    
    // build request body
    /*
     *  structure of request is:
     *  {
     *      "resource":[
     *          {
     *             "contact_group_id":id,
     *             "contact_id":id"
     *          },
     *          {...}
     *      ]
     *  }
     */
    NSMutableArray *records = [[NSMutableArray alloc] init];
    for (NSNumber *contactId in contactIds) {
        [records addObject:@{@"contact_group_id": groupId, @"contact_id": contactId}];
    }
    
    id body = @{@"resource": records};
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group_relationship"] method:@"DELETE" queryParams:queryParams body:body headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

#pragma mark - Contact methods

- (void)getContactListFromServerWithSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // only need to get the contactId and full contact name
    // set the fields param to give us just the fields we need
    NSDictionary *queryParams = @{@"fields": @"id,first_name,last_name"};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact"] method:@"GET" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)getContactGroupRelationListFromServerWithGroupId:(NSNumber *)groupId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // create filter to get only the contact in the group
    NSDictionary *queryParams = @{@"filter": [NSString stringWithFormat:@"contact_group_id=%@", groupId]};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group_relationship"] method:@"GET" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)getContactsListFromServerWithRelationWithGroupId:(NSNumber *)groupId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
     // only get contact_group_relationships for this group
    NSMutableDictionary *queryParams = [@{@"filter": [NSString stringWithFormat:@"contact_group_id=%@", groupId]} mutableCopy];
    
    // request without related would return just {id, groupId, contactId}
    // set the related field to go get the contact records referenced by
    // each contact_group_relationship record
    queryParams[@"related"] = @"contact_by_contact_id";
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group_relationship"] method:@"GET" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)removeContactWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // need to delete everything with references to contact before we can delete the contact
    // delete contact relation -> delete contact info -> delete profile images -> delete contact
    // remove contact by record ID
    
    [self removeContactRelationWithContactId:contactId success:^(NSDictionary *response) {
        [self removeContactInfoWithContactId:contactId success:^(NSDictionary *response) {
            [self removeContactImageFolderWithContactId:contactId success:^(NSDictionary *response) {
                
                NSDictionary *queryParams = @{@"ids": contactId.stringValue};
                [self callApiWithPath:[Routing serviceWithTableName:@"contact"] method:@"DELETE" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
                
            } failure:failureBlock];
        } failure:failureBlock];
    } failure:failureBlock];
}

- (void)removeContactRelationWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // remove only contact-group relationships where contact is the contact to remove
    NSDictionary *queryParams = @{@"filter": [NSString stringWithFormat:@"contact_id=%@", contactId]};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group_relationship"] method:@"DELETE" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)removeContactInfoWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // remove only contact info for the contact we want to remove
    NSDictionary *queryParams = @{@"filter": [NSString stringWithFormat:@"contact_id=%@", contactId]};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_info"] method:@"DELETE" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)removeContactImageFolderWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // delete all files and folders in the target folder
    NSDictionary *queryParams = @{@"force": @"1"};
    
    [self callApiWithPath:[Routing resourceFolderWithFolderPath:contactId.stringValue] method:@"DELETE" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)getContactInfoFromServerWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // create filter to get info only for this contact
    NSDictionary *queryParams = @{@"filter": [NSString stringWithFormat:@"contact_id=%@", contactId]};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_info"] method:@"GET" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)getProfileImageFromServerWithContactId:(NSNumber *)contactId fileName:(NSString *)fileName success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // request a download from the file
    NSDictionary *queryParams = @{@"include_properties": @"1",
                                  @"content": @"1",
                                  @"download": @"1"};
    
    [self callApiWithPath:[Routing resourceFileWithFolderPath:contactId.stringValue fileName:fileName] method:@"GET" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)getContactGroupsWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
     // only get contact_group_relationships for this contact
    NSMutableDictionary *queryParams = [@{@"filter": [NSString stringWithFormat:@"contact_id=%@", contactId]} mutableCopy];
    
    // request without related would return just {id, groupId, contactId}
    // set the related field to go get the group records referenced by
    // each contact_group_relationship record
    queryParams[@"related"] = @"contact_group_by_contact_group_id";
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group_relationship"] method:@"GET" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)addContactToServerWithDetails:(NSDictionary *)contactDetails success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // need to create contact first, then can add contactInfo and group relationships
    id body = contactDetails;
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact"] method:@"POST" queryParams:nil body:body headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)addContactGroupRelationToServerWithContactId:(NSNumber *)contactId groupId:(NSNumber *)groupId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // build request body
    // need to put in any extra field-key pair and avoid NSUrl timeout issue
    // otherwise it drops connection
    id body = @{@"contact_group_id": groupId,
               @"contact_id": contactId};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_group_relationship"] method:@"POST" queryParams:nil body:body headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)addContactInfoToServer:(NSArray *)info success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    id body = @{@"resource": info};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_info"] method:@"POST" queryParams:nil body:body headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)addContactImageWithContactId:(NSNumber *)contactId image:(UIImage *)image imageName:(NSString *)imageName success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // first we need to create folder, then image
    
    [self callApiWithPath:[Routing resourceFolderWithFolderPath:contactId.stringValue] method:@"POST" queryParams:nil body:nil headerParams:self.sessionHeaderParams success:^(NSDictionary *response) {
        
        [self putImageToFolderWithPath:contactId.stringValue image:image fileName:imageName success:successBlock failure:failureBlock];
        
    } failure:failureBlock];
}

- (void)putImageToFolderWithPath:(NSString *)folderPath image:(UIImage *)image fileName:(NSString *)fileName success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    NIKFile *file = [[NIKFile alloc] initWithNameData:fileName mimeType:@"application/octet-stream" data:imageData];
    
    [self callApiWithPath:[Routing resourceFileWithFolderPath:folderPath fileName:fileName] method:@"POST" queryParams:nil body:file headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)updateContactWithContactId:(NSNumber *)contactId contactDetails:(NSDictionary *)contactDetails success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // set the id of the contact we are looking at
    NSDictionary *queryParams = @{@"ids": contactId.stringValue};
    id body = contactDetails;
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact"] method:@"PATCH" queryParams:queryParams body:body headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)updateContactInfo: (NSArray *)info success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    id body = @{@"resource": info};
    
    [self callApiWithPath:[Routing serviceWithTableName:@"contact_info"] method:@"PATCH" queryParams:nil body:body headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

- (void)getImageListFromServerWithContactId:(NSNumber *)contactId success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // only want to get files, not any sub folders
    NSDictionary *queryParams = @{@"include_folders": @"0",
                                  @"include_files": @"1"};
    
    [self callApiWithPath:[Routing resourceFolderWithFolderPath:contactId.stringValue] method:@"GET" queryParams:queryParams body:nil headerParams:self.sessionHeaderParams success:successBlock failure:failureBlock];
}

@end

//
//  AFGitHubAPIClient.h
//
//  Copyright (c) 2012 Atsushi Nagase (http://ngs.io/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "AFOAuth2Client.h"
#import "AFGitHubConstants.h"

@class AFGitHubAPIRequestOperation,
AFGitHubRepository,
AFGitHubUser,
AFGitHubOrganization,
AFGitHubAPIResponse,
AFGitHubReference,
AFGitHubBlob,
AFGitHubCommit,
AFGitHubTree;
@interface AFGitHubAPIClient : AFOAuth2Client

+ (AFGitHubAPIClient *)clientWithClientID:(NSString *)clientID secret:(NSString *)secret;
- (id)initWithClientID:(NSString *)clientID secret:(NSString *)secret;

+ (AFGitHubAPIClient *)sharedClient;
+ (void)setSharedClient:(AFGitHubAPIClient *)client;

#pragma mark - Authentication

+ (BOOL)isAuthFormURL:(NSURL *)URL;
- (BOOL)handleOpenURL:(NSURL *)URL withCallbackURLString:(NSString *)callbackURLString
              success:(void (^)(AFOAuthCredential *credential))success
              failure:(void (^)(NSError *error))failure;

- (NSURL *)authURLWithCallbackURLString:(NSString *)callbackURLString
                                  scope:(NSArray *)scope;

- (BOOL)isAuthenticated;
- (void)clearGitHubCookie;

- (AFGitHubAPIRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest
itemClass:(Class)class
success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)logout;

#pragma mark - HTTP Verbs

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
      itemClass:(Class)itemClass
        success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
       itemClass:(Class)itemClass
         success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
         failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)putPath:(NSString *)path
     parameters:(NSDictionary *)parameters
      itemClass:(Class)itemClass
        success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)deletePath:(NSString *)path
        parameters:(NSDictionary *)parameters
         itemClass:(Class)itemClass
           success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
           failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)patchPath:(NSString *)path
       parameters:(NSDictionary *)parameters
        itemClass:(Class)itemClass
          success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
          failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - Pagination

- (void)loadNextURL:(NSURL *)URL withHTTPMethod:(NSString *)method
          itemClass:(Class)itemClass
            success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
            failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - Repos API

- (void)getRepositoriesWithUser:(NSString *)login
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)getRepositoriesWithOrganization:(NSString *)organizationName
                             parameters:(NSDictionary *)parameters
                                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)getMyRepositoriesWithParameters:(NSDictionary *)parameters
                                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)getAllRepositoriesWithParameters:(NSDictionary *)parameters
                                 success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                                 failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)createRepository:(AFGitHubRepository *)repository
              withTeamId:(NSInteger)teamId
                autoInit:(BOOL)autoInit
       gitIgnoreTemplate:(NSString *)gitIgnoreTemplate
                 success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                 failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - Users API

- (void)getUser:(NSString *)login
        success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;


- (void)getUserWithSuccess:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                   failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)updateUser:(AFGitHubUser *)user
           success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
           failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)getAllUsersWithSuccess:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                       failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - Orgs API

- (void)getOrganizationsWithUser:(NSString *)login
                         success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                         failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)getOrganization:(NSString *)login
                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;


- (void)getUserOrganizationWithSuccess:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                               failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)updateOrganization:(AFGitHubOrganization *)organization
                   success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                   failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - Blobs API

- (void)getBlobWithSHA:(NSString *)SHA
            repository:(AFGitHubRepository *)repository
               success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
               failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)createBlob:(AFGitHubBlob *)blob
    withRepository:(AFGitHubRepository *)repository
           success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
           failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - Trees API

- (void)getTreeWithSHA:(NSString *)SHA
           recursively:(BOOL)recursively
            repository:(AFGitHubRepository *)repository
               success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
               failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)createTree:(AFGitHubTree *)tree
    withRepository:(AFGitHubRepository *)repository
           success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
           failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - References API

- (void)getReference:(NSString *)ref
          repository:(AFGitHubRepository *)repository
             success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
             failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)createReference:(AFGitHubReference *)reference
             repository:(AFGitHubRepository *)repository
                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)updateReference:(AFGitHubReference *)reference
                  force:(BOOL)force
             repository:(AFGitHubRepository *)repository
                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - Commits API

- (void)getCommitWithSHA:(NSString *)SHA
              repository:(AFGitHubRepository *)repository
                 success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                 failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)createCommit:(AFGitHubCommit *)commit
          repository:(AFGitHubRepository *)repository
             success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
             failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - Trees + Commits + References API

- (void)createCommitWithTree:(AFGitHubTree *)tree
                      forRef:(NSString *)refString
                     message:(NSString *)message
                       force:(BOOL)force
                  repository:(AFGitHubRepository *)repository
                     success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                     failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

@end

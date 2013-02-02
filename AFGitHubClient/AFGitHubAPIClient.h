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

@class AFGitHubAPIRequestOperation;
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
success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - HTTP Verbs

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
      itemClass:(Class)itemClass
        success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
       itemClass:(Class)itemClass
         success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)putPath:(NSString *)path
     parameters:(NSDictionary *)parameters
      itemClass:(Class)itemClass
        success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)deletePath:(NSString *)path
        parameters:(NSDictionary *)parameters
         itemClass:(Class)itemClass
           success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)patchPath:(NSString *)path
       parameters:(NSDictionary *)parameters
        itemClass:(Class)itemClass
          success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
          failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

#pragma mark - Repos API

- (void)getRepositoriesWithUsername:(NSString *)username
                         parameters:(NSDictionary *)parameters
                            success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)getRepositoriesWithOrganization:(NSString *)organizationName
                             parameters:(NSDictionary *)parameters
                                success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)getMyRepositoriesWithParameters:(NSDictionary *)parameters
                                success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;

- (void)getAllRepositoriesWithParameters:(NSDictionary *)parameters
                                 success:(void (^)(AFGitHubAPIRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure;


@end

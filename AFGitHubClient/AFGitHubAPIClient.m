//
//  AFGitHubAPIClient.m
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

#import "AFGitHubAPIClient.h"
#import "AFGitHubAPIRequestOperation.h"
#import "AFGitHubAPIResponse.h"
#import "AFGitHubBlob.h"
#import "AFGitHubComment.h"
#import "AFGitHubCommit.h"
#import "AFGitHubConstants.h"
#import "AFGitHubGitDataObject.h"
#import "AFGitHubGitObject.h"
#import "AFGitHubGlobal.h"
#import "AFGitHubLinkHeader.h"
#import "AFGitHubObject.h"
#import "AFGitHubOrganization.h"
#import "AFGitHubPullRequest.h"
#import "AFGitHubReference.h"
#import "AFGitHubRepository.h"
#import "AFGitHubTag.h"
#import "AFGitHubTree.h"
#import "AFGitHubUser.h"
#import "AFJSONRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "NSString+URLEncoding.h"
#import "NSString+queryComponents.h"

static NSString * const kAFGitHubAPIBaseURLString = @"https://api.github.com";
static NSString * const kAFGitHubAPINakedBaseURLString = @"https://github.com";

static NSString * const kAFGitHubAPIAuthWindowPath = @"/login/oauth/authorize";
static NSString * const kAFGitHubAPIAccessTokenPath = @"/login/oauth/access_token";

static AFGitHubAPIClient *_sharedClient = nil;

@implementation AFGitHubAPIClient

+ (AFGitHubAPIClient *)sharedClient {
  return _sharedClient;
}

+ (void)setSharedClient:(AFGitHubAPIClient *)client {
  _sharedClient = client;
}

+ (AFGitHubAPIClient *)clientWithClientID:(NSString *)clientID secret:(NSString *)secret {
  return [[self alloc] initWithClientID:clientID secret:secret];
}

- (id)initWithClientID:(NSString *)clientID secret:(NSString *)secret {
  return self = [self initWithBaseURL:[NSURL URLWithString:kAFGitHubAPIBaseURLString] clientID:clientID secret:secret];
}

- (id)initWithBaseURL:(NSURL *)url clientID:(NSString *)clientID secret:(NSString *)secret {
  if (self = [super initWithBaseURL:url clientID:clientID secret:secret]) {
    [self registerHTTPOperationClass:[AFGitHubAPIRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/vnd.github.full+json"];
    [self setParameterEncoding:AFJSONParameterEncoding];
  }
  return self;
}

#pragma mark - AFHTTPClient

- (AFHTTPClientParameterEncoding)parameterEncoding {
  return AFJSONParameterEncoding;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *, id))success
                                                    failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
  [AFGitHubAPIRequestOperation addAcceptableStatusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(400, 5)]];
  [AFGitHubAPIRequestOperation addAcceptableStatusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(422, 1)]];
  [AFGitHubAPIRequestOperation addAcceptableStatusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(300, 5)]];
  AFGitHubAPIRequestOperation *op = [[AFGitHubAPIRequestOperation alloc] initWithRequest:request];
  [op setCompletionBlockWithSuccess:success failure:failure];
  return op;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters {
  NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
  if(([path isEqualToString:kAFGitHubAPIAccessTokenPath] &&
      [method.uppercaseString isEqualToString:@"POST"]))
    [request setURL:[NSURL URLWithString:kAFGitHubAPIAccessTokenPath
                           relativeToURL:[NSURL URLWithString:kAFGitHubAPINakedBaseURLString]]];
  return request;
}


- (AFGitHubAPIRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                                       itemClass:(Class)itemClass
                                                         success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                                                         failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  AFGitHubAPIRequestOperation *op = (AFGitHubAPIRequestOperation *)
  [self HTTPRequestOperationWithRequest:urlRequest
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  AFGitHubAPIRequestOperation *op = (AFGitHubAPIRequestOperation *)operation;
                                  success(op, op.ghResponse);
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  failure((AFGitHubAPIRequestOperation *)operation, error);
                                }];
  [op setItemClass:itemClass];
  return op;
}

#pragma mark - HTTP Verbs

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
      itemClass:(Class)itemClass
        success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
	NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
  AFGitHubAPIRequestOperation *operation =
  [self
   HTTPRequestOperationWithRequest:request itemClass:itemClass
   success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
     AFGitHubAPIRequestOperation *op = (AFGitHubAPIRequestOperation *)operation;
     success(op, op.ghResponse);
   }
   failure:failure];
  [self enqueueHTTPRequestOperation:operation];
}

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
       itemClass:(Class)itemClass
         success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
         failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
	NSURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:parameters];
  AFGitHubAPIRequestOperation *operation =
  [self
   HTTPRequestOperationWithRequest:request itemClass:itemClass
   success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
     AFGitHubAPIRequestOperation *op = (AFGitHubAPIRequestOperation *)operation;
     success(op, op.ghResponse);
   }
   failure:failure];
  [self enqueueHTTPRequestOperation:operation];
}

- (void)putPath:(NSString *)path
     parameters:(NSDictionary *)parameters
      itemClass:(Class)itemClass
        success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
	NSURLRequest *request = [self requestWithMethod:@"PUT" path:path parameters:parameters];
  AFGitHubAPIRequestOperation *operation =
  [self
   HTTPRequestOperationWithRequest:request itemClass:itemClass
   success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
     AFGitHubAPIRequestOperation *op = (AFGitHubAPIRequestOperation *)operation;
     success(op, op.ghResponse);
   }
   failure:failure];
  [self enqueueHTTPRequestOperation:operation];
}

- (void)deletePath:(NSString *)path
        parameters:(NSDictionary *)parameters
         itemClass:(Class)itemClass
           success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
           failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
	NSURLRequest *request = [self requestWithMethod:@"DELETE" path:path parameters:parameters];
  AFGitHubAPIRequestOperation *operation =
  [self
   HTTPRequestOperationWithRequest:request itemClass:itemClass
   success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
     AFGitHubAPIRequestOperation *op = (AFGitHubAPIRequestOperation *)operation;
     success(op, op.ghResponse);
   }
   failure:failure];
  [self enqueueHTTPRequestOperation:operation];
}

- (void)patchPath:(NSString *)path
       parameters:(NSDictionary *)parameters
        itemClass:(Class)itemClass
          success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
          failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  NSURLRequest *request = [self requestWithMethod:@"PATCH" path:path parameters:parameters];
  AFGitHubAPIRequestOperation *operation =
  [self
   HTTPRequestOperationWithRequest:request itemClass:itemClass
   success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
     AFGitHubAPIRequestOperation *op = (AFGitHubAPIRequestOperation *)operation;
     success(op, op.ghResponse);
   }
   failure:failure];
  [self enqueueHTTPRequestOperation:operation];
}

#pragma mark - Pagination

- (void)loadNextURL:(NSURL *)URL withHTTPMethod:(NSString *)method
          itemClass:(Class)itemClass
            success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
            failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  NSMutableURLRequest *mreq = [self requestWithMethod:method path:nil parameters:nil];
  [mreq setURL:URL];
  AFGitHubAPIRequestOperation *op =
  [self
   HTTPRequestOperationWithRequest:mreq
   itemClass:[AFGitHubRepository class]
   success:success failure:failure];
  [self enqueueHTTPRequestOperation:op];
}


#pragma mark - Authentication

+ (BOOL)isAuthFormURL:(NSURL *)URL {
  NSString *host = URL.host;
  NSString *path = URL.path;
  return
  ([host hasSuffix:@"github.com"] &&
   (
    [path isEqualToString:@"/session"] ||
    [path isEqualToString:@"/login/oauth/authorize"] ||
    [path isEqualToString:@"/login"] ||
    [path hasPrefix:@"/login/remote"])
   );
}

- (void)clearGitHubCookie {
  NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
  for (NSHTTPCookie *cookie in [storage cookies]) {
    [storage deleteCookie:cookie];
  }
}

- (BOOL)handleOpenURL:(NSURL *)URL withCallbackURLString:(NSString *)callbackURLString
              success:(void (^)(AFOAuthCredential *credential))success
              failure:(void (^)(NSError *error))failure {
  if(![URL.absoluteString hasPrefix:callbackURLString])
    return NO;
  NSDictionary *query = [URL.query queryContentsUsingEncoding:NSUTF8StringEncoding];
  NSString *code = AFGitHubIsArrayWithObjects([query valueForKey:@"code"]) ? [[query valueForKey:@"code"] objectAtIndex:0] : nil;
  if(!AFGitHubIsStringWithAnyText(code)) {
    dispatch_async(dispatch_get_main_queue(), ^{
      failure([NSError errorWithDomain:AFGitHubErrorDomain code:403 userInfo:nil]);
    });
    return YES;
  }
  [self
   authenticateUsingOAuthWithPath:kAFGitHubAPIAccessTokenPath
   code:code redirectURI:callbackURLString
   success:^(AFOAuthCredential *credential) {
     [[NSNotificationCenter defaultCenter]
      postNotificationName:AFGitHubNotificationAuthenticationSuccess
      object:self userInfo:@{ @"credential": credential }];
     success(credential);
   }
   failure:failure];
  return YES;
}

- (BOOL)isAuthenticated {
  return AFGitHubIsStringWithAnyText([self defaultValueForHeader:@"Authorization"]);
}

- (NSURL *)authURLWithCallbackURLString:(NSString *)callbackURLString
                                  scope:(NSArray *)scope {
  return [NSURL URLWithString:
          [NSString stringWithFormat:
           @"%@%@?client_id=%@&redirect_uri=%@&scope=%@",
           kAFGitHubAPINakedBaseURLString, kAFGitHubAPIAuthWindowPath,
           self.clientID, callbackURLString.URLEncodedString,
           [scope componentsJoinedByString:@","].URLEncodedString]];
}

- (void)logout {
  [self clearAuthorizationHeader];
  [self clearGitHubCookie];
  [[NSNotificationCenter defaultCenter]
   postNotificationName:AFGitHubNotificationAuthenticationCleared
   object:self userInfo:nil];
}

#pragma mark - Repos API

- (void)getRepositoriesWithUser:(NSString *)login
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:[NSString stringWithFormat:@"/users/%@/repos", login]
     parameters:parameters
      itemClass:[AFGitHubRepository class]
        success:success failure:failure];
}

- (void)getRepositoriesWithOrganization:(NSString *)organizationName
                             parameters:(NSDictionary *)parameters
                                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:[NSString stringWithFormat:@"/orgs/%@/repos", organizationName]
     parameters:parameters
      itemClass:[AFGitHubRepository class]
        success:success failure:failure];
}

- (void)getMyRepositoriesWithParameters:(NSDictionary *)parameters
                                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:@"/user/repos"
     parameters:parameters
      itemClass:[AFGitHubRepository class]
        success:success failure:failure];
}

- (void)getAllRepositoriesWithParameters:(NSDictionary *)parameters
                                 success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                                 failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:@"/repositories"
     parameters:parameters
      itemClass:[AFGitHubRepository class]
        success:success failure:failure];
}

- (void)createRepository:(AFGitHubRepository *)repository
              withTeamId:(NSInteger)teamId
                autoInit:(BOOL)autoInit
       gitIgnoreTemplate:(NSString *)gitIgnoreTemplate
                 success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                 failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  NSMutableDictionary *params = [repository asJSON].mutableCopy;
  params[@"auto_init"] = [NSNumber numberWithBool:autoInit];
  if(autoInit && AFGitHubIsStringWithAnyText(gitIgnoreTemplate))
    params[@"gitIgnore_template"] = gitIgnoreTemplate;
  if(teamId > 0)
    params[@"team_id"] = [NSNumber numberWithInteger:teamId];
  NSString *path = [repository.owner isKindOfClass:[AFGitHubOrganization class]] ? [NSString stringWithFormat:@"/orgs/%@/repos", repository.owner.login] : @"/user/repos";
  [self postPath:path
      parameters:params
       itemClass:[AFGitHubRepository class]
         success:success failure:failure];
}

#pragma mark - Users API

- (void)getUser:(NSString *)login
        success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
        failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:[NSString stringWithFormat:@"/users/%@", login]
     parameters:@{}
      itemClass:[AFGitHubUser class]
        success:success failure:failure];
}

- (void)getUserWithSuccess:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                   failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:@"/user"
     parameters:@{}
      itemClass:[AFGitHubUser class]
        success:success failure:failure];
}

- (void)updateUser:(AFGitHubUser *)user
           success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
           failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self patchPath:@"/user"
       parameters:[user asJSON]
        itemClass:[AFGitHubUser class]
          success:success failure:failure];
}

- (void)getAllUsersWithSuccess:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                       failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:@"/users"
     parameters:@{}
      itemClass:[AFGitHubUser class]
        success:success failure:failure];
}

#pragma mark - Orgs API

- (void)getOrganizationsWithUser:(NSString *)login
                         success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                         failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:[NSString stringWithFormat:@"/users/%@/orgs", login]
     parameters:@{}
      itemClass:[AFGitHubOrganization class]
        success:success failure:failure];
}

- (void)getOrganization:(NSString *)login
                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:[NSString stringWithFormat:@"/orgs/%@", login]
     parameters:@{}
      itemClass:[AFGitHubOrganization class]
        success:success failure:failure];
}


- (void)getUserOrganizationWithSuccess:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                               failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self getPath:@"/user/orgs"
     parameters:@{}
      itemClass:[AFGitHubOrganization class]
        success:success failure:failure];
}

- (void)updateOrganization:(AFGitHubOrganization *)organization
                   success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                   failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self patchPath:[NSString stringWithFormat:@"/orgs/%@", organization.login]
       parameters:[organization asJSON]
        itemClass:[AFGitHubOrganization class]
          success:success failure:failure];
}

#pragma mark - Blobs API

- (void)getBlobWithSHA:(NSString *)SHA
            repository:(AFGitHubRepository *)repository
               success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
               failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self
   getPath:[NSString stringWithFormat:@"/repos/%@/%@/git/blobs/%@",
            repository.owner.login, repository.name, SHA]
   parameters:@{}
   itemClass:[AFGitHubBlob class]
   success:success
   failure:failure];
}

- (void)createBlob:(AFGitHubBlob *)blob
    withRepository:(AFGitHubRepository *)repository
           success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
           failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self
   postPath:[NSString stringWithFormat:@"/repos/%@/%@/git/blobs",
             repository.owner.login, repository.name]
   parameters:blob.asJSON
   itemClass:[AFGitHubBlob class]
   success:success
   failure:failure];
}



#pragma mark - Trees API

- (void)getTreeWithSHA:(NSString *)SHA
           recursively:(BOOL)recursively
            repository:(AFGitHubRepository *)repository
               success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
               failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self
   getPath:[NSString stringWithFormat:@"/repos/%@/%@/git/trees/%@",
            repository.owner.login, repository.name, SHA]
   parameters: recursively ? @{ @"recursive": @"1" } : @{}
   itemClass:[AFGitHubTree class]
   success:success
   failure:failure];
}

- (void)createTree:(AFGitHubTree *)tree
    withRepository:(AFGitHubRepository *)repository
           success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
           failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self
   postPath:[NSString stringWithFormat:@"/repos/%@/%@/git/trees",
             repository.owner.login, repository.name]
   parameters:tree.asJSON
   itemClass:[AFGitHubTree class]
   success:success
   failure:failure];
}



#pragma mark - References API

- (void)getReference:(NSString *)ref
          repository:(AFGitHubRepository *)repository
             success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
             failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self
   getPath:[NSString stringWithFormat:@"/repos/%@/%@/git/%@",
            repository.owner.login, repository.name, ref]
   parameters: @{}
   itemClass:[AFGitHubReference class]
   success:success
   failure:failure];
}

- (void)createReference:(AFGitHubReference *)reference
             repository:(AFGitHubRepository *)repository
                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self postPath:[NSString stringWithFormat:@"/repos/%@/%@/git/refs",
                  repository.owner.login, repository.name]
      parameters:reference.asJSON
       itemClass:[AFGitHubReference class]
         success:success
         failure:failure];
}

- (void)updateReference:(AFGitHubReference *)reference
                  force:(BOOL)force
             repository:(AFGitHubRepository *)repository
                success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self patchPath:[NSString stringWithFormat:@"/repos/%@/%@/git/%@",
                   repository.owner.login, repository.name, reference.ref]
       parameters:reference.asJSON
        itemClass:[AFGitHubReference class]
          success:success
          failure:failure];
}


#pragma mark - Commits API

- (void)getCommitWithSHA:(NSString *)SHA
              repository:(AFGitHubRepository *)repository
                 success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                 failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self
   getPath:[NSString stringWithFormat:@"/repos/%@/%@/git/commits/%@",
            repository.owner.login, repository.name, SHA]
   parameters: @{}
   itemClass:[AFGitHubCommit class]
   success:success
   failure:failure];
}

- (void)createCommit:(AFGitHubCommit *)commit
          repository:(AFGitHubRepository *)repository
             success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
             failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self
   postPath:[NSString stringWithFormat:@"/repos/%@/%@/git/commits",
             repository.owner.login, repository.name]
   parameters:commit.asJSON
   itemClass:[AFGitHubCommit class]
   success:success
   failure:failure];
}


#pragma mark - Trees + Commits + References API

- (void)createCommitWithTree:(AFGitHubTree *)tree
                      forRef:(NSString *)refString
                     message:(NSString *)message
                       force:(BOOL)force
                  repository:(AFGitHubRepository *)repository
                     success:(void (^)(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject))success
                     failure:(void (^)(AFGitHubAPIRequestOperation *operation, NSError *error))failure {
  [self
   createTree:tree withRepository:repository
   success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
     AFGitHubTree *newTree = [responseObject first];
     [self
      getReference:refString
      repository:repository
      success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
        AFGitHubReference *ref = [responseObject first];
        AFGitHubCommit *commit = [[AFGitHubCommit alloc] init];
        commit.parents = @[ref.object];
        commit.tree = newTree;
        commit.message = message;
        [self
         createCommit:commit
         repository:repository
         success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
           ref.object = responseObject.first;
           [self updateReference:ref force:force repository:repository success:success failure:failure];
         }
         failure:failure];
        
      }
      failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
        if(error.code == 404) {
          AFGitHubCommit *commit = [[AFGitHubCommit alloc] init];
          commit.tree = newTree;
          commit.message = message;
          [self
           createCommit:commit
           repository:repository
           success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
             AFGitHubReference *ref = [[AFGitHubReference alloc] initWithObject:responseObject.first ref:refString];
             [self createReference:ref repository:repository success:success failure:failure];
           }
           failure:failure];
        } else {
          failure(operation, error);
        }
      }];
   }
   failure:failure];
  
}



@end

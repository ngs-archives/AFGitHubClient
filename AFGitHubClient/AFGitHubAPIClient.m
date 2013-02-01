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
#import "AFJSONRequestOperation.h"
#import "AFGitHubAPIRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"

static NSString * const kAFGitHubAPIBaseURLString = @"https://api.github.com";
static AFGitHubAPIClient *_sharedClient = nil;

@implementation AFGitHubAPIClient

+ (AFGitHubAPIClient *)sharedClient {
  return _sharedClient;
}

+ (void)setSharedClient:(AFGitHubAPIClient *)client {
  _sharedClient = client;
}

- (id)initWithClientID:(NSString *)clientID secret:(NSString *)secret {
  return self = [self initWithBaseURL:[NSURL URLWithString:kAFGitHubAPIBaseURLString] clientID:clientID secret:secret];
}

- (id)initWithBaseURL:(NSURL *)url clientID:(NSString *)clientID secret:(NSString *)secret {
  if (self = [super initWithBaseURL:url clientID:clientID secret:secret]) {
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/vnd.github.full+json"];
  }
  return self;
}

- (AFHTTPClientParameterEncoding)parameterEncoding {
  return AFJSONParameterEncoding;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *, id))success
                                                    failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
  [AFGitHubAPIRequestOperation addAcceptableStatusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(400, 5)]];
  [AFGitHubAPIRequestOperation addAcceptableStatusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(422, 1)]];
  [AFGitHubAPIRequestOperation addAcceptableStatusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(300, 5)]];
#if __IPHONE_OS_VERSION_MIN_REQUIRED
  [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
#endif
  AFGitHubAPIRequestOperation *op = [[AFGitHubAPIRequestOperation alloc] initWithRequest:request];
  [op setCompletionBlockWithSuccess:success failure:failure];
  return op;
}


@end

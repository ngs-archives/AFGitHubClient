#import "AFHTTPClient.h"

@interface AFGitHubAPIClient : AFHTTPClient

+ (AFGitHubAPIClient *)sharedClient;

@end

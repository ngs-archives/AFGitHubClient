#import "AFOAuth2Client.h"

@interface AFGitHubAPIClient : AFOAuth2Client

+ (AFGitHubAPIClient *)sharedClient;

@end

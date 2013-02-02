//
//  AFGitHubAPIError.m
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubAPIError.h"
#import "AFGitHubGlobal.h"

NSString * const AFGitHubErrorDomain = @"io.ngs.AFGitHubErrorDomain";

@implementation AFGitHubAPIError

+ (NSError *)errorWithDictionary:(NSDictionary *)dictionary withStatusCode:(NSInteger)statusCode {
  AFGitHubAPIError *error = [AFGitHubAPIError errorWithDomain:AFGitHubErrorDomain code:statusCode userInfo:dictionary];
  return error;
}

- (NSString *)localizedDescription {
  if(self.userInfo && AFGitHubIsStringWithAnyText(self.userInfo[@"message"])) {
    return self.userInfo[@"message"];
  }
  return [super localizedDescription];
}

@end

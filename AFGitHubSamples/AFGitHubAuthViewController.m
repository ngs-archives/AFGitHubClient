//
//  AFGitHubAuthViewController.m
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubAuthViewController.h"
#import "AFGitHubAPIKeys.h"
#import "AFGitHub.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation AFGitHubAuthViewController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if(!self.webView.request) {
    NSURL *URL = [[AFGitHubAPIClient sharedClient]
                  authURLWithCallbackURLString:kAFGitHubCallbackURL
                  scope:@[@"repo"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
  }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  if([AFGitHubAPIClient isAuthFormURL:request.URL])
    return YES;
  AFGitHubAPIClient *client = [AFGitHubAPIClient sharedClient];
  if([client
      handleOpenURL:request.URL
      withCallbackURLString:kAFGitHubCallbackURL
      success:^(AFOAuthCredential *credential) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [SVProgressHUD dismiss];
      }
      failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
      }]) {
        [SVProgressHUD showWithStatus:@"Requesting access token..."
                             maskType:SVProgressHUDMaskTypeGradient];
      }
  return NO;
}

@end

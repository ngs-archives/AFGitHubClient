//
//  AFGitHubTopViewController.m
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubTopViewController.h"
#import "AFGitHubSampleRepoListViewController.h"
#import <BlocksKit/BlocksKit.h>
#import "AFGithub.h"

@implementation AFGitHubTopViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  AFGitHubAPIClient *client = [AFGitHubAPIClient sharedClient];
  if([client isAuthenticated]) {
    [self.navigationItem setRightBarButtonItem:
     [[UIBarButtonItem alloc]
      initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered
      handler:^(id sender) {
        [client clearAuthorizationHeader];
        [client clearGitHubCookie];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"AFNotificationGitHubAuthenticationCleared"
         object:client userInfo:nil];
      }]];
  } else {
    [self.navigationItem setRightBarButtonItem:
     [[UIBarButtonItem alloc]
      initWithTitle:@"Login" style:UIBarButtonItemStyleBordered
      handler:^(id sender) {
        [self performSegueWithIdentifier:@"AuthModalSegue" sender:self];
      }]];
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([sender isKindOfClass:[UITableViewCell class]]) {
    if([segue.destinationViewController isKindOfClass:[AFGitHubSampleRepoListViewController class]]) {
      AFGitHubSampleRepoListViewController *vc = segue.destinationViewController;
      switch ([(UITableViewCell *)sender tag]) {
        case 1:
          vc.owner = AFGitHubRepoOwnerMe;
          break;
        case 2:
          vc.owner = AFGitHubRepoOwnerUser;
          break;
        case 3:
          vc.owner = AFGitHubRepoOwnerOrganization;
          break;
        case 4:
          vc.owner = AFGitHubRepoOwnerAll;
          break;
      }
    } else if([segue.destinationViewController isKindOfClass:[AFGitHubSampleRepoListViewController class]]) {
      AFGitHubSampleRepoListViewController *vc = segue.destinationViewController;
      switch ([(UITableViewCell *)sender tag]) {
        case 5:
          vc.owner = AFGitHubRepoOwnerMe;
          break;
        case 6:
          vc.owner = AFGitHubRepoOwnerOrganization;
          break;
      }
      
    }
  }
}


@end

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
  AFGitHubSampleRepoListViewController *vc = segue.destinationViewController;
  if([sender isKindOfClass:[UITableViewCell class]]) {
    switch ([(UITableViewCell *)sender tag]) {
      case 1:
        vc.method = AFGitHubRepoMehtodList;
        vc.owner = AFGitHubRepoOwnerMe;
        break;
      case 2:
        vc.method = AFGitHubRepoMehtodList;
        vc.owner = AFGitHubRepoOwnerUser;
        break;
      case 3:
        vc.method = AFGitHubRepoMehtodList;
        vc.owner = AFGitHubRepoOwnerOrganization;
        break;
      case 4:
        vc.method = AFGitHubRepoMehtodList;
        vc.owner = AFGitHubRepoOwnerAll;
        break;
      case 5:
        vc.method = AFGitHubRepoMehtodCreate;
        vc.owner = AFGitHubRepoOwnerMe;
        break;
      case 6:
        vc.method = AFGitHubRepoMehtodCreate;
        vc.owner = AFGitHubRepoOwnerOrganization;
        break;
    }
  }
}





@end

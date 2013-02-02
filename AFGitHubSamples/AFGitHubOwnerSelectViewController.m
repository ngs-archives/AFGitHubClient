//
//  AFGitHubOwnerSelectViewController.m
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubOwnerSelectViewController.h"
#import "AFGitHubCreateRepositoryViewController.h"
#import "AFGitHub.h"
#import "AFGitHubGlobal.h"
#import <BlocksKit/BlocksKit.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface AFGitHubOwnerSelectViewController ()

@property (nonatomic, strong) NSMutableArray *orgs;
@property (nonatomic, copy) NSURL *nextURL;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation AFGitHubOwnerSelectViewController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if(!AFGitHubIsArrayWithObjects(self.orgs)) {
    [self loadOrgs];
  }
}


- (void)loadOrgs {
  [[AFGitHubAPIClient sharedClient]
   getUserOrganizationWithSuccess:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
     [self addResultsWithResponse:responseObject];
   }
   failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
     [self showError:error];
   }];
}

- (void)loadNextURL {
  if(self.nextURL) {
    self.isLoading = YES;
    [[AFGitHubAPIClient sharedClient]
     loadNextURL:self.nextURL withHTTPMethod:@"GET" itemClass:[AFGitHubOrganization class]
     success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
       [self addResultsWithResponse:responseObject];
     }
     failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
       [self showError:error];
     }];
  }
}

- (void)showError:(NSError *)error {
  self.isLoading = NO;
  [SVProgressHUD showErrorWithStatus:error.localizedDescription];
}

- (void)addResultsWithResponse:(AFGitHubAPIResponse *)response {
  [SVProgressHUD dismiss];
  self.isLoading = NO;
  AFGitHubOrganization *org = nil;
  if(!self.orgs)
    self.orgs = @[].mutableCopy;
  self.nextURL = response.nextURL;
  while ((org = response.next)) {
    [self.orgs addObject:org];
  }
  [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.orgs.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnerCell"];
  if(indexPath.row == 0) {
    [cell.textLabel setText:self.user.displayName];
  } else if(indexPath.row <= self.orgs.count) {
    AFGitHubOrganization *org = self.orgs[indexPath.row - 1];
    [cell.textLabel setText:org.displayName];
  } else {
    [cell.textLabel setText:@"Loading more..."];
  }
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if(indexPath.row == 0) {
    [self.delegate setOrganization:nil];
  } else if(indexPath.row <= self.orgs.count) {
    AFGitHubOrganization *org = self.orgs[indexPath.row - 1];
    [self.delegate setOrganization:org];
  }
  [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if(!self.isLoading&&self.nextURL) {
    CGFloat y = scrollView.contentOffset.y + scrollView.frame.size.height + scrollView.frame.origin.y;
    CGFloat h = scrollView.contentSize.height - 60;
    if(y>=h) [self loadNextURL];
  }
}

@end

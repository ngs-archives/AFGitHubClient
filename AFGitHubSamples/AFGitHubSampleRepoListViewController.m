//
//  AFGitHubSampleRepoListViewController.m
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubSampleRepoListViewController.h"
#import "AFGitHub.h"
#import "AFGitHubGlobal.h"
#import <BlocksKit/BlocksKit.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface AFGitHubSampleRepoListViewController ()

@property (nonatomic, strong) NSMutableArray *repos;
@property (nonatomic, copy) NSURL *nextURL;
@property (nonatomic, assign) BOOL isLoading;

@end


@implementation AFGitHubSampleRepoListViewController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if(!AFGitHubIsArrayWithObjects(self.repos)) {
    switch (self.owner) {
      case AFGitHubRepoOwnerAll:
        [self loadAllRepositories];
        break;
      case AFGitHubRepoOwnerUser: {
        UIAlertView *av = [UIAlertView alertViewWithTitle:@"Username?"];
        [av setAlertViewStyle:UIAlertViewStylePlainTextInput];
        UITextField *tf = [av textFieldAtIndex:0];
        [av setCancelButtonWithTitle:@"Cancel" handler:nil];
        [av addButtonWithTitle:@"OK" handler:^{
          [self loadRepositoriesWithUsername:tf.text];
        }];
        [av show];
        break;
      }
      case AFGitHubRepoOwnerMe:
        [self loadMyRepositories];
        break;
      case AFGitHubRepoOwnerOrganization:{
        UIAlertView *av = [UIAlertView alertViewWithTitle:@"Organization?"];
        [av setAlertViewStyle:UIAlertViewStylePlainTextInput];
        UITextField *tf = [av textFieldAtIndex:0];
        [av setCancelButtonWithTitle:@"Cancel" handler:nil];
        [av addButtonWithTitle:@"OK" handler:^{
          [self loadRepositoriesWithOrganization:tf.text];
        }];
        [av show];
        break;
      }
    }
  }
}

#pragma mark - Load methods

- (void)loadAllRepositories {
  [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
  self.isLoading = YES;
  [[AFGitHubAPIClient sharedClient]
   getAllRepositoriesWithParameters:nil
   success:^(AFGitHubAPIRequestOperation *operation, id responseObject) {
     [self addReposWithResponse:responseObject];
   }
   failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
     [self showError:error];
   }];
}

- (void)loadRepositoriesWithUsername:(NSString *)username {
  [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
  self.isLoading = YES;
  [[AFGitHubAPIClient sharedClient]
   getRepositoriesWithUsername:username
   parameters:nil
   success:^(AFGitHubAPIRequestOperation *operation, id responseObject) {
     [self addReposWithResponse:responseObject];
   }
   failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
     [self showError:error];
   }];
}

- (void)loadRepositoriesWithOrganization:(NSString *)organizationName {
  [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
  self.isLoading = YES;
  [[AFGitHubAPIClient sharedClient]
   getRepositoriesWithOrganization:organizationName
   parameters:nil
   success:^(AFGitHubAPIRequestOperation *operation, id responseObject) {
     [self addReposWithResponse:responseObject];
   }
   failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
     [self showError:error];
   }];
}

- (void)loadMyRepositories {
  [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
  self.isLoading = YES;
  [[AFGitHubAPIClient sharedClient]
   getMyRepositoriesWithParameters:nil
   success:^(AFGitHubAPIRequestOperation *operation, id responseObject) {
     [self addReposWithResponse:responseObject];
   }
   failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
     [self showError:error];
   }];}

- (void)loadNextURL {
  if(self.nextURL) {
    AFGitHubAPIClient *client = [AFGitHubAPIClient sharedClient];
    NSMutableURLRequest *mreq = [client requestWithMethod:@"GET" path:nil parameters:nil];
    [mreq setURL:self.nextURL];
    self.isLoading = YES;
    AFGitHubAPIRequestOperation *op =
    [client
     HTTPRequestOperationWithRequest:mreq
     itemClass:[AFGitHubRepository class]
     success:^(AFGitHubAPIRequestOperation *operation, id responseObject) {
       [self addReposWithResponse:responseObject];
     }
     failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
       [self showError:error];
     }];
    [client enqueueHTTPRequestOperation:op];
  }
}

- (void)showError:(NSError *)error {
  self.isLoading = NO;
  [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
}

- (void)addReposWithResponse:(AFGitHubAPIResponse *)response {
  [SVProgressHUD dismiss];
  self.isLoading = NO;
  AFGitHubRepository *repo = nil;
  if(!self.repos)
    self.repos = @[].mutableCopy;
  self.nextURL = response.nextURL;
  while ((repo = response.next)) {
    [self.repos addObject:repo];
  }
  [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.repos.count + (self.nextURL ? 1 : 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AFGitHubRepositoryCell"];
  if(indexPath.row == self.repos.count) {
    [cell.textLabel setText:@"Loading more..."];
    [cell.detailTextLabel setText:nil];
  } else {
    AFGitHubRepository *repo = self.repos[indexPath.row];
    [cell.textLabel setText:repo.fullName];
    [cell.detailTextLabel setText:repo.language];
  }
  return cell;
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

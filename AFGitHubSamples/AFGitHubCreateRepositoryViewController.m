//
//  AFGitHubCreateRepositoryViewController.m
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubCreateRepositoryViewController.h"
#import "AFGitHubOwnerSelectViewController.h"
#import "AFGitHub.h"
#import "AFGitHubGlobal.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface AFGitHubCreateRepositoryViewController ()

@property (nonatomic, assign) BOOL isLoadingUser;
@property (nonatomic, strong) AFGitHubRepository *stubRepo;

@end

@implementation AFGitHubCreateRepositoryViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.stubRepo = [[AFGitHubRepository alloc] init];
  self.stubRepo.name = self.nameTextField.text;
  self.stubRepo.repositoryDescription = self.descriptionTextField.text;
  if(!self.user) {
    [self loadUser];
  }
  [self validateForm];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.destinationViewController isKindOfClass:[AFGitHubOwnerSelectViewController class]]) {
    AFGitHubOwnerSelectViewController *vc = (AFGitHubOwnerSelectViewController *)segue.destinationViewController;
    [vc setCreateViewController:self];
    [vc setUser:self.user];
  }
}

#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if(indexPath.section == 1 && indexPath.row == 0) {
    if(self.user) {
      [self performSegueWithIdentifier:@"SelectOwnerSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];
    } else {
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
  }
}

#pragma mark -

- (void)setOrganization:(AFGitHubOrganization *)organization {
  _organization = [organization copy];
  if(organization) {
    [self.ownerNameLabel setText:organization.displayName];
  } else {
    [self.ownerNameLabel setText:self.user.displayName];
  }
  [self.tableView reloadData];
}

- (void)loadUser {
  [[AFGitHubAPIClient sharedClient] getUserWithSuccess:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
    self.user = [responseObject first];
    [self.ownerNameLabel setText:self.user.name];
    [self validateForm];
    [self.tableView reloadData];
  } failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
  }];
}

- (void)validateForm {
  UIBarButtonItem *buttonItem = self.navigationItem.rightBarButtonItem;
  buttonItem.enabled = AFGitHubIsStringWithAnyText(self.stubRepo.name) && (self.user || self.organization);
}

- (IBAction)done:(id)sender {
  AFGitHubAPIClient *client = [AFGitHubAPIClient sharedClient];
  AFGitHubRepository *repo = [[AFGitHubRepository alloc] init];
  repo.name = self.nameTextField.text;
  repo.repositoryDescription = self.descriptionTextField.text;
  [SVProgressHUD showWithStatus:@"Creating repository" maskType:SVProgressHUDMaskTypeGradient];
  if(self.organization) {
    [client
     createRepository:repo
     withOrganization:self.organization.login
     teamId:0
     autoInit:NO
     gitIgnoreTemplate:nil
     success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
       [SVProgressHUD showSuccessWithStatus:@"Created!"];
       [self.navigationController popToRootViewControllerAnimated:YES];
     }
     failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
       [SVProgressHUD showErrorWithStatus:error.localizedDescription];
     }];
  } else {
    [client
     createRepository:repo
     withTeamId:0
     autoInit:NO
     gitIgnoreTemplate:nil
     success:^(AFGitHubAPIRequestOperation *operation, AFGitHubAPIResponse *responseObject) {
       [SVProgressHUD showSuccessWithStatus:@"Created!"];
       [self.navigationController popToRootViewControllerAnimated:YES];
     }
     failure:^(AFGitHubAPIRequestOperation *operation, NSError *error) {
       [SVProgressHUD showErrorWithStatus:error.localizedDescription];
     }];
  }
}

#pragma mark -

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSString *after = [textField.text stringByReplacingCharactersInRange:range withString:string];
  if(textField == self.nameTextField)
    self.stubRepo.name = after;
  if(textField == self.descriptionTextField)
    self.stubRepo.repositoryDescription = after;
  [self validateForm];
  return YES;
}

@end

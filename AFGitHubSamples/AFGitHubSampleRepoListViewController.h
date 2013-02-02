//
//  AFGitHubSampleRepoListViewController.h
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  AFGitHubRepoMehtodList,
  AFGitHubRepoMehtodCreate
} AFGitHubRepoMehtod;

typedef enum {
  AFGitHubRepoOwnerMe,
  AFGitHubRepoOwnerUser,
  AFGitHubRepoOwnerOrganization,
  AFGitHubRepoOwnerAll
} AFGitHubRepoOwner;

@interface AFGitHubSampleRepoListViewController : UITableViewController

@property (nonatomic, assign) AFGitHubRepoMehtod method;
@property (nonatomic, assign) AFGitHubRepoOwner owner;

@end

//
//  AFGitHubOwnerSelectViewController.h
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFGitHubUser, AFGitHubCreateRepositoryViewController;
@interface AFGitHubOwnerSelectViewController : UITableViewController

@property (nonatomic, unsafe_unretained) AFGitHubCreateRepositoryViewController *createViewController;
@property (nonatomic, copy) AFGitHubUser *user;

@end

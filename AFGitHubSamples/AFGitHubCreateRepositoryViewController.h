//
//  AFGitHubCreateRepositoryViewController.h
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFGitHubUser, AFGitHubOrganization;
@interface AFGitHubCreateRepositoryViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (nonatomic, copy) AFGitHubUser *user;
@property (nonatomic, copy) AFGitHubOrganization *organization;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;

- (IBAction)done:(id)sender;

@end

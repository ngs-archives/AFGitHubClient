//
//  AFGitHubOrganization.h
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFGitHubAccount.h"

@interface AFGitHubOrganization : AFGitHubAccount

@property (nonatomic, copy) NSString *billingEmail;

@end


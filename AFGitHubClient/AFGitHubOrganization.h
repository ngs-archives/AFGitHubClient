//
//  AFGitHubOrganization.h
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFGitHubGitObject.h"

@interface AFGitHubOrganization : NSObject<AFGitHubObject>

- (NSString *)displayName;

@property (nonatomic, assign) NSInteger followers;
@property (nonatomic, assign) NSInteger following;
@property (nonatomic, assign) NSInteger organizationId;
@property (nonatomic, assign) NSInteger publicGists;
@property (nonatomic, assign) NSInteger publicRepos;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *blog;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *billingEmail;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy) NSURL *avatarURL;
@property (nonatomic, copy) NSURL *htmlURL;

@end

//
//  AFGitHubAccount.h
//  Octopics
//
//  Created by Atsushi Nagase on 2/3/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFGitHubObject.h"

@interface AFGitHubAccount : NSObject<AFGitHubObject>

- (NSString *)displayName;

+ (AFGitHubAccount *)accountWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, assign) NSInteger followers;
@property (nonatomic, assign) NSInteger following;
@property (nonatomic, assign) NSInteger publicRepos;
@property (nonatomic, assign) NSInteger publicGists;
@property (nonatomic, assign) NSInteger accountId;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, copy) NSString *blog;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gravatarId;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy) NSURL *avatarURL;
@property (nonatomic, copy) NSURL *htmlURL;
@property (nonatomic, copy) NSURL *eventsURL;
@property (nonatomic, copy) NSURL *followersURL;
@property (nonatomic, copy) NSURL *followingURL;
@property (nonatomic, copy) NSURL *gistsURL;
@property (nonatomic, copy) NSURL *organizationsURL;
@property (nonatomic, copy) NSURL *receivedEventsURL;
@property (nonatomic, copy) NSURL *reposURL;
@property (nonatomic, copy) NSURL *starredURL;
@property (nonatomic, copy) NSURL *subscriptionsURL;

@end

//
//  AFGitHubAccount.m
//  Octopics
//
//  Created by Atsushi Nagase on 2/3/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubAccount.h"
#import "AFGitHubGlobal.h"
#import "NSDate+InternetDateTime.h"
#import "AFGitHubUser.h"
#import "AFGitHubOrganization.h"

@implementation AFGitHubAccount

- (NSString *)displayName {
  return AFGitHubIsStringWithAnyText(self.name) ? self.name : self.login;
}

+ (AFGitHubAccount *)accountWithDictionary:(NSDictionary *)dictionary {
  if([dictionary[@"type"] isEqualToString:@"organization"]) {
    return [[AFGitHubOrganization alloc] initWithDictionary:dictionary];
  } else {
    return [[AFGitHubUser alloc] initWithDictionary:dictionary];
  }
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super init]) {
    id val = nil;
    val = dictionary[@"updated_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.updatedAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"html_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.htmlURL = [NSURL URLWithString:val];
    val = dictionary[@"location"];
    if(AFGitHubIsStringWithAnyText(val)) self.location = val;
    val = dictionary[@"followers"];
    if([val isKindOfClass:[NSNumber class]]) self.followers = [val integerValue];
    val = dictionary[@"following"];
    if([val isKindOfClass:[NSNumber class]]) self.following = [val integerValue];
    val = dictionary[@"created_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.createdAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"public_gists"];
    if([val isKindOfClass:[NSNumber class]]) self.publicGists = [val integerValue];
    val = dictionary[@"name"];
    if(AFGitHubIsStringWithAnyText(val)) self.name = val;
    val = dictionary[@"email"];
    if(AFGitHubIsStringWithAnyText(val)) self.email = val;
    val = dictionary[@"company"];
    if(AFGitHubIsStringWithAnyText(val)) self.company = val;
    val = dictionary[@"blog"];
    if(AFGitHubIsStringWithAnyText(val)) self.blog = val;
    val = dictionary[@"id"];
    if([val isKindOfClass:[NSNumber class]]) self.accountId = [val integerValue];
    val = dictionary[@"public_repos"];
    if([val isKindOfClass:[NSNumber class]]) self.publicRepos = [val integerValue];
    val = dictionary[@"login"];
    if(AFGitHubIsStringWithAnyText(val)) self.login = val;
    val = dictionary[@"url"];
    if(AFGitHubIsStringWithAnyText(val)) self.URL = [NSURL URLWithString:val];
    val = dictionary[@"organizations_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.organizationsURL = [NSURL URLWithString:val];
    val = dictionary[@"avatar_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.avatarURL = [NSURL URLWithString:val];
    val = dictionary[@"repos_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.reposURL = [NSURL URLWithString:val];
    val = dictionary[@"gists_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.gistsURL = [NSURL URLWithString:val];
    val = dictionary[@"received_events_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.receivedEventsURL = [NSURL URLWithString:val];
    val = dictionary[@"gravatar_id"];
    if(AFGitHubIsStringWithAnyText(val)) self.gravatarId = val;
    val = dictionary[@"events_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.eventsURL = [NSURL URLWithString:val];
    val = dictionary[@"followers_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.followersURL = [NSURL URLWithString:val];
    val = dictionary[@"subscriptions_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.subscriptionsURL = [NSURL URLWithString:val];
    val = dictionary[@"following_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.followingURL = [NSURL URLWithString:val];
    val = dictionary[@"starred_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.starredURL = [NSURL URLWithString:val];
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubAccount *copy = [[self.class alloc] init];
  copy.URL = self.URL;
  copy.followers = self.followers;
  copy.following = self.following;
  copy.createdAt = self.createdAt;
  copy.htmlURL = self.htmlURL;
  copy.location = self.location;
  copy.name = self.name;
  copy.email = self.email;
  copy.avatarURL = self.avatarURL;
  copy.company = self.company;
  copy.blog = self.blog;
  copy.accountId = self.accountId;
  copy.publicRepos = self.publicRepos;
  copy.publicGists = self.publicGists;
  copy.login = self.login;
  copy.organizationsURL = self.organizationsURL;
  copy.reposURL = self.reposURL;
  copy.gistsURL = self.gistsURL;
  copy.receivedEventsURL = self.receivedEventsURL;
  copy.gravatarId = self.gravatarId;
  copy.eventsURL = self.eventsURL;
  copy.followersURL = self.followersURL;
  copy.subscriptionsURL = self.subscriptionsURL;
  copy.followingURL = self.followingURL;
  copy.starredURL = self.starredURL;
  return copy;
}


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    self.updatedAt = [aDecoder decodeObjectForKey:@"updated_at"];
    self.URL = [aDecoder decodeObjectForKey:@"url"];
    self.followers = [aDecoder decodeIntegerForKey:@"followers"];
    self.following = [aDecoder decodeIntegerForKey:@"following"];
    self.createdAt = [aDecoder decodeObjectForKey:@"created_at"];
    self.htmlURL = [aDecoder decodeObjectForKey:@"html_url"];
    self.location = [aDecoder decodeObjectForKey:@"location"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.avatarURL = [aDecoder decodeObjectForKey:@"avatar_url"];
    self.company = [aDecoder decodeObjectForKey:@"company"];
    self.blog = [aDecoder decodeObjectForKey:@"blog"];
    self.accountId = [aDecoder decodeIntegerForKey:@"id"];
    self.publicRepos = [aDecoder decodeIntegerForKey:@"public_repos"];
    self.publicGists = [aDecoder decodeIntegerForKey:@"public_gists"];
    self.login = [aDecoder decodeObjectForKey:@"login"];
    self.organizationsURL = [aDecoder decodeObjectForKey:@"organizations_url"];
    self.reposURL = [aDecoder decodeObjectForKey:@"repos_url"];
    self.gistsURL = [aDecoder decodeObjectForKey:@"gists_url"];
    self.receivedEventsURL = [aDecoder decodeObjectForKey:@"received_events_url"];
    self.gravatarId = [aDecoder decodeObjectForKey:@"gravatar_id"];
    self.eventsURL = [aDecoder decodeObjectForKey:@"events_url"];
    self.followersURL = [aDecoder decodeObjectForKey:@"followers_url"];
    self.subscriptionsURL = [aDecoder decodeObjectForKey:@"subscriptions_url"];
    self.followingURL = [aDecoder decodeObjectForKey:@"following_url"];
    self.starredURL = [aDecoder decodeObjectForKey:@"starred_url"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.updatedAt forKey:@"updated_at"];
  [aCoder encodeObject:self.URL forKey:@"url"];
  [aCoder encodeInteger:self.followers forKey:@"followers"];
  [aCoder encodeInteger:self.following forKey:@"following"];
  [aCoder encodeObject:self.createdAt forKey:@"created_at"];
  [aCoder encodeObject:self.htmlURL forKey:@"html_url"];
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeObject:self.email forKey:@"email"];
  [aCoder encodeObject:self.avatarURL forKey:@"avatar_url"];
  [aCoder encodeObject:self.company forKey:@"company"];
  [aCoder encodeObject:self.blog forKey:@"blog"];
  [aCoder encodeInteger:self.accountId forKey:@"id"];
  [aCoder encodeInteger:self.publicRepos forKey:@"public_repos"];
  [aCoder encodeInteger:self.publicGists forKey:@"public_gists"];
  [aCoder encodeObject:self.login forKey:@"login"];
  [aCoder encodeObject:self.organizationsURL forKey:@"organizations_url"];
  [aCoder encodeObject:self.reposURL forKey:@"repos_url"];
  [aCoder encodeObject:self.gistsURL forKey:@"gists_url"];
  [aCoder encodeObject:self.location forKey:@"location"];
  [aCoder encodeObject:self.receivedEventsURL forKey:@"received_events_url"];
  [aCoder encodeObject:self.gravatarId forKey:@"gravatar_id"];
  [aCoder encodeObject:self.eventsURL forKey:@"events_url"];
  [aCoder encodeObject:self.followersURL forKey:@"followers_url"];
  [aCoder encodeObject:self.subscriptionsURL forKey:@"subscriptions_url"];
  [aCoder encodeObject:self.followingURL forKey:@"following_url"];
  [aCoder encodeObject:self.starredURL forKey:@"starred_url"];
}

@end

//
//  AFGitHubOrganization.m
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubOrganization.h"
#import "AFGitHubGlobal.h"
#import "NSDate+InternetDateTime.h"

@implementation AFGitHubOrganization

- (NSString *)displayName {
  return AFGitHubIsStringWithAnyText(self.name) ? self.name : self.login;
}

- (NSDictionary *)asJSON {
  NSMutableDictionary *buf = @{}.mutableCopy;
  if(AFGitHubIsStringWithAnyText(self.billingEmail))
    buf[@"billing_email"] = self.billingEmail;
  if(AFGitHubIsStringWithAnyText(self.company))
    buf[@"company"] = self.company;
  if(AFGitHubIsStringWithAnyText(self.email))
    buf[@"email"] = self.email;
  if(AFGitHubIsStringWithAnyText(self.name))
    buf[@"name"] = self.name;
  if(AFGitHubIsStringWithAnyText(self.blog))
    buf[@"blog"] = self.blog;
  if(AFGitHubIsStringWithAnyText(self.location))
    buf[@"location"] = self.location;
  return buf.copy;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super init]) {
    id val = nil;
    val = dictionary[@"login"];
    if(AFGitHubIsStringWithAnyText(val)) self.login = val;
    val = dictionary[@"id"];
    if([val isKindOfClass:[NSNumber class]]) self.organizationId = [val integerValue];
    val = dictionary[@"url"];
    if(AFGitHubIsStringWithAnyText(val)) self.URL = [NSURL URLWithString:val];
    val = dictionary[@"avatar_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.avatarURL = [NSURL URLWithString:val];
    val = dictionary[@"name"];
    if(AFGitHubIsStringWithAnyText(val)) self.name = val;
    val = dictionary[@"company"];
    if(AFGitHubIsStringWithAnyText(val)) self.company = val;
    val = dictionary[@"blog"];
    if(AFGitHubIsStringWithAnyText(val)) self.blog = val;
    val = dictionary[@"location"];
    if(AFGitHubIsStringWithAnyText(val)) self.location = val;
    val = dictionary[@"email"];
    if(AFGitHubIsStringWithAnyText(val)) self.email = val;
    val = dictionary[@"public_repos"];
    if([val isKindOfClass:[NSNumber class]]) self.publicRepos = [val integerValue];
    val = dictionary[@"public_gists"];
    if([val isKindOfClass:[NSNumber class]]) self.publicGists = [val integerValue];
    val = dictionary[@"followers"];
    if([val isKindOfClass:[NSNumber class]]) self.followers = [val integerValue];
    val = dictionary[@"following"];
    if([val isKindOfClass:[NSNumber class]]) self.following = [val integerValue];
    val = dictionary[@"html_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.htmlURL = [NSURL URLWithString:val];
    val = dictionary[@"created_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.createdAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"type"];
    if(AFGitHubIsStringWithAnyText(val)) self.type = val;
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubOrganization *copy = [[self.class alloc] init];
  copy.login = self.login;
  copy.organizationId = self.organizationId;
  copy.URL = self.URL;
  copy.avatarURL = self.avatarURL;
  copy.name = self.name;
  copy.company = self.company;
  copy.blog = self.blog;
  copy.location = self.location;
  copy.email = self.email;
  copy.publicRepos = self.publicRepos;
  copy.publicGists = self.publicGists;
  copy.followers = self.followers;
  copy.following = self.following;
  copy.htmlURL = self.htmlURL;
  copy.createdAt = self.createdAt;
  copy.type = self.type;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    self.login = [aDecoder decodeObjectForKey:@"login"];
    self.organizationId = [aDecoder decodeIntegerForKey:@"id"];
    self.URL = [aDecoder decodeObjectForKey:@"url"];
    self.avatarURL = [aDecoder decodeObjectForKey:@"avatar_url"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.company = [aDecoder decodeObjectForKey:@"company"];
    self.blog = [aDecoder decodeObjectForKey:@"blog"];
    self.location = [aDecoder decodeObjectForKey:@"location"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.billingEmail = [aDecoder decodeObjectForKey:@"billing_email"];
    self.publicRepos = [aDecoder decodeIntegerForKey:@"public_repos"];
    self.publicGists = [aDecoder decodeIntegerForKey:@"public_gists"];
    self.followers = [aDecoder decodeIntegerForKey:@"followers"];
    self.following = [aDecoder decodeIntegerForKey:@"following"];
    self.htmlURL = [aDecoder decodeObjectForKey:@"html_url"];
    self.createdAt = [aDecoder decodeObjectForKey:@"created_at"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.login forKey:@"login"];
  [aCoder encodeInteger:self.organizationId forKey:@"id"];
  [aCoder encodeObject:self.URL forKey:@"url"];
  [aCoder encodeObject:self.avatarURL forKey:@"avatar_url"];
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeObject:self.company forKey:@"company"];
  [aCoder encodeObject:self.blog forKey:@"blog"];
  [aCoder encodeObject:self.location forKey:@"location"];
  [aCoder encodeObject:self.email forKey:@"email"];
  [aCoder encodeObject:self.billingEmail forKey:@"billing_email"];
  [aCoder encodeInteger:self.publicRepos forKey:@"public_repos"];
  [aCoder encodeInteger:self.publicGists forKey:@"public_gists"];
  [aCoder encodeInteger:self.followers forKey:@"followers"];
  [aCoder encodeInteger:self.following forKey:@"following"];
  [aCoder encodeObject:self.htmlURL forKey:@"html_url"];
  [aCoder encodeObject:self.createdAt forKey:@"created_at"];
  [aCoder encodeObject:self.type forKey:@"type"];
}



@end

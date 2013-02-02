//
//  AFGitHubUser.m
//
//  Copyright (c) 2012 Atsushi Nagase (http://ngs.io/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "AFGitHubUser.h"
#import "AFGitHubGlobal.h"
#import "NSDate+InternetDateTime.h"

@implementation AFGitHubUser


#pragma mark - Initializing

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super init]) {
    id val = nil;
    val = dictionary[@"updated_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.updatedAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"bio"];
    if(AFGitHubIsStringWithAnyText(val)) self.bio = val;
    val = dictionary[@"type"];
    if(AFGitHubIsStringWithAnyText(val)) self.type = val;
    val = dictionary[@"url"];
    if(AFGitHubIsStringWithAnyText(val)) self.URL = [NSURL URLWithString:val];
    val = dictionary[@"organizations_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.organizationsURL = [NSURL URLWithString:val];
    val = dictionary[@"repos_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.reposURL = [NSURL URLWithString:val];
    val = dictionary[@"gists_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.gistsURL = [NSURL URLWithString:val];
    val = dictionary[@"followers"];
    if([val isKindOfClass:[NSNumber class]]) self.followers = [val integerValue];
    val = dictionary[@"following"];
    if([val isKindOfClass:[NSNumber class]]) self.following = [val integerValue];
    val = dictionary[@"created_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.createdAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"html_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.htmlURL = [NSURL URLWithString:val];
    val = dictionary[@"location"];
    if(AFGitHubIsStringWithAnyText(val)) self.location = val;
    val = dictionary[@"received_events_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.receivedEventsURL = [NSURL URLWithString:val];
    val = dictionary[@"gravatar_id"];
    if(AFGitHubIsStringWithAnyText(val)) self.gravatarId = val;
    val = dictionary[@"events_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.eventsURL = [NSURL URLWithString:val];
    val = dictionary[@"followers_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.followersURL = [NSURL URLWithString:val];
    val = dictionary[@"name"];
    if(AFGitHubIsStringWithAnyText(val)) self.name = val;
    val = dictionary[@"email"];
    if(AFGitHubIsStringWithAnyText(val)) self.email = val;
    val = dictionary[@"subscriptions_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.subscriptionsURL = [NSURL URLWithString:val];
    val = dictionary[@"following_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.followingURL = [NSURL URLWithString:val];
    val = dictionary[@"avatar_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.avatarURL = [NSURL URLWithString:val];
    val = dictionary[@"public_gists"];
    if([val isKindOfClass:[NSNumber class]]) self.publicGists = [val integerValue];
    val = dictionary[@"company"];
    if(AFGitHubIsStringWithAnyText(val)) self.company = val;
    val = dictionary[@"blog"];
    if(AFGitHubIsStringWithAnyText(val)) self.blog = val;
    val = dictionary[@"hireable"];
    if([val isKindOfClass:[NSNumber class]]) self.isHireable = [val boolValue];
    val = dictionary[@"starred_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.starredURL = [NSURL URLWithString:val];
    val = dictionary[@"id"];
    if([val isKindOfClass:[NSNumber class]]) self.userId = [val integerValue];
    val = dictionary[@"public_repos"];
    if([val isKindOfClass:[NSNumber class]]) self.publicRepos = [val integerValue];
    val = dictionary[@"login"];
    if(AFGitHubIsStringWithAnyText(val)) self.login = val;
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubUser *copy = [[self.class alloc] init];
  copy.updatedAt = self.updatedAt;
  copy.bio = self.bio;
  copy.type = self.type;
  copy.URL = self.URL;
  copy.organizationsURL = self.organizationsURL;
  copy.reposURL = self.reposURL;
  copy.gistsURL = self.gistsURL;
  copy.followers = self.followers;
  copy.following = self.following;
  copy.createdAt = self.createdAt;
  copy.htmlURL = self.htmlURL;
  copy.location = self.location;
  copy.receivedEventsURL = self.receivedEventsURL;
  copy.gravatarId = self.gravatarId;
  copy.eventsURL = self.eventsURL;
  copy.followersURL = self.followersURL;
  copy.name = self.name;
  copy.email = self.email;
  copy.subscriptionsURL = self.subscriptionsURL;
  copy.followingURL = self.followingURL;
  copy.avatarURL = self.avatarURL;
  copy.publicGists = self.publicGists;
  copy.company = self.company;
  copy.blog = self.blog;
  copy.isHireable = self.isHireable;
  copy.starredURL = self.starredURL;
  copy.userId = self.userId;
  copy.publicRepos = self.publicRepos;
  copy.login = self.login;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    self.updatedAt = [aDecoder decodeObjectForKey:@"updated_at"];
    self.bio = [aDecoder decodeObjectForKey:@"bio"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.URL = [aDecoder decodeObjectForKey:@"url"];
    self.organizationsURL = [aDecoder decodeObjectForKey:@"organizations_url"];
    self.reposURL = [aDecoder decodeObjectForKey:@"repos_url"];
    self.gistsURL = [aDecoder decodeObjectForKey:@"gists_url"];
    self.followers = [aDecoder decodeIntegerForKey:@"followers"];
    self.following = [aDecoder decodeIntegerForKey:@"following"];
    self.createdAt = [aDecoder decodeObjectForKey:@"created_at"];
    self.htmlURL = [aDecoder decodeObjectForKey:@"html_url"];
    self.location = [aDecoder decodeObjectForKey:@"location"];
    self.receivedEventsURL = [aDecoder decodeObjectForKey:@"received_events_url"];
    self.gravatarId = [aDecoder decodeObjectForKey:@"gravatar_id"];
    self.eventsURL = [aDecoder decodeObjectForKey:@"events_url"];
    self.followersURL = [aDecoder decodeObjectForKey:@"followers_url"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    self.subscriptionsURL = [aDecoder decodeObjectForKey:@"subscriptions_url"];
    self.followingURL = [aDecoder decodeObjectForKey:@"following_url"];
    self.avatarURL = [aDecoder decodeObjectForKey:@"avatar_url"];
    self.publicGists = [aDecoder decodeIntegerForKey:@"public_gists"];
    self.company = [aDecoder decodeObjectForKey:@"company"];
    self.blog = [aDecoder decodeObjectForKey:@"blog"];
    self.isHireable = [aDecoder decodeBoolForKey:@"hireable"];
    self.starredURL = [aDecoder decodeObjectForKey:@"starred_url"];
    self.userId = [aDecoder decodeIntegerForKey:@"id"];
    self.publicRepos = [aDecoder decodeIntegerForKey:@"public_repos"];
    self.login = [aDecoder decodeObjectForKey:@"login"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.updatedAt forKey:@"updated_at"];
  [aCoder encodeObject:self.bio forKey:@"bio"];
  [aCoder encodeObject:self.type forKey:@"type"];
  [aCoder encodeObject:self.URL forKey:@"url"];
  [aCoder encodeObject:self.organizationsURL forKey:@"organizations_url"];
  [aCoder encodeObject:self.reposURL forKey:@"repos_url"];
  [aCoder encodeObject:self.gistsURL forKey:@"gists_url"];
  [aCoder encodeInteger:self.followers forKey:@"followers"];
  [aCoder encodeInteger:self.following forKey:@"following"];
  [aCoder encodeObject:self.createdAt forKey:@"created_at"];
  [aCoder encodeObject:self.htmlURL forKey:@"html_url"];
  [aCoder encodeObject:self.location forKey:@"location"];
  [aCoder encodeObject:self.receivedEventsURL forKey:@"received_events_url"];
  [aCoder encodeObject:self.gravatarId forKey:@"gravatar_id"];
  [aCoder encodeObject:self.eventsURL forKey:@"events_url"];
  [aCoder encodeObject:self.followersURL forKey:@"followers_url"];
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeObject:self.email forKey:@"email"];
  [aCoder encodeObject:self.subscriptionsURL forKey:@"subscriptions_url"];
  [aCoder encodeObject:self.followingURL forKey:@"following_url"];
  [aCoder encodeObject:self.avatarURL forKey:@"avatar_url"];
  [aCoder encodeInteger:self.publicGists forKey:@"public_gists"];
  [aCoder encodeObject:self.company forKey:@"company"];
  [aCoder encodeObject:self.blog forKey:@"blog"];
  [aCoder encodeBool:self.isHireable forKey:@"hireable"];
  [aCoder encodeObject:self.starredURL forKey:@"starred_url"];
  [aCoder encodeInteger:self.userId forKey:@"id"];
  [aCoder encodeInteger:self.publicRepos forKey:@"public_repos"];
  [aCoder encodeObject:self.login forKey:@"login"];
}

@end

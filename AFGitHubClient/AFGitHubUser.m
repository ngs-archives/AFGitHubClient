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

@implementation AFGitHubUser


#pragma mark - Initializing

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super init]) {
    id val = nil;
    val = dictionary[@"starred_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.starredURL = [NSURL URLWithString:val];
    val = dictionary[@"gravatar_id"];
    if(AFGitHubIsStringWithAnyText(val)) self.gravatarId = val;
    val = dictionary[@"avatar_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.avatarURL = [NSURL URLWithString:val];
    val = dictionary[@"repos_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.reposURL = [NSURL URLWithString:val];
    val = dictionary[@"subscriptions_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.subscriptionsURL = [NSURL URLWithString:val];
    val = dictionary[@"login"];
    if(AFGitHubIsStringWithAnyText(val)) self.login = val;
    val = dictionary[@"organizations_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.organizationsURL = [NSURL URLWithString:val];
    val = dictionary[@"gists_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.gistsURL = [NSURL URLWithString:val];
    val = dictionary[@"followers_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.followersURL = [NSURL URLWithString:val];
    val = dictionary[@"following_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.followingURL = [NSURL URLWithString:val];
    val = dictionary[@"url"];
    if(AFGitHubIsStringWithAnyText(val)) self.URL = [NSURL URLWithString:val];
    val = dictionary[@"id"];
    if([val isKindOfClass:[NSNumber class]]) self.userId = [val integerValue];
    val = dictionary[@"received_events_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.receivedEventsURL = [NSURL URLWithString:val];
    val = dictionary[@"type"];
    if(AFGitHubIsStringWithAnyText(val)) self.type = val;
    val = dictionary[@"events_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.eventsURL = [NSURL URLWithString:val];
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubUser *copy = [[self.class alloc] init];
  copy.starredURL = self.starredURL;
  copy.gravatarId = self.gravatarId;
  copy.avatarURL = self.avatarURL;
  copy.reposURL = self.reposURL;
  copy.subscriptionsURL = self.subscriptionsURL;
  copy.login = self.login;
  copy.organizationsURL = self.organizationsURL;
  copy.gistsURL = self.gistsURL;
  copy.followersURL = self.followersURL;
  copy.followingURL = self.followingURL;
  copy.URL = self.URL;
  copy.userId = self.userId;
  copy.receivedEventsURL = self.receivedEventsURL;
  copy.type = self.type;
  copy.eventsURL = self.eventsURL;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    self.starredURL = [aDecoder decodeObjectForKey:@"starred_url"];
    self.gravatarId = [aDecoder decodeObjectForKey:@"gravatar_id"];
    self.avatarURL = [aDecoder decodeObjectForKey:@"avatar_url"];
    self.reposURL = [aDecoder decodeObjectForKey:@"repos_url"];
    self.subscriptionsURL = [aDecoder decodeObjectForKey:@"subscriptions_url"];
    self.login = [aDecoder decodeObjectForKey:@"login"];
    self.organizationsURL = [aDecoder decodeObjectForKey:@"organizations_url"];
    self.gistsURL = [aDecoder decodeObjectForKey:@"gists_url"];
    self.followersURL = [aDecoder decodeObjectForKey:@"followers_url"];
    self.followingURL = [aDecoder decodeObjectForKey:@"following_url"];
    self.URL = [aDecoder decodeObjectForKey:@"url"];
    self.userId = [aDecoder decodeIntegerForKey:@"id"];
    self.receivedEventsURL = [aDecoder decodeObjectForKey:@"received_events_url"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.eventsURL = [aDecoder decodeObjectForKey:@"events_url"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.starredURL forKey:@"starred_url"];
  [aCoder encodeObject:self.gravatarId forKey:@"gravatar_id"];
  [aCoder encodeObject:self.avatarURL forKey:@"avatar_url"];
  [aCoder encodeObject:self.reposURL forKey:@"repos_url"];
  [aCoder encodeObject:self.subscriptionsURL forKey:@"subscriptions_url"];
  [aCoder encodeObject:self.login forKey:@"login"];
  [aCoder encodeObject:self.organizationsURL forKey:@"organizations_url"];
  [aCoder encodeObject:self.gistsURL forKey:@"gists_url"];
  [aCoder encodeObject:self.followersURL forKey:@"followers_url"];
  [aCoder encodeObject:self.followingURL forKey:@"following_url"];
  [aCoder encodeObject:self.URL forKey:@"url"];
  [aCoder encodeInteger:self.userId forKey:@"id"];
  [aCoder encodeObject:self.receivedEventsURL forKey:@"received_events_url"];
  [aCoder encodeObject:self.type forKey:@"type"];
  [aCoder encodeObject:self.eventsURL forKey:@"events_url"];
}

@end

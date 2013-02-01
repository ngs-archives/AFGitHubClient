//
//  AFGitHubRepository.m
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

#import "AFGitHubRepository.h"
#import "AFGitHubGlobal.h"
#import "NSDate+InternetDateTime.h"
#import "AFGitHubUser.h"

@implementation AFGitHubRepository

#pragma mark -

- (BOOL)pushPermission {
  return [self.permissions isKindOfClass:[NSDictionary class]] &&
  AFGitHubIsStringWithAnyText(self.permissions[@"push"]) &&
  [self.permissions[@"push"] boolValue];
  
}

- (BOOL)adminPermission {
  return [self.permissions isKindOfClass:[NSDictionary class]] &&
  AFGitHubIsStringWithAnyText(self.permissions[@"admin"]) &&
  [self.permissions[@"admin"] boolValue];
}

- (BOOL)pullPermission {
  return [self.permissions isKindOfClass:[NSDictionary class]] &&
  AFGitHubIsStringWithAnyText(self.permissions[@"pull"]) &&
  [self.permissions[@"pull"] boolValue];
}

- (NSDictionary *)asJSON {
  NSMutableDictionary *buf = @{}.mutableCopy;
  
  
  return buf.copy;
}


#pragma mark - Initializing

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super init]) {
    id val = nil;
    val = dictionary[@"created_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.createdAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"homepage"];
    if(AFGitHubIsStringWithAnyText(val)) self.homepage = val;
    val = dictionary[@"comments_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.commentsURL = [NSURL URLWithString:val];
    val = dictionary[@"subscribers_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.subscribersURL = [NSURL URLWithString:val];
    val = dictionary[@"contributors_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.contributorsURL = [NSURL URLWithString:val];
    val = dictionary[@"collaborators_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.collaboratorsURL = [NSURL URLWithString:val];
    val = dictionary[@"network_count"];
    if([val isKindOfClass:[NSNumber class]]) self.networkCount = [val integerValue];
    val = dictionary[@"pulls_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.pullsURL = [NSURL URLWithString:val];
    val = dictionary[@"issue_comment_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.issueCommentURL = [NSURL URLWithString:val];
    val = dictionary[@"blobs_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.blobsURL = [NSURL URLWithString:val];
    val = dictionary[@"owner"];
    if([val isKindOfClass:[NSDictionary class]]) self.owner = [[AFGitHubUser alloc] initWithDictionary:val];
    val = dictionary[@"permissions"];
    if([val isKindOfClass:[NSDictionary class]]) self.permissions = val;
    val = dictionary[@"ssh_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.sshURL = [NSURL URLWithString:val];
    val = dictionary[@"subscription_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.subscriptionURL = [NSURL URLWithString:val];
    val = dictionary[@"teams_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.teamsURL = [NSURL URLWithString:val];
    val = dictionary[@"git_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.gitURL = [NSURL URLWithString:val];
    val = dictionary[@"clone_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.cloneURL = [NSURL URLWithString:val];
    val = dictionary[@"labels_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.labelsURL = [NSURL URLWithString:val];
    val = dictionary[@"git_tags_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.gitTagsURL = [NSURL URLWithString:val];
    val = dictionary[@"url"];
    if(AFGitHubIsStringWithAnyText(val)) self.URL = [NSURL URLWithString:val];
    val = dictionary[@"description"];
    if(AFGitHubIsStringWithAnyText(val)) self.repositoryDescription = val;
    val = dictionary[@"issues_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.issuesURL = [NSURL URLWithString:val];
    val = dictionary[@"git_commits_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.gitCommitsURL = [NSURL URLWithString:val];
    val = dictionary[@"commits_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.commitsURL = [NSURL URLWithString:val];
    val = dictionary[@"hooks_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.hooksURL = [NSURL URLWithString:val];
    val = dictionary[@"updated_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.updatedAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"pushed_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.pushedAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"watchers_count"];
    if([val isKindOfClass:[NSNumber class]]) self.watchersCount = [val integerValue];
    val = dictionary[@"language"];
    if(AFGitHubIsStringWithAnyText(val)) self.language = val;
    val = dictionary[@"open_issues_count"];
    if([val isKindOfClass:[NSNumber class]]) self.openIssuesCount = [val integerValue];
    val = dictionary[@"milestones_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.milestonesURL = [NSURL URLWithString:val];
    val = dictionary[@"downloads_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.downloadsURL = [NSURL URLWithString:val];
    val = dictionary[@"git_refs_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.gitRefsURL = [NSURL URLWithString:val];
    val = dictionary[@"tags_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.tagsURL = [NSURL URLWithString:val];
    val = dictionary[@"events_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.eventsURL = [NSURL URLWithString:val];
    val = dictionary[@"has_downloads"];
    if([val isKindOfClass:[NSNumber class]]) self.hasDownloads = [val boolValue];
    val = dictionary[@"compare_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.compareURL = [NSURL URLWithString:val];
    val = dictionary[@"contents_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.contentsURL = [NSURL URLWithString:val];
    val = dictionary[@"issue_events_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.issueEventsURL = [NSURL URLWithString:val];
    val = dictionary[@"size"];
    if([val isKindOfClass:[NSNumber class]]) self.size = [val integerValue];
    val = dictionary[@"has_issues"];
    if([val isKindOfClass:[NSNumber class]]) self.hasIssues = [val boolValue];
    val = dictionary[@"mirror_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.mirrorURL = [NSURL URLWithString:val];
    val = dictionary[@"languages_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.languagesURL = [NSURL URLWithString:val];
    val = dictionary[@"trees_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.treesURL = [NSURL URLWithString:val];
    val = dictionary[@"forks_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.forksURL = [NSURL URLWithString:val];
    val = dictionary[@"fork"];
    if([val isKindOfClass:[NSNumber class]]) self.isFork = [val boolValue];
    val = dictionary[@"master_branch"];
    if(AFGitHubIsStringWithAnyText(val)) self.masterBranch = val;
    val = dictionary[@"merges_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.mergesURL = [NSURL URLWithString:val];
    val = dictionary[@"assignees_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.assigneesURL = [NSURL URLWithString:val];
    val = dictionary[@"name"];
    if(AFGitHubIsStringWithAnyText(val)) self.name = val;
    val = dictionary[@"svn_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.svnURL = [NSURL URLWithString:val];
    val = dictionary[@"statuses_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.statusesURL = [NSURL URLWithString:val];
    val = dictionary[@"keys_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.keysURL = [NSURL URLWithString:val];
    val = dictionary[@"html_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.htmlURL = [NSURL URLWithString:val];
    val = dictionary[@"private"];
    if([val isKindOfClass:[NSNumber class]]) self.isPrivate = [val boolValue];
    val = dictionary[@"full_name"];
    if(AFGitHubIsStringWithAnyText(val)) self.fullName = val;
    val = dictionary[@"id"];
    if([val isKindOfClass:[NSNumber class]]) self.repositoryId = [val integerValue];
    val = dictionary[@"has_wiki"];
    if([val isKindOfClass:[NSNumber class]]) self.hasWiki = [val boolValue];
    val = dictionary[@"forks_count"];
    if([val isKindOfClass:[NSNumber class]]) self.forksCount = [val integerValue];
    val = dictionary[@"notifications_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.notificationsURL = [NSURL URLWithString:val];
    val = dictionary[@"archive_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.archiveURL = [NSURL URLWithString:val];
    val = dictionary[@"stargazers_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.stargazersURL = [NSURL URLWithString:val];
    val = dictionary[@"branches_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.branchesURL = [NSURL URLWithString:val];
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubRepository *copy = [[self.class alloc] init];
  copy.createdAt = self.createdAt;
  copy.homepage = self.homepage;
  copy.commentsURL = self.commentsURL;
  copy.subscribersURL = self.subscribersURL;
  copy.contributorsURL = self.contributorsURL;
  copy.collaboratorsURL = self.collaboratorsURL;
  copy.networkCount = self.networkCount;
  copy.pullsURL = self.pullsURL;
  copy.issueCommentURL = self.issueCommentURL;
  copy.blobsURL = self.blobsURL;
  copy.owner = self.owner;
  copy.permissions = self.permissions;
  copy.sshURL = self.sshURL;
  copy.subscriptionURL = self.subscriptionURL;
  copy.teamsURL = self.teamsURL;
  copy.gitURL = self.gitURL;
  copy.cloneURL = self.cloneURL;
  copy.labelsURL = self.labelsURL;
  copy.gitTagsURL = self.gitTagsURL;
  copy.URL = self.URL;
  copy.repositoryDescription = self.repositoryDescription;
  copy.issuesURL = self.issuesURL;
  copy.gitCommitsURL = self.gitCommitsURL;
  copy.commitsURL = self.commitsURL;
  copy.hooksURL = self.hooksURL;
  copy.updatedAt = self.updatedAt;
  copy.pushedAt = self.pushedAt;
  copy.watchersCount = self.watchersCount;
  copy.language = self.language;
  copy.openIssuesCount = self.openIssuesCount;
  copy.milestonesURL = self.milestonesURL;
  copy.downloadsURL = self.downloadsURL;
  copy.gitRefsURL = self.gitRefsURL;
  copy.tagsURL = self.tagsURL;
  copy.eventsURL = self.eventsURL;
  copy.hasDownloads = self.hasDownloads;
  copy.compareURL = self.compareURL;
  copy.contentsURL = self.contentsURL;
  copy.issueEventsURL = self.issueEventsURL;
  copy.size = self.size;
  copy.hasIssues = self.hasIssues;
  copy.mirrorURL = self.mirrorURL;
  copy.languagesURL = self.languagesURL;
  copy.treesURL = self.treesURL;
  copy.forksURL = self.forksURL;
  copy.isFork = self.isFork;
  copy.masterBranch = self.masterBranch;
  copy.mergesURL = self.mergesURL;
  copy.assigneesURL = self.assigneesURL;
  copy.name = self.name;
  copy.svnURL = self.svnURL;
  copy.statusesURL = self.statusesURL;
  copy.keysURL = self.keysURL;
  copy.htmlURL = self.htmlURL;
  copy.isPrivate = self.isPrivate;
  copy.fullName = self.fullName;
  copy.repositoryId = self.repositoryId;
  copy.hasWiki = self.hasWiki;
  copy.forksCount = self.forksCount;
  copy.notificationsURL = self.notificationsURL;
  copy.archiveURL = self.archiveURL;
  copy.stargazersURL = self.stargazersURL;
  copy.branchesURL = self.branchesURL;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    self.createdAt = [aDecoder decodeObjectForKey:@"created_at"];
    self.homepage = [aDecoder decodeObjectForKey:@"homepage"];
    self.commentsURL = [aDecoder decodeObjectForKey:@"comments_url"];
    self.subscribersURL = [aDecoder decodeObjectForKey:@"subscribers_url"];
    self.contributorsURL = [aDecoder decodeObjectForKey:@"contributors_url"];
    self.collaboratorsURL = [aDecoder decodeObjectForKey:@"collaborators_url"];
    self.networkCount = [aDecoder decodeIntegerForKey:@"network_count"];
    self.pullsURL = [aDecoder decodeObjectForKey:@"pulls_url"];
    self.issueCommentURL = [aDecoder decodeObjectForKey:@"issue_comment_url"];
    self.blobsURL = [aDecoder decodeObjectForKey:@"blobs_url"];
    self.owner = [aDecoder decodeObjectForKey:@"owner"];
    self.permissions = [aDecoder decodeObjectForKey:@"permissions"];
    self.sshURL = [aDecoder decodeObjectForKey:@"ssh_url"];
    self.subscriptionURL = [aDecoder decodeObjectForKey:@"subscription_url"];
    self.teamsURL = [aDecoder decodeObjectForKey:@"teams_url"];
    self.gitURL = [aDecoder decodeObjectForKey:@"git_url"];
    self.cloneURL = [aDecoder decodeObjectForKey:@"clone_url"];
    self.labelsURL = [aDecoder decodeObjectForKey:@"labels_url"];
    self.gitTagsURL = [aDecoder decodeObjectForKey:@"git_tags_url"];
    self.URL = [aDecoder decodeObjectForKey:@"url"];
    self.repositoryDescription = [aDecoder decodeObjectForKey:@"description"];
    self.issuesURL = [aDecoder decodeObjectForKey:@"issues_url"];
    self.gitCommitsURL = [aDecoder decodeObjectForKey:@"git_commits_url"];
    self.commitsURL = [aDecoder decodeObjectForKey:@"commits_url"];
    self.hooksURL = [aDecoder decodeObjectForKey:@"hooks_url"];
    self.updatedAt = [aDecoder decodeObjectForKey:@"updated_at"];
    self.pushedAt = [aDecoder decodeObjectForKey:@"pushed_at"];
    self.watchersCount = [aDecoder decodeIntegerForKey:@"watchers_count"];
    self.language = [aDecoder decodeObjectForKey:@"language"];
    self.openIssuesCount = [aDecoder decodeIntegerForKey:@"open_issues_count"];
    self.milestonesURL = [aDecoder decodeObjectForKey:@"milestones_url"];
    self.downloadsURL = [aDecoder decodeObjectForKey:@"downloads_url"];
    self.gitRefsURL = [aDecoder decodeObjectForKey:@"git_refs_url"];
    self.tagsURL = [aDecoder decodeObjectForKey:@"tags_url"];
    self.eventsURL = [aDecoder decodeObjectForKey:@"events_url"];
    self.hasDownloads = [aDecoder decodeBoolForKey:@"has_downloads"];
    self.compareURL = [aDecoder decodeObjectForKey:@"compare_url"];
    self.contentsURL = [aDecoder decodeObjectForKey:@"contents_url"];
    self.issueEventsURL = [aDecoder decodeObjectForKey:@"issue_events_url"];
    self.size = [aDecoder decodeIntegerForKey:@"size"];
    self.hasIssues = [aDecoder decodeBoolForKey:@"has_issues"];
    self.mirrorURL = [aDecoder decodeObjectForKey:@"mirror_url"];
    self.languagesURL = [aDecoder decodeObjectForKey:@"languages_url"];
    self.treesURL = [aDecoder decodeObjectForKey:@"trees_url"];
    self.forksURL = [aDecoder decodeObjectForKey:@"forks_url"];
    self.isFork = [aDecoder decodeBoolForKey:@"fork"];
    self.masterBranch = [aDecoder decodeObjectForKey:@"master_branch"];
    self.mergesURL = [aDecoder decodeObjectForKey:@"merges_url"];
    self.assigneesURL = [aDecoder decodeObjectForKey:@"assignees_url"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.svnURL = [aDecoder decodeObjectForKey:@"svn_url"];
    self.statusesURL = [aDecoder decodeObjectForKey:@"statuses_url"];
    self.keysURL = [aDecoder decodeObjectForKey:@"keys_url"];
    self.htmlURL = [aDecoder decodeObjectForKey:@"html_url"];
    self.isPrivate = [aDecoder decodeBoolForKey:@"private"];
    self.fullName = [aDecoder decodeObjectForKey:@"full_name"];
    self.repositoryId = [aDecoder decodeIntegerForKey:@"id"];
    self.hasWiki = [aDecoder decodeBoolForKey:@"has_wiki"];
    self.forksCount = [aDecoder decodeIntegerForKey:@"forks_count"];
    self.notificationsURL = [aDecoder decodeObjectForKey:@"notifications_url"];
    self.archiveURL = [aDecoder decodeObjectForKey:@"archive_url"];
    self.stargazersURL = [aDecoder decodeObjectForKey:@"stargazers_url"];
    self.branchesURL = [aDecoder decodeObjectForKey:@"branches_url"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.createdAt forKey:@"created_at"];
  [aCoder encodeObject:self.homepage forKey:@"homepage"];
  [aCoder encodeObject:self.commentsURL forKey:@"comments_url"];
  [aCoder encodeObject:self.subscribersURL forKey:@"subscribers_url"];
  [aCoder encodeObject:self.contributorsURL forKey:@"contributors_url"];
  [aCoder encodeObject:self.collaboratorsURL forKey:@"collaborators_url"];
  [aCoder encodeInteger:self.networkCount forKey:@"network_count"];
  [aCoder encodeObject:self.pullsURL forKey:@"pulls_url"];
  [aCoder encodeObject:self.issueCommentURL forKey:@"issue_comment_url"];
  [aCoder encodeObject:self.blobsURL forKey:@"blobs_url"];
  [aCoder encodeObject:self.owner forKey:@"owner"];
  [aCoder encodeObject:self.permissions forKey:@"permissions"];
  [aCoder encodeObject:self.sshURL forKey:@"ssh_url"];
  [aCoder encodeObject:self.subscriptionURL forKey:@"subscription_url"];
  [aCoder encodeObject:self.teamsURL forKey:@"teams_url"];
  [aCoder encodeObject:self.gitURL forKey:@"git_url"];
  [aCoder encodeObject:self.cloneURL forKey:@"clone_url"];
  [aCoder encodeObject:self.labelsURL forKey:@"labels_url"];
  [aCoder encodeObject:self.gitTagsURL forKey:@"git_tags_url"];
  [aCoder encodeObject:self.URL forKey:@"url"];
  [aCoder encodeObject:self.repositoryDescription forKey:@"description"];
  [aCoder encodeObject:self.issuesURL forKey:@"issues_url"];
  [aCoder encodeObject:self.gitCommitsURL forKey:@"git_commits_url"];
  [aCoder encodeObject:self.commitsURL forKey:@"commits_url"];
  [aCoder encodeObject:self.hooksURL forKey:@"hooks_url"];
  [aCoder encodeObject:self.updatedAt forKey:@"updated_at"];
  [aCoder encodeObject:self.pushedAt forKey:@"pushed_at"];
  [aCoder encodeInteger:self.watchersCount forKey:@"watchers_count"];
  [aCoder encodeObject:self.language forKey:@"language"];
  [aCoder encodeInteger:self.openIssuesCount forKey:@"open_issues_count"];
  [aCoder encodeObject:self.milestonesURL forKey:@"milestones_url"];
  [aCoder encodeObject:self.downloadsURL forKey:@"downloads_url"];
  [aCoder encodeObject:self.gitRefsURL forKey:@"git_refs_url"];
  [aCoder encodeObject:self.tagsURL forKey:@"tags_url"];
  [aCoder encodeObject:self.eventsURL forKey:@"events_url"];
  [aCoder encodeBool:self.hasDownloads forKey:@"has_downloads"];
  [aCoder encodeObject:self.compareURL forKey:@"compare_url"];
  [aCoder encodeObject:self.contentsURL forKey:@"contents_url"];
  [aCoder encodeObject:self.issueEventsURL forKey:@"issue_events_url"];
  [aCoder encodeInteger:self.size forKey:@"size"];
  [aCoder encodeBool:self.hasIssues forKey:@"has_issues"];
  [aCoder encodeObject:self.mirrorURL forKey:@"mirror_url"];
  [aCoder encodeObject:self.languagesURL forKey:@"languages_url"];
  [aCoder encodeObject:self.treesURL forKey:@"trees_url"];
  [aCoder encodeObject:self.forksURL forKey:@"forks_url"];
  [aCoder encodeBool:self.isFork forKey:@"fork"];
  [aCoder encodeObject:self.masterBranch forKey:@"master_branch"];
  [aCoder encodeObject:self.mergesURL forKey:@"merges_url"];
  [aCoder encodeObject:self.assigneesURL forKey:@"assignees_url"];
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeObject:self.svnURL forKey:@"svn_url"];
  [aCoder encodeObject:self.statusesURL forKey:@"statuses_url"];
  [aCoder encodeObject:self.keysURL forKey:@"keys_url"];
  [aCoder encodeObject:self.htmlURL forKey:@"html_url"];
  [aCoder encodeBool:self.isPrivate forKey:@"private"];
  [aCoder encodeObject:self.fullName forKey:@"full_name"];
  [aCoder encodeInteger:self.repositoryId forKey:@"id"];
  [aCoder encodeBool:self.hasWiki forKey:@"has_wiki"];
  [aCoder encodeInteger:self.forksCount forKey:@"forks_count"];
  [aCoder encodeObject:self.notificationsURL forKey:@"notifications_url"];
  [aCoder encodeObject:self.archiveURL forKey:@"archive_url"];
  [aCoder encodeObject:self.stargazersURL forKey:@"stargazers_url"];
  [aCoder encodeObject:self.branchesURL forKey:@"branches_url"];
}

@end

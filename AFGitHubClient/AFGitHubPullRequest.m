//
//  AFGitHubPullRequest.m
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

#import "AFGitHubPullRequest.h"
#import "AFGitHubGlobal.h"
#import "NSDate+InternetDateTime.h"
#import "AFGitHubUser.h"

@implementation AFGitHubPullRequest

#pragma mark - Initializing

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super init]) {
    id val = nil;
    val = dictionary[@"commits_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.commitsURL = [NSURL URLWithString:val];
    val = dictionary[@"merge_commit_sha"];
    if(AFGitHubIsStringWithAnyText(val)) self.mergeCommitSHA = val;
    val = dictionary[@"closed_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.closedAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"number"];
    if([val isKindOfClass:[NSNumber class]]) self.number = [val integerValue];
    val = dictionary[@"issue_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.issueURL = [NSURL URLWithString:val];
    val = dictionary[@"comments_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.commentsURL = [NSURL URLWithString:val];
    val = dictionary[@"state"];
    if(AFGitHubIsStringWithAnyText(val)) self.state = val;
    val = dictionary[@"body"];
    if(AFGitHubIsStringWithAnyText(val)) self.body = val;
    val = dictionary[@"created_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.createdAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"assignee"];
    if([val isKindOfClass:[NSDictionary class]]) self.assignee = [[AFGitHubUser alloc] initWithDictionary:val];
    val = dictionary[@"patch_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.patchURL = [NSURL URLWithString:val];
    val = dictionary[@"url"];
    if(AFGitHubIsStringWithAnyText(val)) self.URL = [NSURL URLWithString:val];
    val = dictionary[@"user"];
    if([val isKindOfClass:[NSDictionary class]]) self.user = [[AFGitHubUser alloc] initWithDictionary:val];
    val = dictionary[@"id"];
    if([val isKindOfClass:[NSNumber class]]) self.pullRequestId = [val integerValue];
    val = dictionary[@"base"];
    if([val isKindOfClass:[NSDictionary class]]) self.base = val;
    val = dictionary[@"merged_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.mergedAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"head"];
    if([val isKindOfClass:[NSDictionary class]]) self.head = val;
    val = dictionary[@"review_comment_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.reviewCommentURL = [NSURL URLWithString:val];
    val = dictionary[@"review_comments_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.reviewCommentsURL = [NSURL URLWithString:val];
    val = dictionary[@"updated_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.updatedAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"html_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.htmlURL = [NSURL URLWithString:val];
    val = dictionary[@"milestone"];
    if(AFGitHubIsStringWithAnyText(val)) self.milestone = val;
    val = dictionary[@"title"];
    if(AFGitHubIsStringWithAnyText(val)) self.title = val;
    val = dictionary[@"diff_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.diffURL = [NSURL URLWithString:val];
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubPullRequest *copy = [[self.class alloc] init];
  copy.commitsURL = self.commitsURL;
  copy.mergeCommitSHA = self.mergeCommitSHA;
  copy.closedAt = self.closedAt;
  copy.number = self.number;
  copy.issueURL = self.issueURL;
  copy.commentsURL = self.commentsURL;
  copy.state = self.state;
  copy.body = self.body;
  copy.createdAt = self.createdAt;
  copy.assignee = self.assignee;
  copy.patchURL = self.patchURL;
  copy.URL = self.URL;
  copy.user = self.user;
  copy.pullRequestId = self.pullRequestId;
  copy.base = self.base;
  copy.mergedAt = self.mergedAt;
  copy.head = self.head;
  copy.reviewCommentURL = self.reviewCommentURL;
  copy.reviewCommentsURL = self.reviewCommentsURL;
  copy.updatedAt = self.updatedAt;
  copy.htmlURL = self.htmlURL;
  copy.milestone = self.milestone;
  copy.title = self.title;
  copy.diffURL = self.diffURL;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    self.commitsURL = [aDecoder decodeObjectForKey:@"commits_url"];
    self.mergeCommitSHA = [aDecoder decodeObjectForKey:@"merge_commit_sha"];
    self.closedAt = [aDecoder decodeObjectForKey:@"closed_at"];
    self.number = [aDecoder decodeIntegerForKey:@"number"];
    self.issueURL = [aDecoder decodeObjectForKey:@"issue_url"];
    self.commentsURL = [aDecoder decodeObjectForKey:@"comments_url"];
    self.state = [aDecoder decodeObjectForKey:@"state"];
    self.body = [aDecoder decodeObjectForKey:@"body"];
    self.createdAt = [aDecoder decodeObjectForKey:@"created_at"];
    self.assignee = [aDecoder decodeObjectForKey:@"assignee"];
    self.patchURL = [aDecoder decodeObjectForKey:@"patch_url"];
    self.URL = [aDecoder decodeObjectForKey:@"url"];
    self.user = [aDecoder decodeObjectForKey:@"user"];
    self.pullRequestId = [aDecoder decodeIntegerForKey:@"id"];
    self.base = [aDecoder decodeObjectForKey:@"base"];
    self.mergedAt = [aDecoder decodeObjectForKey:@"merged_at"];
    self.head = [aDecoder decodeObjectForKey:@"head"];
    self.reviewCommentURL = [aDecoder decodeObjectForKey:@"review_comment_url"];
    self.reviewCommentsURL = [aDecoder decodeObjectForKey:@"review_comments_url"];
    self.updatedAt = [aDecoder decodeObjectForKey:@"updated_at"];
    self.htmlURL = [aDecoder decodeObjectForKey:@"html_url"];
    self.milestone = [aDecoder decodeObjectForKey:@"milestone"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.diffURL = [aDecoder decodeObjectForKey:@"diff_url"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.commitsURL forKey:@"commits_url"];
  [aCoder encodeObject:self.mergeCommitSHA forKey:@"merge_commit_sha"];
  [aCoder encodeObject:self.closedAt forKey:@"closed_at"];
  [aCoder encodeInteger:self.number forKey:@"number"];
  [aCoder encodeObject:self.issueURL forKey:@"issue_url"];
  [aCoder encodeObject:self.commentsURL forKey:@"comments_url"];
  [aCoder encodeObject:self.state forKey:@"state"];
  [aCoder encodeObject:self.body forKey:@"body"];
  [aCoder encodeObject:self.createdAt forKey:@"created_at"];
  [aCoder encodeObject:self.assignee forKey:@"assignee"];
  [aCoder encodeObject:self.patchURL forKey:@"patch_url"];
  [aCoder encodeObject:self.URL forKey:@"url"];
  [aCoder encodeObject:self.user forKey:@"user"];
  [aCoder encodeInteger:self.pullRequestId forKey:@"id"];
  [aCoder encodeObject:self.base forKey:@"base"];
  [aCoder encodeObject:self.mergedAt forKey:@"merged_at"];
  [aCoder encodeObject:self.head forKey:@"head"];
  [aCoder encodeObject:self.reviewCommentURL forKey:@"review_comment_url"];
  [aCoder encodeObject:self.reviewCommentsURL forKey:@"review_comments_url"];
  [aCoder encodeObject:self.updatedAt forKey:@"updated_at"];
  [aCoder encodeObject:self.htmlURL forKey:@"html_url"];
  [aCoder encodeObject:self.milestone forKey:@"milestone"];
  [aCoder encodeObject:self.title forKey:@"title"];
  [aCoder encodeObject:self.diffURL forKey:@"diff_url"];
}

@end

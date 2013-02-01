//
//  AFGitHubRepository.h
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

#import <Foundation/Foundation.h>
#import "AFGitHubObject.h"

@class AFGitHubUser;
@interface AFGitHubRepository : NSObject<AFGitHubObject>

@property (nonatomic, assign) BOOL hasDownloads;
@property (nonatomic, assign) BOOL hasIssues;
@property (nonatomic, assign) BOOL hasWiki;
@property (nonatomic, assign) BOOL isFork;
@property (nonatomic, assign) BOOL isPrivate;
@property (nonatomic, assign) NSInteger forksCount;
@property (nonatomic, assign) NSInteger networkCount;
@property (nonatomic, assign) NSInteger openIssuesCount;
@property (nonatomic, assign) NSInteger repositoryId;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger watchersCount;
@property (nonatomic, copy) AFGitHubUser *owner;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSDate *pushedAt;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, copy) NSDictionary *permissions;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *homepage;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *masterBranch;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *repositoryDescription;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy) NSURL *archiveURL;
@property (nonatomic, copy) NSURL *assigneesURL;
@property (nonatomic, copy) NSURL *blobsURL;
@property (nonatomic, copy) NSURL *branchesURL;
@property (nonatomic, copy) NSURL *cloneURL;
@property (nonatomic, copy) NSURL *collaboratorsURL;
@property (nonatomic, copy) NSURL *commentsURL;
@property (nonatomic, copy) NSURL *commitsURL;
@property (nonatomic, copy) NSURL *compareURL;
@property (nonatomic, copy) NSURL *contentsURL;
@property (nonatomic, copy) NSURL *contributorsURL;
@property (nonatomic, copy) NSURL *downloadsURL;
@property (nonatomic, copy) NSURL *eventsURL;
@property (nonatomic, copy) NSURL *forksURL;
@property (nonatomic, copy) NSURL *gitCommitsURL;
@property (nonatomic, copy) NSURL *gitRefsURL;
@property (nonatomic, copy) NSURL *gitTagsURL;
@property (nonatomic, copy) NSURL *gitURL;
@property (nonatomic, copy) NSURL *hooksURL;
@property (nonatomic, copy) NSURL *htmlURL;
@property (nonatomic, copy) NSURL *issueCommentURL;
@property (nonatomic, copy) NSURL *issueEventsURL;
@property (nonatomic, copy) NSURL *issuesURL;
@property (nonatomic, copy) NSURL *keysURL;
@property (nonatomic, copy) NSURL *labelsURL;
@property (nonatomic, copy) NSURL *languagesURL;
@property (nonatomic, copy) NSURL *mergesURL;
@property (nonatomic, copy) NSURL *milestonesURL;
@property (nonatomic, copy) NSURL *mirrorURL;
@property (nonatomic, copy) NSURL *notificationsURL;
@property (nonatomic, copy) NSURL *pullsURL;
@property (nonatomic, copy) NSURL *sshURL;
@property (nonatomic, copy) NSURL *stargazersURL;
@property (nonatomic, copy) NSURL *statusesURL;
@property (nonatomic, copy) NSURL *subscribersURL;
@property (nonatomic, copy) NSURL *subscriptionURL;
@property (nonatomic, copy) NSURL *svnURL;
@property (nonatomic, copy) NSURL *tagsURL;
@property (nonatomic, copy) NSURL *teamsURL;
@property (nonatomic, copy) NSURL *treesURL;

@property (nonatomic, readonly) BOOL pushPermission;
@property (nonatomic, readonly) BOOL pullPermission;
@property (nonatomic, readonly) BOOL adminPermission;

@end

//
//  AFGitHubPullRequest.h
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
@interface AFGitHubPullRequest : NSObject<AFGitHubObject>

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger pullRequestId;
@property (nonatomic, copy) AFGitHubUser *assignee;
@property (nonatomic, copy) AFGitHubUser *user;
@property (nonatomic, copy) NSDate *closedAt;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSDate *mergedAt;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, copy) NSDictionary *base;
@property (nonatomic, copy) NSDictionary *head;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *mergeCommitSHA;
@property (nonatomic, copy) NSString *milestone;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy) NSURL *commentsURL;
@property (nonatomic, copy) NSURL *commitsURL;
@property (nonatomic, copy) NSURL *diffURL;
@property (nonatomic, copy) NSURL *htmlURL;
@property (nonatomic, copy) NSURL *issueURL;
@property (nonatomic, copy) NSURL *patchURL;
@property (nonatomic, copy) NSURL *reviewCommentURL;
@property (nonatomic, copy) NSURL *reviewCommentsURL;

@end

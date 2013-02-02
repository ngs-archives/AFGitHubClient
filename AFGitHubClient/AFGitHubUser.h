//
//  AFGitHubUser.h
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

@interface AFGitHubUser : NSObject<AFGitHubObject>

@property (nonatomic, assign) BOOL isHireable;
@property (nonatomic, assign) NSInteger followers;
@property (nonatomic, assign) NSInteger following;
@property (nonatomic, assign) NSInteger publicGists;
@property (nonatomic, assign) NSInteger publicRepos;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *blog;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *gravatarId;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy) NSURL *avatarURL;
@property (nonatomic, copy) NSURL *eventsURL;
@property (nonatomic, copy) NSURL *followersURL;
@property (nonatomic, copy) NSURL *followingURL;
@property (nonatomic, copy) NSURL *gistsURL;
@property (nonatomic, copy) NSURL *htmlURL;
@property (nonatomic, copy) NSURL *organizationsURL;
@property (nonatomic, copy) NSURL *receivedEventsURL;
@property (nonatomic, copy) NSURL *reposURL;
@property (nonatomic, copy) NSURL *starredURL;
@property (nonatomic, copy) NSURL *subscriptionsURL;

@end

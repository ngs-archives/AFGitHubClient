//
//  AFGitHubComment.m
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

#import "AFGitHubComment.h"
#import "AFGitHubUser.h"
#import "AFGitHubGlobal.h"
#import "NSDate+InternetDateTime.h"

@implementation AFGitHubComment

#pragma mark - Initializing

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super init]) {
    id val = nil;
    val = dictionary[@"updated_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.updatedAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"url"];
    if(AFGitHubIsStringWithAnyText(val)) self.URL = [NSURL URLWithString:val];
    val = dictionary[@"path"];
    if(AFGitHubIsStringWithAnyText(val)) self.path = val;
    val = dictionary[@"user"];
    if([val isKindOfClass:[NSDictionary class]]) self.user = [[AFGitHubUser alloc] initWithDictionary:val];
    val = dictionary[@"created_at"];
    if(AFGitHubIsStringWithAnyText(val)) self.createdAt = [NSDate dateFromRFC3339String:val];
    val = dictionary[@"html_url"];
    if(AFGitHubIsStringWithAnyText(val)) self.htmlURL = [NSURL URLWithString:val];
    val = dictionary[@"body"];
    if(AFGitHubIsStringWithAnyText(val)) self.body = val;
    val = dictionary[@"position"];
    if(AFGitHubIsStringWithAnyText(val)) self.position = val;
    val = dictionary[@"commit_id"];
    if(AFGitHubIsStringWithAnyText(val)) self.commitId = val;
    val = dictionary[@"id"];
    if([val isKindOfClass:[NSNumber class]]) self.commentId = [val integerValue];
    val = dictionary[@"line"];
    if(AFGitHubIsStringWithAnyText(val)) self.line = val;
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubComment *copy = [[self.class alloc] init];
  copy.updatedAt = self.updatedAt;
  copy.URL = self.URL;
  copy.path = self.path;
  copy.user = self.user;
  copy.createdAt = self.createdAt;
  copy.htmlURL = self.htmlURL;
  copy.body = self.body;
  copy.position = self.position;
  copy.commitId = self.commitId;
  copy.commentId = self.commentId;
  copy.line = self.line;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    self.updatedAt = [aDecoder decodeObjectForKey:@"updated_at"];
    self.URL = [aDecoder decodeObjectForKey:@"url"];
    self.path = [aDecoder decodeObjectForKey:@"path"];
    self.user = [aDecoder decodeObjectForKey:@"user"];
    self.createdAt = [aDecoder decodeObjectForKey:@"created_at"];
    self.htmlURL = [aDecoder decodeObjectForKey:@"html_url"];
    self.body = [aDecoder decodeObjectForKey:@"body"];
    self.position = [aDecoder decodeObjectForKey:@"position"];
    self.commitId = [aDecoder decodeObjectForKey:@"commit_id"];
    self.commentId = [aDecoder decodeIntegerForKey:@"id"];
    self.line = [aDecoder decodeObjectForKey:@"line"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.updatedAt forKey:@"updated_at"];
  [aCoder encodeObject:self.URL forKey:@"url"];
  [aCoder encodeObject:self.path forKey:@"path"];
  [aCoder encodeObject:self.user forKey:@"user"];
  [aCoder encodeObject:self.createdAt forKey:@"created_at"];
  [aCoder encodeObject:self.htmlURL forKey:@"html_url"];
  [aCoder encodeObject:self.body forKey:@"body"];
  [aCoder encodeObject:self.position forKey:@"position"];
  [aCoder encodeObject:self.commitId forKey:@"commit_id"];
  [aCoder encodeInteger:self.commentId forKey:@"id"];
  [aCoder encodeObject:self.line forKey:@"line"];
}


@end

//
//  AFGitHubCommit.m
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

#import "AFGitHubCommit.h"
#import "AFGitHubTree.h"
#import "AFGitHubUser.h"
#import "AFGitHubGlobal.h"
#import "NSDate+InternetDateTime.h"

@implementation AFGitHubCommit

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super initWithDictionary:dictionary]) {
    id val = nil;
    val = dictionary[@"tree"];
    if([val isKindOfClass:[NSDictionary class]])
      self.tree = [[AFGitHubTree alloc] initWithDictionary:val];
    val = dictionary[@"parents"];
    if(AFGitHubIsArrayWithObjects(val)) {
      NSMutableArray *buf = @[].mutableCopy;
      for (id obj in val) {
        [buf addObject:[[AFGitHubCommit alloc] initWithDictionary:obj]];
      }
      self.parents = [buf copy];
    }
    val = dictionary[@"url"];
    if(AFGitHubIsStringWithAnyText(val)) self.URL = [NSURL URLWithString:val];
    val = dictionary[@"sha"];
    if(AFGitHubIsStringWithAnyText(val)) self.SHA = val;
    val = dictionary[@"message"];
    if(AFGitHubIsStringWithAnyText(val)) self.message = val;
    val = dictionary[@"author"];
    if([val isKindOfClass:[NSDictionary class]]) {
      self.author = [[AFGitHubUser alloc] initWithDictionary:val];
      self.authedAt = [NSDate dateFromRFC3339String:val[@"date"]];
    }
    val = dictionary[@"committer"];
    if([val isKindOfClass:[NSDictionary class]]) {
      self.committer = [[AFGitHubUser alloc] initWithDictionary:val];
      self.commitedAt = [NSDate dateFromRFC3339String:val[@"date"]];
    }
  }
  return self;
}


#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubCommit *copy = [super copyWithZone:zone];
  copy.tree = self.tree;
  copy.parents = self.parents;
  copy.message = self.message;
  copy.author = self.author;
  copy.committer = self.committer;
  copy.commitedAt = self.commitedAt;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    self.tree = [aDecoder decodeObjectForKey:@"tree"];
    self.parents = [aDecoder decodeObjectForKey:@"parents"];
    self.URL = [aDecoder decodeObjectForKey:@"url"];
    self.SHA = [aDecoder decodeObjectForKey:@"sha"];
    self.message = [aDecoder decodeObjectForKey:@"message"];
    self.author = [aDecoder decodeObjectForKey:@"author"];
    self.committer = [aDecoder decodeObjectForKey:@"committer"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.tree forKey:@"tree"];
  [aCoder encodeObject:self.parents forKey:@"parents"];
  [aCoder encodeObject:self.URL forKey:@"url"];
  [aCoder encodeObject:self.SHA forKey:@"sha"];
  [aCoder encodeObject:self.message forKey:@"message"];
  [aCoder encodeObject:self.author forKey:@"author"];
  [aCoder encodeObject:self.committer forKey:@"committer"];
}

@end

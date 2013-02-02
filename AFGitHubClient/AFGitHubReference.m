//
//  AFGitHubReference.m
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

#import "AFGitHubReference.h"
#import "AFGitHubGlobal.h"
#import "AFGitHubCommit.h"
#import "AFGitHubTag.h"

@implementation AFGitHubReference

- (id)initWithObject:(AFGitHubGitObject *)object ref:(NSString *)ref {
  if(self = [super init]) {
    self.ref = ref;
    self.object = object;
  }
  return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super initWithDictionary:dictionary]) {
    id val = nil;
    val = dictionary[@"ref"];
    if(AFGitHubIsStringWithAnyText(val))
      self.ref = val;
    val = dictionary[@"object"];
    if([val isKindOfClass:[NSDictionary class]]) {
      NSString *type = val[@"type"];
      if([type isEqualToString:@"tag"]) {
        self.object = [[AFGitHubTag alloc] initWithDictionary:val];
      } else if([type isEqualToString:@"commit"]) {
        self.object = [[AFGitHubCommit alloc] initWithDictionary:val];
      }
    }
  }
  return self;
}

- (NSDictionary *)asJSON {
  return @{ @"ref": self.ref, @"sha": self.object.SHA };
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubReference *copy = [super copyWithZone:zone];
  copy.ref = self.ref;
  copy.object = self.object;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [super initWithCoder:aDecoder]) {
    self.ref = [aDecoder decodeObjectForKey:@"ref"];
    self.object = [aDecoder decodeObjectForKey:@"object"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:self.ref forKey:@"ref"];
  [aCoder encodeObject:self.object forKey:@"object"];
}

@end

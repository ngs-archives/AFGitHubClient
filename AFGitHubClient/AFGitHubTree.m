//
//  AFGitHubTree.m
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

#import "AFGitHubTree.h"
#import "AFGitHubGlobal.h"
#import "AFGitHubBlob.h"
#import "AFGitHubComment.h"
#import "AFGitHubConstants.h"

@implementation AFGitHubTree

- (NSString *)mode { return AFGitHubDataModeSubdirectory; }
- (NSString *)type { return @"tree"; }

- (id)initWithDictionary:(NSDictionary *)dictonary {
  if(self = [super initWithDictionary:dictonary]) {
    id val = nil;
    val = dictonary[@"tree"];
    NSMutableArray *buf = @[].mutableCopy;
    if(AFGitHubIsStringWithAnyText(val)) {
      for (id obj in val) {
        id obj2 = [AFGitHubGitObject gitObjectWithDictionary:val];
        if(obj2) [buf addObject:obj2];
      }
    }
  }
  return self;
}

- (NSDictionary *)asJSON {
  NSMutableDictionary *dict = @{}.mutableCopy;
  NSMutableArray *buf = @[].mutableCopy;
  if(self.baseTree && AFGitHubIsStringWithAnyText(self.baseTree.SHA))
    dict[@"base_tree"] = self.baseTree.SHA;
  for (AFGitHubGitDataObject *obj in self.objects) {
    NSMutableDictionary *mdic = [[obj asJSON] mutableCopy];
    mdic[@"mode"] = obj.mode;
    mdic[@"type"] = obj.type;
    mdic[@"path"] = obj.path;
    [buf addObject:mdic.copy];
  }
  dict[@"tree"] = buf.copy;
  return dict.copy;
}

- (NSArray *)paths {
  NSMutableArray *buf = @[].mutableCopy;
  for (AFGitHubGitDataObject* obj in self.objects)
    [buf addObject:obj.path];
  [buf sortedArrayUsingSelector:@selector(compare:)];
  return buf.copy;
}

- (AFGitHubGitDataObject *)objectAtPath:(NSString *)path {
  for (AFGitHubGitDataObject* obj in self.objects) {
    if([obj.path isEqualToString:path])
      return obj;
  }
  return nil;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  id copy = [super copyWithZone:zone];
  [copy setObjects:self.objects];
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [super initWithCoder:aDecoder]) {
    self.objects = [aDecoder decodeObjectForKey:@"objects"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.objects forKey:@"objects"];
}

#pragma mark - 

- (AFGitHubTree *)createTreeWithAddingBlobs:(NSArray *)blobs {
  AFGitHubTree *tree = [[AFGitHubTree alloc] init];
  tree.baseTree = self;
  NSMutableArray *buf = [self.objects mutableCopy];
  for (AFGitHubBlob *blob in blobs) {
    [buf addObject:blob];
  }
  tree.objects = [buf copy];
  return tree;
}

@end

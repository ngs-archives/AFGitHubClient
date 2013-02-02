//
//  AFGitHubTag.m
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

#import "AFGitHubTag.h"
#import "AFGitHubUser.h"
#import "AFGitHubGlobal.h"

@implementation AFGitHubTag


#pragma mark - Initializing

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super init]) {
    id val = nil;
    val = dictionary[@"url"];
    if(AFGitHubIsStringWithAnyText(val)) self.URL = [NSURL URLWithString:val];
    val = dictionary[@"tag"];
    if([val isKindOfClass:[NSString class]]) self.tag = val;
    val = dictionary[@"message"];
    if(AFGitHubIsStringWithAnyText(val)) self.message = val;
    val = dictionary[@"object"];
    self.object = [AFGitHubGitObject gitObjectWithDictionary:val];
    val = dictionary[@"tagger"];
    if([val isKindOfClass:[NSDictionary class]]) self.tagger = [[AFGitHubUser alloc] initWithDictionary:val];
    val = dictionary[@"sha"];
    if(AFGitHubIsStringWithAnyText(val)) self.SHA = val;
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubTag *copy = [super copyWithZone:zone];
  copy.tag = self.tag;
  copy.message = self.message;
  copy.object = self.object;
  copy.tagger = self.tagger;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    self.URL = [aDecoder decodeObjectForKey:@"url"];
    self.tag = [aDecoder decodeObjectForKey:@"tag"];
    self.message = [aDecoder decodeObjectForKey:@"message"];
    self.object = [aDecoder decodeObjectForKey:@"object"];
    self.tagger = [aDecoder decodeObjectForKey:@"tagger"];
    self.SHA = [aDecoder decodeObjectForKey:@"sha"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.URL forKey:@"url"];
  [aCoder encodeObject:self.tag forKey:@"tag"];
  [aCoder encodeObject:self.message forKey:@"message"];
  [aCoder encodeObject:self.object forKey:@"object"];
  [aCoder encodeObject:self.tagger forKey:@"tagger"];
  [aCoder encodeObject:self.SHA forKey:@"sha"];
}



@end

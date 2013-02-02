//
//  AFGitHubUser.m
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

#import "AFGitHubUser.h"
#import "AFGitHubGlobal.h"
#import "NSDate+InternetDateTime.h"

@implementation AFGitHubUser

#pragma mark - Initializing

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super initWithDictionary:dictionary]) {
    id val = nil;
    val = dictionary[@"bio"];
    if(AFGitHubIsStringWithAnyText(val)) self.bio = val;
    val = dictionary[@"hireable"];
    if([val isKindOfClass:[NSNumber class]]) self.isHireable = [val boolValue];
  }
  return self;
}

- (NSDictionary *)asJSON {
  NSMutableDictionary *buf = @{}.mutableCopy;
  if(AFGitHubIsStringWithAnyText(self.name))
    buf[@"name"] = self.name;
  if(AFGitHubIsStringWithAnyText(self.email))
    buf[@"email"] = self.email;
  if(AFGitHubIsStringWithAnyText(self.blog))
    buf[@"blog"] = self.blog;
  if(AFGitHubIsStringWithAnyText(self.company))
    buf[@"company"] = self.company;
  if(AFGitHubIsStringWithAnyText(self.location))
    buf[@"location"] = self.location;
  if(AFGitHubIsStringWithAnyText(self.bio))
    buf[@"bio"] = self.bio;
  buf[@"hireable"] = @(self.isHireable);
  return buf.copy;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubUser *copy = [super copyWithZone:zone];
  copy.bio = self.bio;
  copy.isHireable = self.isHireable;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [super initWithCoder:aDecoder]) {
    self.bio = [aDecoder decodeObjectForKey:@"bio"];
    self.isHireable = [aDecoder decodeBoolForKey:@"hireable"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:self.bio forKey:@"bio"];
  [aCoder encodeBool:self.isHireable forKey:@"hireable"];
}

@end

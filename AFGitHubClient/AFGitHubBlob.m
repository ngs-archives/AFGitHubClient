//
//  AFGitHubBlob.m
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

#import "AFGitHubBlob.h"
#import "NSData+Base64.h"
#import "AFGitHubGlobal.h"

@implementation AFGitHubBlob

#pragma mark - AFGitHubObject

- (id)initWithDictionary:(NSDictionary *)dictonary {
  if (self = [super initWithDictionary:dictonary]) {
    NSString *encoding = dictonary[@"encoding"];
    NSString *content = dictonary[@"content"];
    if(AFGitHubIsStringWithAnyText(encoding) &&
       AFGitHubIsStringWithAnyText(content)) {
      if([encoding isEqualToString:@"base64"]) {
        [self setBase64Content:content];
      } else if([encoding isEqualToString:@"utf-8"]) {
        [self setContent:content];
      }
    }
    id val = dictonary[@"size"];
    if([val isKindOfClass:[NSNumber class]])
      [self setSize:[val integerValue]];
  }
  return self;
}

- (NSDictionary *)asJSON {
  NSString *content = self.base64Content;
  return AFGitHubIsStringWithAnyText(content) ?
  @{ @"content": content, @"encoding": @"base64" } : @{};
}

#pragma mark - Accessors

- (UIImage *)imageContent {
  return [UIImage imageWithData:self.data];
}

- (NSString *)content {
  return [self contentWithEncoding:NSUTF8StringEncoding];
}

- (void)setContent:(NSString *)content {
  [self setContent:content withEncoding:NSUTF8StringEncoding];
}

- (NSString *)contentWithEncoding:(NSStringEncoding)encoding {
  return [[NSString alloc] initWithData:self.data encoding:encoding];
}

- (void)setContent:(NSString *)content withEncoding:(NSStringEncoding)encoding {
  [self setData:[content dataUsingEncoding:encoding]];
}

- (NSString *)base64Content {
  return [self.data base64EncodedString];
}

- (void)setBase64Content:(NSString *)base64Content {
  [self setData:[NSData dataFromBase64String:base64Content]];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubBlob *copy = [super copyWithZone:zone];
  [copy setData:self.data];
  [copy setSize:self.size];
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [super initWithCoder:aDecoder]) {
    self.data = [aDecoder decodeObjectForKey:@"data"];
    self.size = [aDecoder decodeIntegerForKey:@"size"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.data forKey:@"data"];
  [aCoder encodeInteger:self.size forKey:@"size"];
}


@end

//
//  AFGitHubOrganization.m
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubOrganization.h"
#import "AFGitHubGlobal.h"
#import "NSDate+InternetDateTime.h"

@implementation AFGitHubOrganization

- (NSDictionary *)asJSON {
  NSMutableDictionary *buf = @{}.mutableCopy;
  if(AFGitHubIsStringWithAnyText(self.billingEmail))
    buf[@"billing_email"] = self.billingEmail;
  if(AFGitHubIsStringWithAnyText(self.company))
    buf[@"company"] = self.company;
  if(AFGitHubIsStringWithAnyText(self.email))
    buf[@"email"] = self.email;
  if(AFGitHubIsStringWithAnyText(self.name))
    buf[@"name"] = self.name;
  if(AFGitHubIsStringWithAnyText(self.blog))
    buf[@"blog"] = self.blog;
  if(AFGitHubIsStringWithAnyText(self.location))
    buf[@"location"] = self.location;
  return buf.copy;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
  return self = [super initWithDictionary:dictionary];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHubOrganization *copy = [super copyWithZone:zone];
  copy.billingEmail = self.billingEmail;
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [super initWithCoder:aDecoder]) {
    self.billingEmail = [aDecoder decodeObjectForKey:@"billing_email"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:self.billingEmail forKey:@"billing_email"];
}



@end

//
//  AFGitHubAPIResponse.m
//  AFGitHub
//
//  Created by Atsushi Nagase on 1/31/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubAPIResponse.h"
#import "AFGitHubObject.h"

@interface AFGitHubAPIResponse ()

@property (nonatomic) NSInteger cursor;
@property (nonatomic, strong) NSMutableArray *items;


@end

@implementation AFGitHubAPIResponse

- (id)first {
  if([self.all count]>0) {
    id ret = [self.all objectAtIndex:0];
    return [ret isKindOfClass:[NSNull class]] ? nil : ret;
  }
  return nil;
}

- (id)next {
  if([self.all count]>_cursor) {
    id ret = [self.all objectAtIndex:_cursor++];
    return [ret isKindOfClass:[NSNull class]] ? nil : ret;
  }
  return nil;
}

- (NSArray *)all {
  return _items;
}

- (void)reset {
  _cursor = 0;
}

- (void)processResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error {
  _httpResponse = (NSHTTPURLResponse *)response;
  id json = nil;
  id<AFGitHubObject> object = nil;
  _items = nil;
  if(self.itemClass) {

    if(data)
      json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

    if(!json) {
      _success = NO;
      return;
    }

    _items = [NSMutableArray array];

    NSAssert([self.itemClass conformsToProtocol:@protocol(AFGitHubObject)], @"%@ does not confirm to GHKObject protocol", NSStringFromClass(self.class));

    if([json isKindOfClass:[NSDictionary class]]) {
      object = [[self.itemClass alloc] initWithDictionary:json];
      [_items addObject:object];
    } else if([json isKindOfClass:[NSArray class]]) {
      for (NSDictionary *item in json) {
        object = [[self.itemClass alloc] initWithDictionary:item];
        [_items addObject:object];
      }
    }
  }

  NSDictionary *headers = _httpResponse.allHeaderFields;
  NSString *link = [headers valueForKey:@"Link"];
  NSDictionary *dict = [self parseLinkHeader:link];

  self.nextURL  = [dict valueForKey:@"next"];
  self.prevURL  = [dict valueForKey:@"prev"];
  self.firstURL = [dict valueForKey:@"first"];
  self.lastURL  = [dict valueForKey:@"last"];

  [self reset];
}

- (NSDictionary *)parseLinkHeader:(NSString *)headerField {
  if(![headerField isKindOfClass:[NSString class]] || [headerField length] == 0)
    return nil;
  NSArray *ar = [headerField componentsSeparatedByString:@", "];
  NSMutableDictionary *buf = [NSMutableDictionary dictionary];
  for (NSString *sec in ar) {
    NSArray *kv = [[sec stringByReplacingOccurrencesOfString:@"<" withString:@""] componentsSeparatedByString:@">; rel=\""];
    if([kv count]==2) {
      NSString *k = [[kv objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
      NSString *v = [kv objectAtIndex:0];
      if([k isKindOfClass:[NSString class]] && [k length] > 0 &&
         [v isKindOfClass:[NSString class]] && [v length] > 0)
        [buf setValue:[NSURL URLWithString:v] forKey:k];
    }
  }
  return [buf copy];
}

@end

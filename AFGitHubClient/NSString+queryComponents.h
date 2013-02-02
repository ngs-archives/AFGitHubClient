//
//  NSString+queryComponents.h
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (queryComponents)

- (NSDictionary*)queryContents;

- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding;

@end

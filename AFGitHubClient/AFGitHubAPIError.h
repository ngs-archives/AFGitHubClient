//
//  AFGitHubAPIError.h
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFGitHubAPIError : NSError

+ (NSError *)errorWithDictionary:(NSDictionary *)dictionary withStatusCode:(NSInteger)statusCode;

@end

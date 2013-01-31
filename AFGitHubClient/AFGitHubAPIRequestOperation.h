//
//  AFGitHubAPIRequestOperation.h
//  AFGitHub
//
//  Created by Atsushi Nagase on 1/31/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFJSONRequestOperation.h"

@class AFGitHubAPIResponse;
@interface AFGitHubAPIRequestOperation : AFJSONRequestOperation

@property (nonatomic, readonly) AFGitHubAPIResponse *ghResponse;

@end

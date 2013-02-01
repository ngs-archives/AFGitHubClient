//
//  AFGitHubGlobal.m
//  AFGitHub
//
//   Created by Atsushi Nagase on 2/1/13.
//   Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFGitHubGlobal.h"

//  From NINonEmptyCollectionTesting.m

BOOL AFGitHubIsArrayWithObjects(id object) {
  return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}

BOOL AFGitHubIsSetWithObjects(id object) {
  return [object isKindOfClass:[NSSet class]] && [(NSSet*)object count] > 0;
}

BOOL AFGitHubIsStringWithAnyText(id object) {
  return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}

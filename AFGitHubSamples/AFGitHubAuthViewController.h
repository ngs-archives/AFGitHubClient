//
//  AFGitHubAuthViewController.h
//  AFGitHub
//
//  Created by Atsushi Nagase on 2/2/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFGitHub.h"
#import "AFGitHubAPIKeys.h"

@interface AFGitHubAuthViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

//
//  ResourceWebViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 23/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResourceWebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property NSString *url;

@end

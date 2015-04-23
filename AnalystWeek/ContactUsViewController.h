//
//  ContactUsViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 15/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalystWeekHTTPClient.h"
#import "BaseViewController.h"

@interface ContactUsViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,AnalystWeekDelegate>
@property (weak, nonatomic) IBOutlet UITableView *liveChatView;
@property (weak, nonatomic) IBOutlet UITextView *contactField;
@property (weak, nonatomic) IBOutlet UITextView *addressField;
@property (weak, nonatomic) IBOutlet UITextField *chatMessageField;
- (IBAction)sendClicked:(id)sender;

@end

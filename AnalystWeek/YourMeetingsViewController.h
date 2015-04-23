//
//  YourMeetingsViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalystWeekHTTPClient.h"
#import "BaseViewController.h"

@interface YourMeetingsViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource,AnalystWeekDelegate>
@property (weak, nonatomic) IBOutlet UITableView *meetingTableView;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;

@end

//
//  YourMeetingsViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourMeetingsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *meetingTableView;

@end

//
//  AgendaViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalystWeekHTTPClient.h"

@interface AgendaViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,AnalystWeekDelegate>
@property (weak, nonatomic) IBOutlet UITableView *agendaTable;

@end

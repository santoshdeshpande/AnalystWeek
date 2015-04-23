//
//  AgendaViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalystWeekHTTPClient.h"
#import "BaseViewController.h"

@interface AgendaViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,AnalystWeekDelegate>
@property (weak, nonatomic) IBOutlet UITableView *agendaTable;
@property NSMutableArray *agendaItems;

@end

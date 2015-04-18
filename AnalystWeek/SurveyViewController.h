//
//  SurveyViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 17/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalystWeekHTTPClient.h"

@interface SurveyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AnalystWeekDelegate>
@property (weak, nonatomic) IBOutlet UITableView *surveyTable;
- (IBAction)onSubmitClicked:(id)sender;

@end

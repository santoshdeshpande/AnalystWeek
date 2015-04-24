//
//  SurveyViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 17/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalystWeekHTTPClient.h"
#import "BaseViewController.h"

@interface SurveyViewController : BaseViewController<AnalystWeekDelegate>

- (IBAction)onSubmitClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;

@end

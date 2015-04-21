//
//  FeedbackViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 13/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalystWeekHTTPClient.h"

@interface FeedbackViewController : UIViewController<AnalystWeekDelegate>
- (IBAction)onSubmitClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *question1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *question2;
@property (weak, nonatomic) IBOutlet UITextView *question3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *question4;
@property (weak, nonatomic) IBOutlet UITextView *question5;

@end

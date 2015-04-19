//
//  RequestMeetingViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 13/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalystWeekHTTPClient.h"

@interface RequestMeetingViewController : UIViewController<AnalystWeekDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *company;
@property (weak, nonatomic) IBOutlet UITextField *designation;
@property (weak, nonatomic) IBOutlet UITextField *leader;
@property (weak, nonatomic) IBOutlet UITextView *comments;
- (IBAction)onSubmitClicked:(id)sender;
    

@end

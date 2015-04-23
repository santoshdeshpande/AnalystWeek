//
//  MeetingRequestTableViewCell.h
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetingRequestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *meetingIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *meetingWithLabel;
@property (weak, nonatomic) IBOutlet UILabel *meetingLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *meetingTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *meetingTopicLabel;
@property (weak, nonatomic) IBOutlet UILabel *participantsLabel;
@property (weak, nonatomic) IBOutlet UILabel *analystsLabel;
@property (weak, nonatomic) IBOutlet UIView *analystsView;

@end

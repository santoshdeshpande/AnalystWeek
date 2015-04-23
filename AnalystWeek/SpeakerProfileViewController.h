//
//  SpeakerProfileViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 15/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalystWeekHTTPClient.h"
#import "BaseViewController.h"

@interface SpeakerProfileViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,AnalystWeekDelegate>
@property (weak, nonatomic) IBOutlet UIButton *speakerButton;
@property (weak, nonatomic) IBOutlet UIButton *wiproLeaderButton;
@property (weak, nonatomic) IBOutlet UIButton *participantButton;
@property (weak, nonatomic) IBOutlet UITableView *speakerTable;
@property (weak, nonatomic) IBOutlet UIView *profileView;
- (IBAction)onSpeakerClicked:(id)sender;
- (IBAction)onWiproLeaderClicked:(id)sender;
- (IBAction)onParticipantClicked:(id)sender;
- (IBAction)onBackButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *profileLabel;

@end

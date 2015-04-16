//
//  YourMeetingsViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "YourMeetingsViewController.h"
#import "MeetingRequestTableViewCell.h"
#import "YourMeeting.h"

@interface YourMeetingsViewController ()
   @property NSMutableArray *yourMeetings;

@end

@implementation YourMeetingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.meetingTableView.dataSource = self;
    self.meetingTableView.delegate = self;
    self.yourMeetings = [NSMutableArray array];
    for(int i=0;i<10;i++) {
        YourMeeting *meeting = [[YourMeeting alloc] initWithLeader:@"Leader" room:@"Board Room" atTime:@"09:30 AM - 10:30 AM" andTopic:@"This is a long topic that I will want to see in the list of stuff that I will be there"];
        [self.yourMeetings addObject:meeting];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yourMeetings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"meetingCell";
    MeetingRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    YourMeeting *meeting = [self.yourMeetings objectAtIndex:[indexPath row]];
    NSString *label = [NSString stringWithFormat:@"Meeting %ld", [indexPath row]+1];
    cell.meetingIdLabel.text = label;
    cell.meetingWithLabel.text = meeting.leaderName;
    cell.meetingLocationLabel.text = meeting.room;
    cell.meetingTimeLabel.text = meeting.time;
    cell.meetingTopicLabel.text = meeting.topic;
    return cell;
}

@end

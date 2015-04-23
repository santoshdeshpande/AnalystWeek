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
    [self fetchMeetings];
    // Do any additional setup after loading the view.
    self.meetingTableView.dataSource = self;
    self.meetingTableView.delegate = self;
    self.yourMeetings = [NSMutableArray array];
    

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
    NSString *label = [NSString stringWithFormat:@"Meeting %d", [indexPath row]+1];
    cell.meetingIdLabel.text = label;
    cell.meetingWithLabel.text = meeting.leaderName;
    cell.meetingLocationLabel.text = meeting.room;
    cell.meetingTimeLabel.text = meeting.time;
    cell.meetingTopicLabel.text = meeting.topic;
    return cell;
}

- (void) fetchMeetings {
    AnalystWeekHTTPClient *client = [AnalystWeekHTTPClient sharedHTTPClient];
    client.delegate = self;
    [client fetchMeetings];
}

- (void)analystHTTPClient:(AnalystWeekHTTPClient *)client meetingsFetched:(id)response {
    NSLog(@"Response:  %@",response);
    NSArray *array = (NSArray *) response;
    for (id object in array) {
        NSDictionary *dict = (NSDictionary *) object;
        NSString *meeting_with_name = [self getMeetingWithNames:dict];
        NSString *leader = meeting_with_name;
        NSString *room = [dict objectForKey:@"venue"];
        NSString *start = [dict objectForKey:@"start_time_str"];
        NSString *end = [dict objectForKey:@"end_time_str"];
        NSString *time = [NSString stringWithFormat:@"%@ - %@",start, end];
        NSString *topic = [dict objectForKey:@"topic"];
        YourMeeting *meeting = [[YourMeeting alloc] initWithLeader:leader room:room atTime:time andTopic:topic];
        [self.yourMeetings addObject:meeting];
    }
    [self.meetingTableView reloadData];
}

- (NSString *) getMeetingWithNames:(NSDictionary*) object {
    NSString *result = @"";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userEmail = [defaults objectForKey:@"email"];
    NSArray *array = [object objectForKey:@"meeting_of"];
    for (id meeting in array) {
        NSDictionary *dict = (NSDictionary *) meeting;
        NSString *email = [dict objectForKey:@"email"];
        NSString *fullName = [NSString stringWithFormat:@"%@, ",[dict objectForKey:@"name"]];
        if([userEmail isEqualToString:email])
           continue;
        result = [result stringByAppendingString:fullName];
    }
    array = [object objectForKey:@"meeting_with"];
    for (id meeting in array) {
        NSDictionary *dict = (NSDictionary *) meeting;
        NSString *email = [dict objectForKey:@"email"];
        NSString *fullName = [NSString stringWithFormat:@"%@, ",[dict objectForKey:@"name"]];
        if([userEmail isEqualToString:email])
            continue;
        result = [result stringByAppendingString:fullName];
    }
    
    if ([result length] > 0) {
        NSLog(@"Here....");
        result = [result substringToIndex:[result length]-2];
    }
    return result;
}

@end

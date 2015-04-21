//
//  FeedbackViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 13/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)onSubmitClicked:(id)sender {
    NSString *q1 = self.question1.text;
    NSInteger index = self.question2.selectedSegmentIndex;
    NSString *q2 = [self.question2 titleForSegmentAtIndex:index];
    NSString *q3 = self.question3.text;
    index = self.question4.selectedSegmentIndex;
    NSString *q4 = [self.question4 titleForSegmentAtIndex:index];
    NSString *q5 = self.question5.text;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *email = [defaults objectForKey:@"email"];
    NSString *name = [defaults objectForKey:@"name"];
    [params setObject:email  forKey:@"email"];
    [params setObject:name  forKey:@"name"];
    
    [params setObject:q1  forKey:@"question1"];
    [params setObject:q2  forKey:@"question2"];
    [params setObject:q3  forKey:@"question3"];
    [params setObject:q4  forKey:@"question4"];
    [params setObject:q5  forKey:@"question5"];
    AnalystWeekHTTPClient *client = [AnalystWeekHTTPClient sharedHTTPClient];
    client.delegate = self;
    [client postFeedback:params];
}

- (void) analystHTTPClient:(AnalystWeekHTTPClient *)client feedbackPosted:(id)response {
    NSLog(@"Feedback Posted...");
}
@end

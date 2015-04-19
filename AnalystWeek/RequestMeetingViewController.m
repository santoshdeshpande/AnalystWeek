//
//  RequestMeetingViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 13/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "RequestMeetingViewController.h"
#import "AnalystWeekHTTPClient.h"

@interface RequestMeetingViewController ()

@end

@implementation RequestMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"name"];
    self.name.text = name;
    [self.company becomeFirstResponder];
//    self.

    
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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *name = self.name.text;
    NSString *errors = @"";
    if ([name isEqualToString:@""]) {
        errors = [errors stringByAppendingString:@"Name field is required\n"];
    }
    
    
    NSString *company = self.company.text;
    if ([company isEqualToString:@""]) {
        errors = [errors stringByAppendingString:@"Company field is required\n"];
    }

    NSString *designation = self.designation.text;
    if ([designation isEqualToString:@""]) {
        errors = [errors stringByAppendingString:@"Designation field is required\n"];
    }

    NSString *wiproLeader = self.leader.text;
    if ([wiproLeader isEqualToString:@""]) {
        errors = [errors stringByAppendingString:@"Wipro Leader field is required\n"];
    }

    NSString *comments = self.comments.text;
    if ([comments isEqualToString:@""]) {
        errors = [errors stringByAppendingString:@"Comments field is required\n"];
    }
    
    if ([errors isEqualToString:@""]) {
        
        [params setObject:name forKey:@"name"];
        [params setObject:company forKey:@"company"];
        [params setObject:designation forKey:@"designation"];
        [params setObject:wiproLeader forKey:@"wiproLeader"];
        [params  setObject:comments forKey:@"comments"];
        AnalystWeekHTTPClient *client = [AnalystWeekHTTPClient sharedHTTPClient];
        client.delegate = self;
        [client requestMeeting:params];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Fields"
                                                        message:errors
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
}

- (void) analystHTTPClient:(AnalystWeekHTTPClient *)client meetingRequestPosted:(id)response {
        [self.navigationController popToRootViewControllerAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Meeting Request"
                                                    message:@"A meeting request was sent to the admin."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}
@end

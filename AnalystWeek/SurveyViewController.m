//
//  SurveyViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 17/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "SurveyViewController.h"
#import "SurveyTableViewCell.h"
#import "AnalystWeekHTTPClient.h"

@interface SurveyViewController ()

@property NSArray *surveyQuestions;

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.questionTextView becomeFirstResponder];
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


- (void) fetchSurveyQuestions {
    AnalystWeekHTTPClient *client = [AnalystWeekHTTPClient sharedHTTPClient];
    client.delegate = self;
//    [client fetchSurvey];
}

- (void) analystHTTPClient:(AnalystWeekHTTPClient *)client surveyFetched:(id)response {
}


- (IBAction)onSubmitClicked:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *email = [defaults objectForKey:@"email"];
    NSString *name = [defaults objectForKey:@"name"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:email forKey:@"email"];
    [params setObject:name forKey:@"name"];
    NSString *text = self.questionTextView.text;
    text = [text stringByTrimmingCharactersInSet:
                                      [NSCharacterSet whitespaceCharacterSet]];
    if ([text isEqualToString:@""]) {
        [self showAlert];
        return;
    }
    [params setObject:text forKey:@"answer1"];
    AnalystWeekHTTPClient *client = [AnalystWeekHTTPClient sharedHTTPClient];
    client.delegate = self;
    [client postSurveyQuestions:params];
}

- (void) analystHTTPClient:(AnalystWeekHTTPClient *)client surveyInformationPosted:(id)response {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you"
                                                    message:@"Your answers were registered. Thank you for answering the survey"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    self.questionTextView.text = @"";
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void) showAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Answer"
                                                    message:@"Please answer the question"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end

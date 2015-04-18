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
    if(self.surveyQuestions == nil) {
        [self fetchSurveyQuestions];
    }
    // Do any additional setup after loading the view.
    self.surveyTable.dataSource = self;
    self.surveyTable.delegate = self;
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.surveyQuestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SurveyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SurveyCell" forIndexPath:indexPath];
    NSDictionary *dict = [self.surveyQuestions objectAtIndex:indexPath.row];
    cell.questionLabel.text = [dict objectForKey:@"question"];
    [cell.optionLabel setTitle:[dict objectForKey:@"option1"] forSegmentAtIndex:0];
    [cell.optionLabel setTitle:[dict objectForKey:@"option2"] forSegmentAtIndex:1];
    [cell.optionLabel setTitle:[dict objectForKey:@"option3"] forSegmentAtIndex:2];
    [cell.optionLabel setTitle:[dict objectForKey:@"option4"] forSegmentAtIndex:3];
    return cell;

}

- (void) fetchSurveyQuestions {
    AnalystWeekHTTPClient *client = [AnalystWeekHTTPClient sharedHTTPClient];
    client.delegate = self;
    [client fetchSurvey];
}

- (void) analystHTTPClient:(AnalystWeekHTTPClient *)client surveyFetched:(id)response {
    NSArray *array = (NSArray *)response;
    self.surveyQuestions = array;
    [self.surveyTable reloadData];
}


- (IBAction)onSubmitClicked:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *email = [defaults objectForKey:@"email"];
    NSString *name = [defaults objectForKey:@"name"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:email forKey:@"email"];
    [params setObject:name forKey:@"name"];
    for (NSInteger i = 0; i < [self.surveyTable numberOfRowsInSection:0]; ++i) {
        SurveyTableViewCell *cell = (SurveyTableViewCell *)[self.surveyTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        NSInteger index = [cell.optionLabel selectedSegmentIndex];
        NSString *value = @"";
        if(index >= 0) {
            value = [cell.optionLabel titleForSegmentAtIndex:index];
        } else {
            [self showAlert];
            return;
        }
        NSString *optionName = [NSString stringWithFormat:@"answer%ld", i+1];
        [params setObject:value forKey:optionName];
    }
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

}

- (void) showAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Answer"
                                                    message:@"Please select all answers"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end

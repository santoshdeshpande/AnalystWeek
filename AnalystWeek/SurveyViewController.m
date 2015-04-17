//
//  SurveyViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 17/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "SurveyViewController.h"
#import "SurveyTableViewCell.h"

@interface SurveyViewController ()

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SurveyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SurveyCell" forIndexPath:indexPath];
    cell.questionLabel.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
    return cell;

}


@end

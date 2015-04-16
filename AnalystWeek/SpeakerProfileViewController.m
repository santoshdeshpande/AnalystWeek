//
//  SpeakerProfileViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 15/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "SpeakerProfileViewController.h"

@interface SpeakerProfileViewController ()
@property   NSDictionary *speakerProfiles;
@property   NSDictionary *wiproLeaderProfiles;
@property   NSDictionary *participantProfiles;
@property   NSDictionary *currentProfiles;
@property   NSArray      *currentTitles;
@end

@implementation SpeakerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.speakerProfiles = [NSDictionary dictionary];
    self.wiproLeaderProfiles = [NSDictionary dictionary];
    self.participantProfiles = [NSDictionary dictionary];
    
    NSDictionary *profiles = @{
                               @"A" : @[@"Azim Premji",@"Adam",@"Abdul"],
                               @"B" : @[@"Bin",@"Bell",@"Best"],
                               @"C" : @[@"Cello",@"Cielo",@"Cest"]
                               
                               };
    self.speakerProfiles = profiles;
    self.currentProfiles = self.speakerProfiles;
    self.currentTitles = [[profiles allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.speakerTable.rowHeight = UITableViewAutomaticDimension;
    self.speakerTable.estimatedRowHeight = 44.0;
    self.speakerTable.dataSource = self;
    self.speakerTable.delegate = self;
    self.speakerTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

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

- (IBAction)onSpeakerClicked:(id)sender {
    
    self.currentProfiles = self.speakerProfiles;
    self.currentTitles = [[self.currentProfiles allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.speakerTable reloadData];
    
}

- (IBAction)onWiproLeaderClicked:(id)sender {
    self.currentProfiles = self.wiproLeaderProfiles;
    self.currentTitles = [[self.currentProfiles allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.speakerTable reloadData];
    
}

- (IBAction)onParticipantClicked:(id)sender {
    self.currentProfiles = self.participantProfiles;
    self.currentTitles = [[self.currentProfiles allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.speakerTable reloadData];
    
}

- (IBAction)onBackButtonClicked:(id)sender {
    [self.profileView setHidden:YES];
    [self.speakerTable setHidden:NO];
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"HeaderCell";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *currentTitle = [self.currentTitles objectAtIndex:section];
    headerView.textLabel.text = currentTitle;
    return headerView;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.currentProfiles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.currentTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *currentTitle = [self.currentTitles objectAtIndex:section];
    NSArray *profiles = [self.currentProfiles objectForKey:currentTitle];
    return [profiles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpeakerCell" forIndexPath:indexPath];
        NSString *currentTitle = [self.currentTitles objectAtIndex:indexPath.section];
        NSArray *profiles = [self.currentProfiles objectForKey:currentTitle];
    NSString *name = [profiles objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *currentTitle = [self.currentTitles objectAtIndex:indexPath.section];
    NSLog(@"Selection...");
    [self.profileView setHidden:NO];
    [self.speakerTable setHidden:YES];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.currentTitles;
}


@end

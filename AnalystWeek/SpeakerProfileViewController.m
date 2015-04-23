//
//  SpeakerProfileViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 15/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "SpeakerProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface SpeakerProfileViewController ()
@property   NSDictionary *speakerProfiles;
//@property   NSDictionary *wiproLeaderProfiles;
//@property   NSDictionary *participantProfiles;
@property   NSDictionary *currentProfiles;
@property   NSArray      *currentTitles;
@end

@implementation SpeakerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.speakerProfiles = [NSMutableDictionary dictionary];
    [self.speakerProfiles setValue:[NSMutableDictionary dictionary] forKey:@"participant"];
    [self.speakerProfiles setValue:[NSMutableDictionary dictionary] forKey:@"speaker"];
    [self.speakerProfiles setValue:[NSMutableDictionary dictionary] forKey:@"wipro"];
    [self.profileView setHidden:YES];
    [self.speakerTable setHidden:NO];

    [self fetchUserProfiles];
    
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
    [self.profileView setHidden:YES];
    [self.speakerTable setHidden:NO];

    
    self.currentProfiles = [self.speakerProfiles objectForKey:@"speaker"];
    self.currentTitles = [[self.currentProfiles allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.speakerTable reloadData];
    
}

- (IBAction)onWiproLeaderClicked:(id)sender {
    [self.profileView setHidden:YES];
    [self.speakerTable setHidden:NO];

    self.currentProfiles = [self.speakerProfiles objectForKey:@"wipro"];
    self.currentTitles = [[self.currentProfiles allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.speakerTable reloadData];
    
}

- (IBAction)onParticipantClicked:(id)sender {
    [self.profileView setHidden:YES];
    [self.speakerTable setHidden:NO];

    self.currentProfiles = [self.speakerProfiles objectForKey:@"participant"];
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
    NSDictionary *profile = [profiles objectAtIndex:indexPath.row];
    NSString *label = [NSString stringWithFormat:@"%@ (%@)",[profile objectForKey:@"name"],[profile objectForKey:@"email"]];
//    NSString *name = [profile objectForKey:@"name"];
    cell.textLabel.text = label;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *currentTitle = [self.currentTitles objectAtIndex:indexPath.section];
    NSString *currentTitle = [self.currentTitles objectAtIndex:indexPath.section];
    NSArray *profiles = [self.currentProfiles objectForKey:currentTitle];
    NSDictionary *profile = [profiles objectAtIndex:indexPath.row];
    NSString *label = [NSString stringWithFormat:@"%@ (%@)",[profile objectForKey:@"name"],[profile objectForKey:@"email"]];
    self.nameLabel.text = label;
    self.titleLabel.text = [profile objectForKey:@"title"];
    if ([profile objectForKey:@"profile"] != [NSNull null]) {
        self.profileLabel.text = [profile objectForKey:@"profile"];
    }

    if ([profile objectForKey:@"image"] == [NSNull null]) {
        [self.profileImageView setImage:[UIImage imageNamed:@"chat_user_icon_1.png"]];
    } else {
        NSString *imageURL = [profile objectForKey:@"image"];
        [self.profileImageView setImageWithURL:[NSURL URLWithString:imageURL]];
    }
    

    [self.profileView setHidden:NO];
    [self.speakerTable setHidden:YES];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.currentTitles;
}

- (void) fetchUserProfiles {
    AnalystWeekHTTPClient *client = [AnalystWeekHTTPClient sharedHTTPClient];
    client.delegate = self;
    [client fetchUserProfiles];
}

- (void) analystHTTPClient:(AnalystWeekHTTPClient *)client userProfilesFetched:(id)response {
    NSArray *data = (NSArray *) response;
    for (id profile in data) {
        NSDictionary *dictionary = (NSDictionary *) profile;
        NSString *type = [dictionary objectForKey:@"userType"];
        NSString *start = [dictionary objectForKey:@"start"];
        NSDictionary *profileDict = [self.speakerProfiles objectForKey:type];
        NSMutableArray *alphaDict = (NSMutableArray *)[profileDict objectForKey:start];
        if(alphaDict == nil) {
            alphaDict = [NSMutableArray array];
            [profileDict setValue:alphaDict forKey:start];
        }
        [alphaDict addObject:dictionary];        
    }
    self.currentProfiles = [self.speakerProfiles objectForKey:@"wipro"];
    self.currentTitles = [[self.currentProfiles allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.speakerTable reloadData];
//    NSLog(@"Response - %@", response);
}


@end

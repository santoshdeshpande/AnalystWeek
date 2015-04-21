//
//  ContactUsViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 15/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "ContactUsViewController.h"
#import "ChatTableViewCell.h"

@interface ContactUsViewController ()
@property NSArray *chatList;
@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchContactInfo];
    self.chatList = [NSArray array];
    // Do any additional setup after loading the view.
    self.liveChatView.dataSource = self;
    self.liveChatView.delegate = self;
    self.liveChatView.rowHeight = UITableViewAutomaticDimension;
    self.liveChatView.estimatedRowHeight = 44.0;
    self.liveChatView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    return [self.chatList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    NSDictionary *dictionay = [self.chatList objectAtIndex:indexPath.row];
    cell.messageLabel.text = [dictionay objectForKey:@"message"];
    cell.nameLabel.text = [dictionay objectForKey:@"name"];
    return cell;
    
}

- (void) fetchContactInfo {
    AnalystWeekHTTPClient *httpClient = [AnalystWeekHTTPClient sharedHTTPClient];
    httpClient.delegate = self;
    [httpClient fetchContactInfo];
    [httpClient fetchChat];
}

-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client contactInfoFetched:(id)response {
    NSArray *contacts = (NSArray *)response;
    NSDictionary *contact = (NSDictionary *)[contacts objectAtIndex:0];
    NSString *str = [contact objectForKey:@"contact"];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"Str - %@",str);
    self.contactField.text = str;
    self.addressField.text = [contact objectForKey:@"office_address"];
    NSLog(@"%@",response);
}

- (void) analystHTTPClient:(AnalystWeekHTTPClient *)client chatsFetched:(id)response {
    NSArray *list = (NSArray *)response;
    self.chatList = list;
    [self.liveChatView reloadData];
}

- (IBAction)sendClicked:(id)sender {
    NSString *message = self.chatMessageField.text;
    if ([message isEqualToString:@""]) {
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"name"];
    NSString *email = [defaults objectForKey:@"email"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:name forKey:@"name"];
    [params setObject:email forKey:@"email"];
    [params setObject:message forKey:@"message"];
    AnalystWeekHTTPClient *httpClient = [AnalystWeekHTTPClient sharedHTTPClient];
    httpClient.delegate = self;
    [httpClient postChat:params];
}

- (void) analystHTTPClient:(AnalystWeekHTTPClient *)client chatPosted:(id)response {
    self.chatMessageField.text = @"";
    AnalystWeekHTTPClient *httpClient = [AnalystWeekHTTPClient sharedHTTPClient];
    httpClient.delegate = self;
    [httpClient fetchChat];
}
@end

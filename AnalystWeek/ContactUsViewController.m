//
//  ContactUsViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 15/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchContactInfo];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    
}

- (void) fetchContactInfo {
    AnalystWeekHTTPClient *httpClient = [AnalystWeekHTTPClient sharedHTTPClient];
    httpClient.delegate = self;
    [httpClient fetchContactInfo];
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

@end

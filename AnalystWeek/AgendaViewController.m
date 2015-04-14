//
//  AgendaViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "AgendaViewController.h"
#import "BreakViewTableViewCell.h"
#import "HeadingTableViewCell.h"
#import "SessionTableViewCell.h"
#import "Agenda.h"

@interface AgendaViewController ()
@property NSMutableArray *agendaItems;
@end

@implementation AgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.agendaItems = [NSMutableArray array];
    [self buildAgendaItems];
    // Do any additional setup after loading the view.
    self.agendaTable.rowHeight = UITableViewAutomaticDimension;
    self.agendaTable.estimatedRowHeight = 44.0;
    self.agendaTable.dataSource = self;
    self.agendaTable.delegate = self;
    self.agendaTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    return [self.agendaItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger rowNum = [indexPath row];
    Agenda *agenda = [self.agendaItems objectAtIndex:rowNum];
    if ([agenda.type isEqualToString:@"header"]) {
        HeadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
        cell.headingLabel.text = agenda.header;
        return cell;
    }
    
    if ([agenda.type isEqualToString:@"break"]) {
        BreakViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BreakCell" forIndexPath:indexPath];
        cell.headingLabel.text = agenda.header;
        cell.infoLabel.text = agenda.info;
        return cell;
    }
    
    if ([agenda.type isEqualToString:@"session"]) {
        SessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SessionCell" forIndexPath:indexPath];
        cell.headingLabel.text = agenda.header;
        cell.infoLabel.text = agenda.info;
        return cell;
        
    }
    return nil;
}

- (void) buildAgendaItems {
    Agenda *agenda = [self buildAgenda:@"header" header:@"Day 1 - 27 April, 2015" info:nil];
    [self.agendaItems addObject:agenda];
    Agenda *agenda2 = [self buildAgenda:@"break" header:@"TIME" info:@"SESSION/ACTIVITY"];
    [self.agendaItems addObject:agenda2];
    
    Agenda *agenda1 = [self buildAgenda:@"session" header:@"10:00 AM onwards" info:@"Registration and pre-planned one-on-one sessions (with analysts who arrived a day earlier)"];
    [self.agendaItems addObject:agenda1];
    agenda2 = [self buildAgenda:@"break" header:@"12:00 - 1:00 PM" info:@"Lunch"];
    [self.agendaItems addObject:agenda2];
    Agenda *agenda3 = [self buildAgenda:@"session" header:@"1:00 - 1:45 PM" info:@"Wipro: Leading the Change\n TK Kurien Chief Executive Office and Executive Director Wipro Limited will cover Wipro's strategy, focus areas, investments and market update"];
    [self.agendaItems addObject:agenda3];
}

- (Agenda *) buildAgenda:(NSString *) type header:(NSString *)header info: (NSString *)info {
    Agenda *agenda = [[Agenda alloc] initWithType:type withHeader:header];
    if(info != nil) {
        agenda.info = info;
    }
    return agenda;
}


@end

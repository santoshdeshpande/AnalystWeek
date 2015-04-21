//
//  ChatTableViewCell.h
//  AnalystWeek
//
//  Created by Santosh S on 21/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

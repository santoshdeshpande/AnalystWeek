//
//  SurveyTableViewCell.h
//  AnalystWeek
//
//  Created by Santosh S on 17/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *optionLabel;

@end

//
//  PaddedLabel.m
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "PaddedLabel.h"

@implementation PaddedLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 
*/

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 10, 0, 10};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end

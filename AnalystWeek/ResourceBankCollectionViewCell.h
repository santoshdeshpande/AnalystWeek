//
//  ResourceBankCollectionViewCell.h
//  AnalystWeek
//
//  Created by Santosh S on 23/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResourceBankCollectionViewCell : UICollectionViewCell

@property NSString *httpLink;
@property NSString *text;
@property NSString *type;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textView;


@end

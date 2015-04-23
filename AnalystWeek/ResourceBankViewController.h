//
//  ResourceBankViewController.h
//  AnalystWeek
//
//  Created by Santosh S on 17/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ResourceBankViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *pesCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *ctoCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *hlsCollectionView;

@end

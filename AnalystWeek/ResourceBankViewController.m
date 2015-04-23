//
//  ResourceBankViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 17/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "ResourceBankViewController.h"
#import "ResourceBankCollectionViewCell.h"
#import "ResourceWebViewController.h"

@interface ResourceBankViewController ()
@property NSArray *pesArray, *ctoArray, *hlsArray;
@property UIImage *povImage, *videoPovImage,*successImage;
@end

@implementation ResourceBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pesArray = @[
                         @{
                           @"title": @"A Healthy Future with Wearable Semiconductors",
                           @"link":@"http://www.wipro.com/insights/winsights/oct-dec-2013/a-healthy-future-with-wearable-semiconductors/",
                           @"type" : @"pov"
                           },
                         @{
                             @"title":@"Connecting the Dots: How to Make Years of Investment in Retail Technology Pay-off",
                             @"link":@"http://www.wipro.com/insights/winsights/oct-dec-2013/connecting-the-dots-how-to-make-years-of-investment-in-retail-technology-pay-off/",
                             @"type":@"pov"
                             },
                         @{
                             @"title":@"Accelerated Rollout of LTE Services ",
                             @"link":@"http://www.wipro.com/documents/accelerated-rollout-of-LTE-services.pdf",
                             @"type":@"pov"
                             },
                         @{
                             @"title":@"Wipro on PLM for the Oil & Gas Sector ",
                             @"link":@"http://www.wipro.com/services/product-engineering/insights/talking-business/ ",
                             @"type":@"video_pov"
                             },
                         @{
                             @"title":@"Connected Device Ecosystem ",
                             @"link":@"http://www.wipro.com/services/product-engineering/insights/research/#video3 ",
                             @"type":@"video_pov"
                             },
                         @{
                             @"title":@"3D Printing: Improving accessibility, protecting IP and design ",
                             @"link":@"http://www.wipro.com/services/product-engineering/insights/research/#video2 ",
                             @"type":@"video_pov"
                             },
                         @{
                             @"title":@"Advanced Medical Devices Solutions For Improved Healthcare ",
                             @"link":@"http://www.wipro.com/documents/resource-center/ISA_CaseStudy_Medical_Device_260213.pdf",
                             @"type":@"success_story"
                             },
                         @{
                             @"title":@"Industrial & General Manufacturing",
                             @"link":@"http://www.wipro.com/documents/PLM%20in%20a%20box%20-%20Emerson.pdf",
                             @"type":@"success_story"
                             },
                         @{
                             @"title":@"Turnkey Wireless Sensor Device Realization ",
                             @"link":@"http://www.wipro.com/documents/resource-center/ISA_CaseStudy_WirelessSensor_260213.pdf",
                             @"type":@"success_story"
                             },
                         @{
                             @"title":@"Advanced Smart Meter Enables Efficiency In Power Consumption ",
                             @"link":@"http://www.wipro.com/documents/resource-center/Smart_metre_case_study_270213FinalWeb.pdf",
                             @"type":@"success_story"
                             },
                         ];
    self.ctoArray = @[

                      @{
                          @"title":@"Better Workforce safety",
                          @"link":@"http://www.wipro.com/documents/ensuring-better-workforce-safety-with-improved-lone-worker-safety-solutions.pdf",
                          @"type":@"pov"
                          },
                      @{
                          @"title":@"Technology Vision",
                          @"link":@"http://www.wipro.com/documents/technology-vision.pdf",
                          @"type":@"pov"
                          },


                      ];
    
    self.hlsArray = @[
                      @{
                          @"title":@"Improving Ratings a simple plan",
                          @"link":@"http://www.wipro.com/documents/improving-plan-ratings-a-simple-plan.pdf",
                          @"type":@"pov"
                          },
                      @{
                          @"title":@"Improving Broadband fulfilment",
                          @"link":@"http://www.wipro.com/documents/improving-broadband-fulfilment-process.pdf",
                          @"type":@"pov"
                          },
                      @{
                          @"title":@"A Holistic approach to collections",
                          @"link":@"http://www.wipro.com/documents/a-holistic-approach-to-collections-in-telecom.pdf",
                          @"type":@"pov"
                          },

                      ];
    self.povImage = [UIImage imageNamed:@"POV.png"];
    self.videoPovImage = [UIImage imageNamed:@"Video_POV.png"];
        self.successImage = [UIImage imageNamed:@"Success_Story.png"];
    self.pesCollectionView.delegate = self;
    self.pesCollectionView.dataSource = self;
    self.ctoCollectionView.delegate = self;
    self.ctoCollectionView.dataSource = self;
    self.hlsCollectionView.delegate = self;
    self.hlsCollectionView.dataSource = self;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"Sender %@",sender);
    NSLog(@"In %@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"webViewScreen"]) {
        ResourceBankCollectionViewCell *cell = (ResourceBankCollectionViewCell *) sender;
        NSString *link = cell.httpLink;
        NSLog(@"link %@",link);
        ResourceWebViewController *destinationController =  [segue destinationViewController];
        [destinationController setUrl:link];
    }
}

- (IBAction)unwindToResourceBankView:(UIStoryboardSegue *)segue
{
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"Here...");
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Log: %ld",collectionView.tag);
    if(collectionView.tag == 1) {
        return [self.pesArray count];
    } else if(collectionView.tag == 2) {
        return [self.ctoArray count];
    } else if(collectionView.tag == 3) {
        return [self.hlsArray count];
    }
    return -1;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ResourceBankCell";
    ResourceBankCollectionViewCell *blank =  [self.pesCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSLog(@"Tag %ld",collectionView.tag);
    if(collectionView.tag == 1) {
        ResourceBankCollectionViewCell *cell =  [self.pesCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        [self getViewFor:cell data:self.pesArray view:self.pesCollectionView index:indexPath.row];
        return cell;
        
    }

    if(collectionView.tag == 2) {
        ResourceBankCollectionViewCell *cell =  [self.pesCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        [self getViewFor:cell data:self.ctoArray view:self.ctoCollectionView index:indexPath.row];
        return cell;
        
    }

    if(collectionView.tag == 3) {
        ResourceBankCollectionViewCell *cell =  [self.pesCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        [self getViewFor:cell data:self.hlsArray view:self.hlsCollectionView index:indexPath.row];
        return cell;
        
    }

    return blank;
}

- (UICollectionViewCell *) getViewFor:(ResourceBankCollectionViewCell *)cell data:(NSArray *)data view: (UICollectionView *) view index: (NSInteger) index {
    NSDictionary *dictionary = [data objectAtIndex:index];
    NSString *type = [dictionary objectForKey:@"type"];
    [cell.imageView setImage:[self getImageForType:type]];
    cell.httpLink = [dictionary objectForKey:@"link"];
    cell.textView.text = [dictionary objectForKey:@"title"];
    return cell;
}

- (UIImage *) getImageForType:(NSString *) type {
    if([type isEqualToString:@"pov"]) {
        return self.povImage;
    } else if ([type isEqualToString:@"video_pov"]) {
        return self.videoPovImage;
    } else if ([type isEqualToString:@"success_story"]) {
        return self.successImage;
    }
    return self.povImage;
}

@end

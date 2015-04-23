//
//  BaseViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 21/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)onLogoutClicked:(id)sender {
    NSLog(@"Here...");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"name"];
    [defaults removeObjectForKey:@"email"];
    
    UIStoryboard *storyboard = self.storyboard;
    LoginViewController *viewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = navigation;
}

@end

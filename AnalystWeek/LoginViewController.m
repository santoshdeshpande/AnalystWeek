//
//  LoginViewController.m
//  AnalystWeek
//
//  Created by Santosh S on 13/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "LoginViewController.h"
#import "AnalystWeekHTTPClient.h"
#import "HomeViewController.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user = [defaults objectForKey:@"username"];
    NSString *password = [defaults objectForKey:@"password"];
    self.userName.text = user;
    self.password.text = password;
    [self.userName becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onLoginClicked:(id)sender {
    AnalystWeekHTTPClient *client = [AnalystWeekHTTPClient sharedHTTPClient];
    client.delegate = self;
    
    NSString *userName = self.userName.text;
    if([userName isEqualToString:@""]) {
        [self.userNameErrorLabel setHidden:NO];
        return;
    }
    
    NSString *password = self.password.text;
    if([password isEqualToString:@""]) {
        [self.passwordErrorLabel setHidden:NO];
        return;
    }
    
    [client loginWithUserName:userName password:password];
    
}

-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client loginSucceeded:(id)response {
    NSDictionary *responseDict = (NSDictionary *)response;
    NSString *token = [responseDict objectForKey:@"token"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"auth-token"];
    UIStoryboard *storyboard = self.storyboard;
    HomeViewController *viewController = (HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"homeViewScreen"];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = navigation;
    
    client.delegate = self;
    [client fetchUserInfo];

    
}

-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client userInfoFetched:(id)response {
    NSLog(@"User Info: %@",response);
}


-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client loginFailedWithError:(NSError *)error {
    [self.invalidError setHidden:NO];
}

- (IBAction)unwindToLoginView:(UIStoryboardSegue *)segue
{    
}



@end

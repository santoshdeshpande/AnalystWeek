//
//  AnalystWeekHTTPClient.m
//  AnalystWeek
//
//  Created by Santosh S on 16/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "AnalystWeekHTTPClient.h"
#import "JSONResponseSerializerWithData.h"

//static NSString * const ServerBaseURL = @"https://aw.eatsleepcode.in/api/v1/";
static NSString * const ServerBaseURL = @"http://localhost:8000/api/v1/";

@implementation AnalystWeekHTTPClient

+ (AnalystWeekHTTPClient *)sharedHTTPClient
{
    static AnalystWeekHTTPClient *_sharedHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:ServerBaseURL]];
        _sharedHTTPClient.responseSerializer = [JSONResponseSerializerWithData serializer];
    });
    
    return _sharedHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (void)loginWithUserName:(NSString *)user password:(NSString *)password {
    [SVProgressHUD show];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = user;
    parameters[@"password"] = password;
    NSLog(@"Sending %@  - %@",user, password);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:user forKey:@"username"];
    [defaults setObject:password forKey:@"password"];
    [self POST:@"api-token-auth/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:loginSucceeded:)]) {
            [self.delegate analystHTTPClient:self loginSucceeded:responseObject];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:loginFailedWithError:)]) {
            NSLog(@"%@",error.userInfo);
            [self.delegate analystHTTPClient:self loginFailedWithError:error];
        }
        [SVProgressHUD dismiss];
    }];
}

- (void)postSurveyQuestions:(NSDictionary *)params {
        [SVProgressHUD show];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self POST:@"survey_answers/" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject - %@", responseObject);
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:surveyInformationPosted:)]) {
            [self.delegate analystHTTPClient:self surveyInformationPosted:responseObject];
        }
            [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:loginFailedWithError:)]) {
            NSLog(@"%@",error.userInfo);
            [self.delegate analystHTTPClient:self loginFailedWithError:error];
        }
            [SVProgressHUD dismiss];
    }];
}


- (void) fetchContactInfo {
    [SVProgressHUD show];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self GET:@"contact_info/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:contactInfoFetched:)]) {
            [self.delegate analystHTTPClient:self contactInfoFetched:responseObject];
        }
            [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.userInfo);
            [SVProgressHUD dismiss];
    }];
    
}

- (void) fetchAgenda {
    [SVProgressHUD show];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self GET:@"agenda/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:agendaFetched:)]) {
            [self.delegate analystHTTPClient:self agendaFetched:responseObject];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.userInfo);
        [SVProgressHUD dismiss];
    }];
    
}

- (void) fetchSurvey {
        [SVProgressHUD show];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self GET:@"survey/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:surveyFetched:)]) {
            [self.delegate analystHTTPClient:self surveyFetched:responseObject];
        }
            [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.userInfo);
            [SVProgressHUD dismiss];
    }];
    
}

- (void) fetchMeetings {
        [SVProgressHUD show];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self GET:@"meetings/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:meetingsFetched:)]) {
            [self.delegate analystHTTPClient:self meetingsFetched:responseObject];
        }
            [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.userInfo);
            [SVProgressHUD dismiss];
    }];
    
}


- (void) fetchUserInfo {
        [SVProgressHUD show];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self GET:@"user/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dict = (NSDictionary *)responseObject;
        [defaults setValue:[dict objectForKey:@"email"] forKey:@"email"];
        [defaults setValue:[dict objectForKey:@"first_name"] forKey:@"first_name"];
        [defaults setValue:[dict objectForKey:@"last_name"] forKey:@"last_name"];
        
        NSString *firstName = [defaults objectForKey:@"first_name"];
        NSString *lastName = [defaults objectForKey:@"last_name"];
        NSString *name = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
        [defaults setValue:name forKey:@"name"];
        [SVProgressHUD dismiss];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.userInfo);
            [SVProgressHUD dismiss];
    }];
    
}


- (NSString *) getToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"auth-token"];
    token = [NSString stringWithFormat:@"JWT %@",token];
    return token;
}



@end

//
//  AnalystWeekHTTPClient.m
//  AnalystWeek
//
//  Created by Santosh S on 16/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "AnalystWeekHTTPClient.h"
#import "JSONResponseSerializerWithData.h"

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
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:loginFailedWithError:)]) {
            NSLog(@"%@",error.userInfo);
            [self.delegate analystHTTPClient:self loginFailedWithError:error];
        }
    }];
}

- (void) fetchContactInfo {

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self GET:@"contact_info/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:contactInfoFetched:)]) {
            [self.delegate analystHTTPClient:self contactInfoFetched:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}

- (void) fetchAgenda {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self GET:@"agenda/" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(analystHTTPClient:agendaFetched:)]) {
            [self.delegate analystHTTPClient:self agendaFetched:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}

- (NSString *) getToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"auth-token"];
    token = [NSString stringWithFormat:@"JWT %@",token];
    return token;
}



@end

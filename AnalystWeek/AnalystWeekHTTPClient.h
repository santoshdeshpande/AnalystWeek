//
//  AnalystWeekHTTPClient.h
//  AnalystWeek
//
//  Created by Santosh S on 16/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "SVProgressHUD.h"

@protocol AnalystWeekDelegate;


@interface AnalystWeekHTTPClient : AFHTTPSessionManager

@property (nonatomic, weak) id<AnalystWeekDelegate>delegate;

+ (AnalystWeekHTTPClient *)sharedHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)loginWithUserName:(NSString *)user password:(NSString *)password;
- (void) fetchContactInfo;
- (void) fetchAgenda;
- (void) fetchSurvey;
- (void) fetchUserInfo;
- (void) fetchMeetings;
- (void) fetchUserProfiles;
- (void) fetchChat;
- (void) postChat: (NSDictionary *) params;
- (void) postSurveyQuestions: (NSDictionary *) params;
- (void) postFeedback: (NSDictionary *) params;
- (void) requestMeeting: (NSDictionary *) params;
@end


@protocol AnalystWeekDelegate <NSObject>

@optional
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client loginSucceeded:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client loginFailedWithError:(NSError *)error;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client contactInfoFetched:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client agendaFetched:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client surveyFetched:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client userInfoFetched:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client surveyInformationPosted:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client meetingsFetched:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client meetingRequestPosted:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client userProfilesFetched:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client feedbackPosted:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client chatsFetched:(id)response;
-(void)analystHTTPClient:(AnalystWeekHTTPClient *)client chatPosted:(id)response;
@end
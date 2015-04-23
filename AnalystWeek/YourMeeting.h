//
//  YourMeeting.h
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YourMeeting : NSObject

@property NSString *leaderName;
@property NSString *room;
@property NSString *time;
@property NSString *topic;
@property NSString *date;
@property NSString *analysts;
@property NSString *participants;

- (id) initWithLeader:(NSString *)leader room:(NSString *)roomName atTime:(NSString *)time andTopic:(NSString *)topic;
@end

//
//  YourMeeting.m
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "YourMeeting.h"

@implementation YourMeeting

- (id) initWithLeader:(NSString *)leader room:(NSString *)roomName atTime:(NSString *)time andTopic:(NSString *)topic {
    self = [super init];
    if(self) {
        self.leaderName = leader;
        self.room = roomName;
        self.time = time;
        self.topic = topic;
    }
    return self;
}
@end

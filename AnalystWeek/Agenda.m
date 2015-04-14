//
//  Agenda.m
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "Agenda.h"

@implementation Agenda

- (id) initWithType:(NSString *)type withHeader:(NSString *)header {
    self = [super init];
    if(self) {
        self.type = type;
        self.header = header;
    }
    return self;
}

@end

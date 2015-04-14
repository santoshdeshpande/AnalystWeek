//
//  Agenda.h
//  AnalystWeek
//
//  Created by Santosh S on 14/04/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Agenda : NSObject
@property NSString *type;
@property NSString *header;
@property NSString *info;

- (id) initWithType:(NSString *)type withHeader:(NSString *)header;
@end

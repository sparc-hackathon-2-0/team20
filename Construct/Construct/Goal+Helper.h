//
//  Goal+Helper.h
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "Goal.h"

@interface Goal (Helper)


- (NSInteger)pointValue; // aggregate point value for all activities in this goal
- (NSInteger)numActivities;

+ (NSArray *)availableGoals;
+ (NSArray *)currentGoals;

@end

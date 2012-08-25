//
//  GoalView.h
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalView : UIView

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) id goal;
@property (strong, nonatomic) NSNumber *level;
@property (strong, nonatomic) NSMutableArray *connections;
@property (strong, nonatomic) NSMutableArray *roads;

+ (id)viewWithGoal:(id)goal;

@end

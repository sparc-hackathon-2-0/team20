//
//  GoalListViewController.h
//  Construct
//
//  Created by Emery Clark on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoalListDelegate;

@interface GoalListViewController : UITableViewController

@property (nonatomic, weak) id<GoalListDelegate> goalListDelegate;
@end

@protocol GoalListDelegate <NSObject>

@optional

- (void)finishedAddingGoal:(Goal *)goal sender:(id)sender;
- (void)cancelledAddingGoal:(id)sender;

@end

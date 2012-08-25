//
//  GoalListViewController.h
//  Construct
//
//  Created by Emery Clark on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoalEditDelegate;

@interface GoalListViewController : UITableViewController

@property (nonatomic, weak) id<GoalEditDelegate> goalEditDelegate;
@end

@protocol GoalEditDelegate <NSObject>

@optional

- (void)finishedAddingGoal:(Goal *)goal sender:(id)sender;

@end

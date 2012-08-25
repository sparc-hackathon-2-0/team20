//
//  GoalEditViewController.h
//  Construct
//
//  Created by Emery Clark on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataManager+Helper.h"
#import "Goal.h"

@protocol GoalEditDelegate;

@interface GoalEditViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (nonatomic,strong) CoreDataManager *coreDataManager;
@property (nonatomic,strong) Goal *goal;

@property (nonatomic, weak) id<GoalEditDelegate> goalEditDelegate;
@end

@protocol GoalEditDelegate <NSObject>

@optional

- (void)finishedAddingGoal:(Goal *)goal sender:(id)sender;

@end

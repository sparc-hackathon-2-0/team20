//
//  GoalView.m
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "GoalView.h"

@implementation GoalView

+ (id)viewWithGoal:(id)goal
{
    GoalView *goalView = [[GoalView alloc] init];
    
    NSString *imageName = [NSString stringWithFormat:@"window%i.png",(arc4random() % 2) + 1];
    NSLog(@"%@",imageName);
    
    [goalView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageName]]];
    [goalView setGoal:goal];
    [goalView setFrame:CGRectMake(goalView.frame.origin.x, goalView.frame.origin.y, 15.0 * [goalView.goal pointValue], 25.0 * [goalView.goal pointValue])];
    
    return goalView;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        _roads = [NSMutableArray array];
    }
    return self;
}

- (void)setLevel:(NSNumber *)level
{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, 15.0 * [_goal pointValue], 25.0 * [_goal pointValue])];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

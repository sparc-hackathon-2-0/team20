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
    GoalView *view = [[GoalView alloc] init];
    
    NSString *imageName = [NSString stringWithFormat:@"window%i.png",(arc4random() % 2) + 1];
    NSLog(@"%@",imageName);
    
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageName]]];
    [view setGoal:goal];
    
    return view;
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
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, 30.0 * level.intValue, 50.0 * level.intValue)];
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

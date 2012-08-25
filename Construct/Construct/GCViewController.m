//
//  GCViewController.m
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "GCViewController.h"
#import "GoalEditViewController.h"
#import "ActivityListViewController.h"

@interface GCViewController ()
- (IBAction)displayActivities:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *activityButton;
@property (nonatomic, strong) UIPopoverController *popover;

@end

@implementation GCViewController
@synthesize popover;
@synthesize activityButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    
    map = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [map setAutoresizingMask:self.view.autoresizingMask];
    [map setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundTile.png"]]];
    [map setContentSize:CGSizeMake(2048.0, 1536.0)];
    [map setMinimumZoomScale:0.1];
    [map setMaximumZoomScale:1.0];
    [map setDelegate:self];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton setCenter:CGPointMake(32.0, 736.0)];
    [addButton addTarget:self action:@selector(addGoal:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:map];
    [self.view addSubview:addButton];
    
//    GoalView *firstGoal = [self addGoal:nil AtPoint:CGPointMake(512.0, 128.0)];
//    [firstGoal setConnections:[NSMutableArray arrayWithObjects:[self addGoal:nil AtPoint:CGPointMake(256.0, 384.0)], [self addGoal:nil AtPoint:CGPointMake(768.0, 512.0)], nil]];
    GoalView *goalA = [self addGoal:nil AtPoint:CGPointMake(256.0, 384.0)];
    GoalView *goalB = [self addGoal:nil AtPoint:CGPointMake(768.0, 512.0)];
    GoalView *goalC = [self addGoal:nil AtPoint:CGPointMake(512.0, 128.0)];
    GoalView *goalD = [self addGoal:nil AtPoint:CGPointMake(128.0, 704.0)];
    
    
    [goalA setConnections:[NSMutableArray arrayWithObjects:goalB, goalC, nil]];
    
    [goalB setConnections:[NSMutableArray arrayWithObjects:goalC, goalD, nil]];
    
    [goalD setConnections:[NSMutableArray arrayWithObject:goalC]];
}

- (void)viewDidUnload
{
    [self setActivityButton:nil];
    [self setPopover:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@", segue.identifier);
}

- (IBAction)displayActivities:(id)sender {
  
    UIStoryboard *activityStoryboard = [UIStoryboard storyboardWithName:@"Activity" bundle:nil];
    
    ActivityListViewController *activityListVC = [activityStoryboard instantiateViewControllerWithIdentifier:@"ActivityListViewController"];
    
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:activityListVC];
    
    popover = [[UIPopoverController alloc] initWithContentViewController:navigationVC];
    
    [popover presentPopoverFromRect:activityButton.frame
                             inView:self.view
           permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - Goals

- (void)addGoal:(id)sender
{
    // Present a Goal Edit view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    GoalEditViewController *goalEditVC = [storyboard instantiateViewControllerWithIdentifier:@"GoalEditViewController"];
    
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:goalEditVC];
    [navigationVC setModalPresentationStyle:UIModalPresentationFormSheet];
    
    [self presentViewController:navigationVC animated:YES completion:nil];
    
//    [self addGoal:nil AtPoint:CGPointMake(512.0, 384.0)];
}

- (GoalView *)addGoal:(id)goal AtPoint:(CGPoint)point
{
    if (!goals) {
        goals = [NSMutableArray array];
    }

    GoalView *view = [GoalView viewWithGoal:goal];
    [view setLevel:[NSNumber numberWithInt:(arc4random() % 5) + 1]];
    [view setCenter:point];
    [map addSubview:view];
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [view addGestureRecognizer:gesture];
    
    [goals addObject:view];
    
    return view;
}

#pragma mark - Gestures

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    GoalView *goal = (GoalView *)gesture.view;
    
    if (!dragging) {
        dragging = [NSMutableDictionary dictionary];
    }
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {       CGPoint touchInGoal = [gesture locationInView:goal];
            
            [goal.layer setAnchorPoint:CGPointMake(touchInGoal.x/goal.frame.size.width, touchInGoal.y/goal.frame.size.height)];
            [goal setCenter:[gesture locationInView:map]];
        }   break;
            
        case UIGestureRecognizerStateChanged:
            [goal setCenter:[gesture locationInView:map]];
            
            [map scrollRectToVisible:goal.frame animated:YES];
            
            [self updateConnections];
            break;
            
        case UIGestureRecognizerStateEnded:

            break;
            
        default:
            break;
    }
}

- (void)updateConnectionBetweenGoal:(GoalView *)goalA andAnotherGoal:(GoalView *)goalB
{
    Road *aRoad = nil;
    for (Road *road in goalA.roads) {
        if ([goalB.roads containsObject:road]) {
            aRoad = road;
            break;
        }
    }
    
    if (!aRoad) {
        aRoad = [Road roadWithStart:goalA.center andEnd:goalB.center];
        
        [goalA.roads addObject:aRoad];
        [goalB.roads addObject:aRoad];
        
        [map insertSubview:aRoad atIndex:0];
    }
        
    [aRoad setStart:CGPointMake(goalA.frame.origin.x + goalA.frame.size.width/2.0, goalA.frame.origin.y + goalA.frame.size.height/2.0)];
    [aRoad setEnd:CGPointMake(goalB.frame.origin.x + goalB.frame.size.width/2.0, goalB.frame.origin.y + goalB.frame.size.height/2.0)];
    [aRoad setSize:1.0];
    
    [aRoad update];
//    [aRoad setNeedsDisplay];
    
}

- (void)updateConnections
{
    for (GoalView *goal in goals) {
        for (GoalView *aGoal in goal.connections) {
            [self updateConnectionBetweenGoal:goal andAnotherGoal:aGoal];
        }
    }
}

#pragma mark UIScrollView Delegate

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return [goals objectAtIndex:0];
//}

@end

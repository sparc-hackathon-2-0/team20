//
//  GCViewController.m
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "GCViewController.h"
#import "GoalListViewController.h"
#import "GoalEditViewController.h"
#import "ActivityListViewController.h"

@interface GCViewController () <GoalListDelegate>
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
        
    map = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [map setAutoresizingMask:self.view.autoresizingMask];
    [map setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundTile.png"]]];
    [map setContentSize:CGSizeMake(2048.0, 1536.0)];
    [map setMinimumZoomScale:0.1];
    [map setMaximumZoomScale:1.0];
    [map setDelegate:self];
    
    mapContent = [[UIView alloc] initWithFrame:map.bounds];
    [mapContent setBackgroundColor:[UIColor lightGrayColor]];
    [map addSubview:mapContent];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [addButton setCenter:CGPointMake(32.0, self.view.bounds.size.height - 32.0)];
    [addButton addTarget:self action:@selector(addGoal:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:map];
    [self.view addSubview:addButton];
    
//    GoalView *firstGoal = [self addGoal:nil AtPoint:CGPointMake(512.0, 128.0)];
//    [firstGoal setConnections:[NSMutableArray arrayWithObjects:[self addGoal:nil AtPoint:CGPointMake(256.0, 384.0)], [self addGoal:nil AtPoint:CGPointMake(768.0, 512.0)], nil]];
    Goal *goal = [[Goal alloc] init];

    GoalView *goalA = [self addGoal:goal AtPoint:CGPointMake(256.0, 384.0)];
    GoalView *goalB = [self addGoal:goal AtPoint:CGPointMake(768.0, 512.0)];
    GoalView *goalC = [self addGoal:goal AtPoint:CGPointMake(512.0, 128.0)];
    GoalView *goalD = [self addGoal:goal AtPoint:CGPointMake(128.0, 704.0)];
//
//    
    [goalA setConnections:[NSMutableArray arrayWithObjects:goalB, goalC, nil]];
    
    [goalB setConnections:[NSMutableArray arrayWithObjects:goalC, goalD, nil]];
    
    [goalD setConnections:[NSMutableArray arrayWithObject:goalC]];
    
    [self updateConnections];
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
    GoalListViewController *goalListVC = [storyboard instantiateViewControllerWithIdentifier:@"GoalListViewController"];
    [goalListVC setGoalListDelegate:self];
    
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:goalListVC];
    [navigationVC setModalPresentationStyle:UIModalPresentationFormSheet];
    
    [self presentViewController:navigationVC animated:YES completion:nil];
    
}

- (GoalView *)addGoal:(Goal *)goal AtPoint:(CGPoint)point
{
    if (!goalViews) {
        goalViews = [NSMutableArray array];
    }

    GoalView *view = [GoalView viewWithGoal:goal];
    [view setCenter:point];
    [mapContent addSubview:view];
    
    NSLog(@"MapContent: %@",mapContent);
    
    for (GoalView *goalView in goalViews) {
        
    }
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [view addGestureRecognizer:gesture];
    
    [goalViews addObject:view];
    
    return view;
}

#pragma mark - GoalListDelegate methods

- (void)finishedAddingGoal:(Goal *)goal sender:(id)sender{
    [self addGoal:goal AtPoint:[self.view center]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelledAddingGoal:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
            [goal setCenter:[gesture locationInView:mapContent]];
        }   break;
            
        case UIGestureRecognizerStateChanged:
            [goal setCenter:[gesture locationInView:mapContent]];
            
//            [map scrollRectToVisible:goal.frame animated:YES];
            
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
        
        [mapContent insertSubview:aRoad atIndex:0];
    }
        
    [aRoad setStart:CGPointMake(goalA.frame.origin.x + goalA.frame.size.width/2.0, goalA.frame.origin.y + goalA.frame.size.height/2.0)];
    [aRoad setEnd:CGPointMake(goalB.frame.origin.x + goalB.frame.size.width/2.0, goalB.frame.origin.y + goalB.frame.size.height/2.0)];
    [aRoad setSize:1.0];
    
    [aRoad update];
}

- (void)updateConnections
{
    for (GoalView *goal in goalViews) {
        for (GoalView *aGoal in goal.connections) {
            [self updateConnectionBetweenGoal:goal andAnotherGoal:aGoal];
        }
    }
}

//- (GoalView *)goalViewForGoal:(Goal *)goal
//{
//    for (GoalView *goal in goalViews) {
//        if (goal.goal == goal) {
//            return goal;
//        }
//    }
//}

#pragma mark UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return mapContent;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    NSLog(@"ScrollView Bounds: %@",NSStringFromCGRect(scrollView.bounds));
    NSLog(@"ScrollView Frame: %@",NSStringFromCGRect(scrollView.frame));
    NSLog(@"ScrollView Center: %@",NSStringFromCGPoint(scrollView.center));
    NSLog(@"ScrollView ContentSize: %@",NSStringFromCGSize(scrollView.contentSize));
    
    NSLog(@"MapContent Bounds: %@",NSStringFromCGRect(mapContent.bounds));
    NSLog(@"MapContent Frame: %@",NSStringFromCGRect(mapContent.frame));
    NSLog(@"MapContent Center: %@",NSStringFromCGPoint(mapContent.center));
    
    
    [mapContent setFrame:CGRectMake(0.0, 0.0, scrollView.contentSize.width, scrollView.contentSize.height)];
    
    [mapContent setCenter:self.view.center];
}

@end

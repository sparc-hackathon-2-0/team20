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
    [map setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [map setBackgroundColor:[UIColor lightGrayColor]];
    [map setContentSize:CGSizeMake(self.view.bounds.size.width*4.0, self.view.bounds.size.height*4.0)];
    [map setMinimumZoomScale:0.25];
    [map setMaximumZoomScale:1.0];
    [map setContentOffset:CGPointMake(self.view.bounds.size.width*1.5, self.view.bounds.size.height*1.5)];
    [map setDelegate:self];
    
    NSLog(@"View.Bounds.Width: %f",self.view.bounds.size.width);
    NSLog(@"View.Bounds.Height: %f",self.view.bounds.size.height);
    
    NSLog(@"View.Frame.Width: %f",self.view.frame.size.width);
    NSLog(@"View.Frame.Height: %f",self.view.frame.size.height);
    
    mapContent = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width*4.0, self.view.bounds.size.height*4.0)];
    [mapContent setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [mapContent setAutoresizesSubviews:YES];
    [mapContent setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundTile.png"]]];
    [map addSubview:mapContent];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [addButton setCenter:CGPointMake(32.0, self.view.bounds.size.height - 32.0)];
    [addButton addTarget:self action:@selector(addGoal:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:map];
    [self.view addSubview:addButton];
    
    //    GoalView *firstGoal = [self addGoal:nil AtPoint:CGPointMake(512.0, 128.0)];
    //    [firstGoal setConnections:[NSMutableArray arrayWithObjects:[self addGoal:nil AtPoint:CGPointMake(256.0, 384.0)], [self addGoal:nil AtPoint:CGPointMake(768.0, 512.0)], nil]];
    for (Goal *goal in [Goal currentGoals]) {
        GoalView *goalView = [self addGoal:goal AtPoint:CGPointMake(mapContent.center.x+200, mapContent.center.y)];
        
        GoalView *otherGoalView = [goalViews objectAtIndex:(arc4random() % goalViews.count)];
        
        if (goalView != otherGoalView) {
            [goalView setConnections:[NSMutableArray arrayWithObject:otherGoalView]];
        }
        
    }
        
//    GoalView *goalView = [self addGoal:[[Goal alloc] init] AtPoint:CGPointMake(mapContent.center.x+200, mapContent.center.y)];


}

- (void)viewDidUnload
{
    [self setActivityButton:nil];
    [self setPopover:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"View.Bounds.Width: %f",self.view.bounds.size.width);
    NSLog(@"View.Bounds.Height: %f",self.view.bounds.size.height);
    
    NSLog(@"View.Frame.Width: %f",self.view.frame.size.width);
    NSLog(@"View.Frame.Height: %f",self.view.frame.size.height);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"View.Bounds.Width: %f",self.view.bounds.size.width);
    NSLog(@"View.Bounds.Height: %f",self.view.bounds.size.height);
    
    NSLog(@"View.Frame.Width: %f",self.view.frame.size.width);
    NSLog(@"View.Frame.Height: %f",self.view.frame.size.height);
    
//    [map setContentSize:CGSizeMake(self.view.bounds.size.width*4.0, self.view.bounds.size.height*4.0)];
//    [map setContentOffset:CGPointMake(self.view.bounds.size.width*1.5, self.view.bounds.size.height*1.5)];
//    
//    [mapContent setFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width*4.0, self.view.bounds.size.height*4.0)];
    
    NSLog(@"ScrollView Bounds: %@",NSStringFromCGRect(map.bounds));
    NSLog(@"ScrollView Frame: %@",NSStringFromCGRect(map.frame));
    NSLog(@"ScrollView Center: %@",NSStringFromCGPoint(map.center));
    NSLog(@"ScrollView ContentSize: %@",NSStringFromCGSize(map.contentSize));
    NSLog(@"ScrollView ZoomScale: %f",map.zoomScale);
    
    NSLog(@"MapContent Bounds: %@",NSStringFromCGRect(mapContent.bounds));
    NSLog(@"MapContent Frame: %@",NSStringFromCGRect(mapContent.frame));
    NSLog(@"MapContent Center: %@",NSStringFromCGPoint(mapContent.center));
    NSLog(@"MapContent Super: %@",mapContent.superview);

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Actvities

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

    GoalView *goalView = [GoalView viewWithGoal:goal];
    [goalView setCenter:point];
    [mapContent addSubview:goalView];
    
    NSLog(@"MapContent: %@",mapContent);
    
    for (GoalView *goalView in goalViews) {
        
    }
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [goalView addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goalViewTapped:)];
    [goalView addGestureRecognizer:tapGesture];
    
    [goalViews addObject:goalView];
    
    return goalView;
}

- (void)goalViewTapped:(UITapGestureRecognizer *)gesture
{
    GoalView *goalView = (GoalView *)[gesture view];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Activity" bundle:nil];
//    UIViewController *goalInfoViewController = [storyboard instantiateViewControllerWithIdentifier:@"GoalInfoViewController"];
    UIViewController *goalInfoViewController = [[UIViewController alloc] init];
    [goalInfoViewController setContentSizeForViewInPopover:CGSizeMake(320.0, 480.0)];
    
    if (goalViewInfoPopoverController.isPopoverVisible) {
        [goalViewInfoPopoverController dismissPopoverAnimated:YES];
        goalViewInfoPopoverController = nil;
    }
    
    goalViewInfoPopoverController = [[UIPopoverController alloc] initWithContentViewController:goalInfoViewController];
    [goalViewInfoPopoverController presentPopoverFromRect:goalView.frame inView:mapContent permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - GoalListDelegate methods

- (void)finishedAddingGoal:(Goal *)goal sender:(id)sender{
    [self addGoal:goal AtPoint:[mapContent center]];
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

#pragma mark - Roads

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

#pragma mark - UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return mapContent;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents

    
//    [mapContent setBounds:CGRectMake(0.0, 0.0, scrollView.contentSize.width, scrollView.contentSize.height)];
    
//    CGRect temp = mapContent.bounds;
//    temp.size.width = 1024.0/scrollView.zoomScale;
//    temp.size.height = 768.0/scrollView.zoomScale;
//    [mapContent setBounds:temp];
    
//    mapContent setFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
//    [mapContent setCenter:CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0)];
}

@end

//
//  GCViewController.m
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "GCViewController.h"
#import "ActivityListViewController.h"

@interface GCViewController ()
- (IBAction)displayActivities:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *activityButton;
@property (nonatomic, strong) UIPopoverController *popover;

@end

@implementation GCViewController
@synthesize popover;
@synthesize activityButton;
@synthesize managedObjectContext;
@synthesize fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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

@end

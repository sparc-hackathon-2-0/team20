//
//  GoalEditViewController.m
//  Construct
//
//  Created by Emery Clark on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "GoalEditViewController.h"

@interface GoalEditViewController () <UITextFieldDelegate, UITextViewDelegate>
- (IBAction)saveEdit:(id)sender;
- (IBAction)cancelEdit:(id)sender;
@end

@implementation GoalEditViewController

@synthesize nameTextField;
@synthesize descriptionTextView;
@synthesize coreDataManager;
@synthesize goal, goalEditDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameTextField.text = goal.goalName;
    self.descriptionTextView.text = goal.goalDescription;
    
    [self setContentSizeForViewInPopover:CGSizeMake(400, 400)];

    self.nameTextField.delegate = self;
    self.descriptionTextView.delegate = self;
    
    coreDataManager = [CoreDataManager namedManagerWithName:@"Construct"];

}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [self setDescriptionTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (IBAction)saveEdit:(id)sender {
    if(!goal){
        goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                             inManagedObjectContext:[coreDataManager managedObjectContext]];
    }

    goal.goalName = self.nameTextField.text;
    goal.goalDescription = self.descriptionTextView.text;
    
    NSError *error;
    [[goal managedObjectContext] save:&error];
    [[self navigationController] dismissModalViewControllerAnimated:YES];
    
    [self.goalEditDelegate finishedAddingGoal:goal sender:self];
}

- (IBAction)cancelEdit:(id)sender {
    [[self navigationController] dismissModalViewControllerAnimated:YES];
}
@end

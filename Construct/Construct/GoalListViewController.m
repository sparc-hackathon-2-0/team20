//
//  GoalListViewController.m
//  Construct
//
//  Created by Emery Clark on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "GoalListViewController.h"
#import "GoalEditViewController.h"
#import "CoreDataManager+Helper.h"
#import "Goal.h"

@interface GoalListViewController () <GoalEditDelegate>
@property (nonatomic,strong) CoreDataManager *coreDataManager;
@property (nonatomic,strong) NSArray *goals;

- (IBAction)cancelAddGoal:(id)sender;

@end

@implementation GoalListViewController
@synthesize coreDataManager;
@synthesize goals;
@synthesize goalListDelegate;

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

     coreDataManager = [CoreDataManager namedManagerWithName:@"Construct"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    goals = [Goal availableGoals];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   
    return [goals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GoalListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Goal *goal = [goals objectAtIndex:indexPath.row];
    
    if (goal){
        [[cell textLabel] setText:[goal goalName]];
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Points: %d, Activities: %d",[goal totalValue],[goal numActivities]]];
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Goal *selectedGoal = [goals objectAtIndex:indexPath.row];
    [selectedGoal setInProgress:[NSNumber numberWithBool:YES]];
    
    NSError *error = nil;
    [[selectedGoal managedObjectContext] save:&error];
  
    [self.goalListDelegate finishedAddingGoal:selectedGoal sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"editGoalCell"]) {
       
        GoalEditViewController *goalEditVC = segue.destinationViewController;
        
        goalEditVC.goal = [goals objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        [goalEditVC setGoalEditDelegate:self];
    }

}

#pragma mark - Goal Edit Delegate

- (void) savedGoal:(Goal *)goal sender:(id)sender
{
    [self.goalListDelegate finishedAddingGoal:goal sender:self];
}



- (IBAction)cancelAddGoal:(id)sender {
    
    [self.goalListDelegate cancelledAddingGoal:self];
}

@end

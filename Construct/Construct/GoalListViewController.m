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

@interface GoalListViewController ()
@property (nonatomic,strong) CoreDataManager *coreDataManager;
@property (nonatomic,strong) NSArray *goals;
@end

@implementation GoalListViewController
@synthesize coreDataManager;
@synthesize goals;

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
    goals = [NSArray arrayWithArray:[coreDataManager getAllForEntityNamed:@"Goal"
                                                             withPredicate:nil
                                                           sortDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"goalName" ascending:YES selector:@selector(caseInsensitiveCompare:)] ] ] ];
    NSLog(@"vwa");
    //[self.tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"vda");

    //[self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
   
    return [coreDataManager getCountForEntity:@"Goal" withPredicate:nil];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GoalListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Goal *goal = [goals objectAtIndex:indexPath.row];
    
    // Configure the cell...
    [[cell textLabel] setText:[goal goalName]];
    [[cell detailTextLabel] setText:[goal goalDescription]];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"editGoalCell"]) {
        GoalEditViewController *goalEditVC = segue.destinationViewController;
        goalEditVC.goal = [goals objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }

}
@end

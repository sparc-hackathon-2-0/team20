//
//  ActivityListViewController.m
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "ActivityListViewController.h"
#import "ActivityEditViewController.h"

@interface ActivityListViewController ()
@property (nonatomic,strong) CoreDataManager *coreDataManager;
@property (nonatomic,strong) NSArray *activities;

@end

@implementation ActivityListViewController
@synthesize coreDataManager, activities;

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

    coreDataManager = [CoreDataManager namedManagerWithName:COREDATA_CONSTRUCT];
    
    activities = [NSArray arrayWithArray:[coreDataManager getAllForEntityNamed:@"Activity"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [activities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivityListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Activity *activity = [activities objectAtIndex:indexPath.row];
    // Configure the cell...
    
    [[cell textLabel] setText:[activity activityName]];
    [[cell detailTextLabel] setText:[activity activityDescription]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    Activity *selectedActivity = [activities objectAtIndex:[[segue.sourceViewController tableView] indexPathForSelectedRow].row];
    
    [(ActivityEditViewController *)segue.destinationViewController setActivity:selectedActivity];
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

@end

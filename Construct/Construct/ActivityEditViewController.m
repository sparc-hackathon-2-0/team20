//
//  ActivityEditViewController.m
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "ActivityEditViewController.h"

@interface ActivityEditViewController ()

@property (nonatomic, strong) CoreDataManager *coreDataManager;

- (IBAction)cancelEdit:(id)sender;
- (IBAction)saveActivity:(id)sender;

@end

@implementation ActivityEditViewController
@synthesize coreDataManager;
@synthesize activity;
@synthesize activityNameTextField;
@synthesize activityDescriptionTxtView;

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

    [self configureUI];
}

- (void)viewDidUnload
{
    [self setActivityNameTextField:nil];
    [self setActivityDescriptionTxtView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)configureUI{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
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

- (IBAction)cancelEdit:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveActivity:(id)sender {
    
    if(!activity){
        activity = [NSEntityDescription insertNewObjectForEntityForName:@"Activity"
                                                 inManagedObjectContext:[coreDataManager managedObjectContext]];
    }
    activity.activityDescription = self.activityDescriptionTxtView.text;
    activity.activityName = self.activityNameTextField.text;
    
    NSError *error = nil;
    [[activity managedObjectContext] save:&error];
    [[self navigationController] popViewControllerAnimated:YES];
    
}
@end

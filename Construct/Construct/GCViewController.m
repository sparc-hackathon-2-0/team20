//
//  GCViewController.m
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "GCViewController.h"

@interface GCViewController ()

@end

@implementation GCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *map = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [map setAutoresizingMask:self.view.autoresizingMask];
    [map setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundTile.png"]]];
    [map setContentSize:CGSizeMake(2048.0, 1536.0)];
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton setCenter:CGPointMake(32.0, 736.0)];
    [addButton addTarget:self action:@selector(addBlock:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:map];
    [self.view addSubview:addButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)addBlock:(id)sender
{
    NSLog(@"Add a Block");
}

@end

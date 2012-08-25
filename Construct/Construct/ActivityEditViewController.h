//
//  ActivityEditViewController.h
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityEditViewController : UITableViewController

@property (nonatomic, strong) Activity *activity;
@property (weak, nonatomic) IBOutlet UITextField *activityNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *activityDescriptionTxtView;

@end

//
//  GCViewController.h
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCViewController : UIViewController <UIScrollViewDelegate>
{
    NSMutableArray *goalViews;
    UIScrollView *map;
    UIView *mapContent;
    
    NSMutableDictionary *dragging;
}

@end

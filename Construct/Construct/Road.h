//
//  Road.h
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Road : UIView

@property (nonatomic, readwrite) CGPoint start;
@property (nonatomic, readwrite) CGPoint end;
@property (nonatomic, readwrite) CGFloat size;

+ (Road *)roadWithStart:(CGPoint)start andEnd:(CGPoint)end;
+ (Road *)roadWithStart:(CGPoint)start andEnd:(CGPoint)end andSize:(CGFloat)size;

- (void)update;

@end

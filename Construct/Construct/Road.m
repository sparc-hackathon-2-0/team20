//
//  Road.m
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "Road.h"

@implementation Road

+ (Road *)roadWithStart:(CGPoint)start andEnd:(CGPoint)end
{
    return [Road roadWithStart:start andEnd:end andSize:1.0];
}

+(Road *)roadWithStart:(CGPoint)start andEnd:(CGPoint)end andSize:(CGFloat)size
{
    int width = abs(start.x - end.x);
    int height = abs(start.y - end.y);
    
    Road *road = [[Road alloc] initWithFrame:CGRectMake(start.x, start.y, width, size * 10.0)];
    [road setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"road.png"]]];
    [road setUserInteractionEnabled:NO];
    
    [road.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
    
    [road setStart:start];
    [road setEnd:end];
    [road setSize:size];
        
    return road;
}

- (void)update
{
    int width = abs(_start.x - _end.x);
    int height = abs(_start.y - _end.y);
    
    CGPoint p1 = _start;
    CGPoint p2 = _end;
    
    float adjacent = p2.x-p1.x;
    float opposite = p2.y-p1.y;
    float hypotenuse = sqrtf(powf(adjacent, 2.0) + powf(opposite, 2.0));
        
    float angle = atan2f(adjacent, opposite);
    
    [self setBounds:CGRectMake(_start.x, _start.y, hypotenuse,  _size * 10.0)];
    [self setCenter:CGPointMake(_start.x, _start.y)];
    
    NSLog(@"Angle: %f (%f)",angle,angle * (180/M_PI));
    
    [self setTransform:CGAffineTransformMakeRotation(angle * -1 + M_PI_2)];
    
    
}

//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    NSLog(@"Road DrawRect");
//    
//    int width = abs(_start.x - _end.x);
//    int height = abs(_start.y - _end.y);
//    
//    [self setFrame:CGRectMake(_start.x, _start.y, width, height)];
//    
//    NSLog(@"Start: %@",NSStringFromCGPoint(_start));
//    NSLog(@"Start: %@",NSStringFromCGPoint(_end));
//        
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetLineCap(context, kCGLineCapSquare);
//         
//    CGMutablePathRef roadPath = CGPathCreateMutable();
//    CGPathMoveToPoint(roadPath, NULL, 0, 0);
//    CGPathAddLineToPoint(roadPath, NULL, width, height);
//    CGPathAddLineToPoint(roadPath, NULL, width+5, height+5);
//    CGPathMoveToPoint(roadPath, NULL, 0+5, 0+5);
//    CGPathCloseSubpath(roadPath);
//        
//    CGContextAddPath(context, roadPath);
//    
////    CGContextFillPath(context);
//    
//    CGContextFillPath(context);
//    CGContextStrokePath(context);
//}

@end

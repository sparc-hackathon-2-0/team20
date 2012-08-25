//
//  Category.h
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSDate * categoryDescription;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSNumber * maxPointValue;
@property (nonatomic, retain) NSNumber * minPointValue;
@property (nonatomic, retain) Activity *activities;

@end

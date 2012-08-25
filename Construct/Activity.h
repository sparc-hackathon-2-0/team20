//
//  Activity.h
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Goal;

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSString * activityName;
@property (nonatomic, retain) NSString * activityDescription;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSNumber * pointValue;
@property (nonatomic, retain) NSSet *goals;
@property (nonatomic, retain) NSManagedObject *category;
@end

@interface Activity (CoreDataGeneratedAccessors)

- (void)addGoalsObject:(Goal *)value;
- (void)removeGoalsObject:(Goal *)value;
- (void)addGoals:(NSSet *)values;
- (void)removeGoals:(NSSet *)values;

@end

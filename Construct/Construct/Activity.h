//
//  Activity.h
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ActivityTag, Category, Goal;

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSString * activityDescription;
@property (nonatomic, retain) NSString * activityName;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * inProgress;
@property (nonatomic, retain) NSNumber * pointValue;
@property (nonatomic, retain) Category *category;
@property (nonatomic, retain) NSSet *goals;
@property (nonatomic, retain) NSSet *tags;
@end

@interface Activity (CoreDataGeneratedAccessors)

- (void)addGoalsObject:(Goal *)value;
- (void)removeGoalsObject:(Goal *)value;
- (void)addGoals:(NSSet *)values;
- (void)removeGoals:(NSSet *)values;

- (void)addTagsObject:(ActivityTag *)value;
- (void)removeTagsObject:(ActivityTag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end

//
//  ActivityTag.h
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity;

@interface ActivityTag : NSManagedObject

@property (nonatomic, retain) NSString * activitityTagName;
@property (nonatomic, retain) NSString * activityTagDescription;
@property (nonatomic, retain) NSString * creationDate;
@property (nonatomic, retain) NSSet *activities;
@end

@interface ActivityTag (CoreDataGeneratedAccessors)

- (void)addActivitiesObject:(Activity *)value;
- (void)removeActivitiesObject:(Activity *)value;
- (void)addActivities:(NSSet *)values;
- (void)removeActivities:(NSSet *)values;

@end

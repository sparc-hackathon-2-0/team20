//
//  Goal+Helper.m
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "Goal+Helper.h"

@implementation Goal (Helper)

- (NSInteger)totalValue{
    
    NSArray *goalActivities = [[self activities] allObjects];
    
    NSInteger totalPointValue = 0;
    
    for (Activity *activity in goalActivities){
        totalPointValue = totalPointValue + [[activity pointValue] integerValue];
    }
    
    return totalPointValue;
    
}

- (NSInteger)numActivities{
    return [[[self activities] allObjects] count];
}

+ (NSArray *)availableGoals{
 
    CoreDataManager *coreDataManager = [CoreDataManager namedManagerWithName:COREDATA_CONSTRUCT];
    NSArray *availableGoalsArray = [NSArray arrayWithArray:[coreDataManager getAllForEntityNamed:@"Goal"
                                                    withPredicate:[NSPredicate predicateWithFormat:@"inProgress == %@", [NSNumber numberWithBool:NO]]
                                                  sortDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"goalName" ascending:YES selector:@selector(caseInsensitiveCompare:)] ] ] ];
    
    return availableGoalsArray;
}


+ (NSArray *)currentGoals{
    
    CoreDataManager *coreDataManager = [CoreDataManager namedManagerWithName:COREDATA_CONSTRUCT];
    NSArray *currentGoalsArray = [NSArray arrayWithArray:[coreDataManager getAllForEntityNamed:@"Goal"
                                                                                 withPredicate:[NSPredicate predicateWithFormat:@"inProgress == %@", [NSNumber numberWithBool:YES]]
                                                                               sortDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"goalName" ascending:YES selector:@selector(caseInsensitiveCompare:)] ] ] ];
    return currentGoalsArray;
}

@end

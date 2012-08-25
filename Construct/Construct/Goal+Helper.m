//
//  Goal+Helper.m
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "Goal+Helper.h"

@implementation Goal (Helper)

- (NSInteger)pointValue{
    
    CoreDataManager *coreDataManager = [CoreDataManager namedManagerWithName:COREDATA_CONSTRUCT];
    
    return 3;
    
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

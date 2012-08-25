//
//  ActivityTag.h
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ActivityTag : NSManagedObject

@property (nonatomic, retain) NSString * activitityTagName;
@property (nonatomic, retain) NSString * activityTagDescription;
@property (nonatomic, retain) NSString * creationDate;

@end

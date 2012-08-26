//
//  CoreDataManager+DefaultData.m
//  Construct
//
//  Created by Alondo  on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "CoreDataManager+DefaultData.h"
#import "CoreDataManager+Helper.h"

@implementation CoreDataManager (DefaultData)

- (void)loadDefaultData{
    
    NSError *error = nil;
    
    // Create Default categories
    Category *novice = (Category *)[self insertManagedObjectForEntityName:@"Category"];
    [novice setCategoryName:@"Novice"];
    [novice setCategoryDescription:@"Focus is on learning"];
    [novice setMinPointValue:[NSNumber numberWithInt:1]];
    [novice setMaxPointValue:[NSNumber numberWithInt:20]];
    
    Category *intermediate = (Category *)[self insertManagedObjectForEntityName:@"Category"];
    [intermediate setCategoryName:@"Intermediate"];
    [intermediate setCategoryDescription:@"Focus is on applying and enhancing knowledge or skill"];
    [intermediate setMinPointValue:[NSNumber numberWithInt:20]];
    [intermediate setMaxPointValue:[NSNumber numberWithInt:50]];
    
    Category *advanced = (Category *)[self insertManagedObjectForEntityName:@"Category"];
    [advanced setCategoryName:@"Advanced"];
    [advanced setCategoryDescription:@"Focus is on providing practical/relevant ideas and perspectives on process or practice improvements"];
    [advanced setMinPointValue:[NSNumber numberWithInt:50]];
    [advanced setMaxPointValue:[NSNumber numberWithInt:75]];
    
    Category *expert = (Category *)[self insertManagedObjectForEntityName:@"Category"];
    [expert setCategoryName:@"Expert"];
    [expert setCategoryDescription:@"Focus is on creating new applications for and/or lead the development of reference and resource materials"];
    [expert setMinPointValue:[NSNumber numberWithInt:75]];
    [expert setMaxPointValue:[NSNumber numberWithInt:100]];
    
    Goal *iOSGuru = (Goal *)[self insertManagedObjectForEntityName:@"Goal"];
    [iOSGuru setGoalName:@"iOS Guru"];
    [iOSGuru setGoalDescription:@"AppStore Icon"];
    [iOSGuru setInProgress:[NSNumber numberWithBool:YES]];
    [[iOSGuru managedObjectContext] save:&error];
    
    Goal *phpNinja = (Goal *)[self insertManagedObjectForEntityName:@"Goal"];
    [phpNinja setGoalName:@"PHP Ninja"];
    [phpNinja setGoalDescription:@"Web Assassin"];
    [phpNinja setInProgress:[NSNumber numberWithBool:NO]];
    [[phpNinja managedObjectContext] save:&error];
    
    Goal *androidRockstar = (Goal *)[self insertManagedObjectForEntityName:@"Goal"];
    [androidRockstar setGoalName:@"Android Rockstar"];
    [androidRockstar setGoalDescription:@"Rockin' code"];
    [androidRockstar setInProgress:[NSNumber numberWithBool:YES]];
    [[androidRockstar managedObjectContext] save:&error];
    
    Activity *tutorial = (Activity *)[self insertManagedObjectForEntityName:@"Activity"];
    [tutorial setActivityName:@"Read/watch tutorial"];
    [tutorial setCategory:intermediate];
    [tutorial setPointValue:[NSNumber numberWithInt:10]];
    
    [iOSGuru addActivitiesObject:tutorial];
    [androidRockstar addActivitiesObject:tutorial];
    [phpNinja addActivitiesObject:tutorial];
    
    Activity *answerStack = (Activity *)[self insertManagedObjectForEntityName:@"Activity"];
    [answerStack setActivityName:@"Answer Stack Overflow question"];
    [answerStack setCategory:intermediate];
    [answerStack setPointValue:[NSNumber numberWithInt:20]];
    
    [iOSGuru addActivitiesObject:answerStack];
    [androidRockstar addActivitiesObject:answerStack];
    [phpNinja addActivitiesObject:answerStack];

    Activity *hackathon = (Activity *)[self insertManagedObjectForEntityName:@"Activity"];
    [hackathon setActivityName:@"Participate in Hackathon"];
    [hackathon setCategory:advanced];
    [hackathon setPointValue:[NSNumber numberWithInt:50]];
    
    [iOSGuru addActivitiesObject:hackathon];
    [androidRockstar addActivitiesObject:hackathon];
    
    Activity *portLib = (Activity *)[self insertManagedObjectForEntityName:@"Activity"];
    [portLib setActivityName:@"Port open source library from another platform"];
    [portLib setCategory:expert];
    [portLib setPointValue:[NSNumber numberWithInt:80]];
    
    [iOSGuru addActivitiesObject:portLib];
    [androidRockstar addActivitiesObject:portLib];
    
    Activity *writeFramework = (Activity *)[self insertManagedObjectForEntityName:@"Activity"];
    [writeFramework setActivityName:@"Write Framework"];
    [writeFramework setCategory:advanced];
    [writeFramework setPointValue:[NSNumber numberWithInt:65]];
    
    [iOSGuru addActivitiesObject:writeFramework];
    [androidRockstar addActivitiesObject:writeFramework];
    [phpNinja addActivitiesObject:writeFramework];
    
    Activity *manMonth = (Activity *)[self insertManagedObjectForEntityName:@"Activity"];
    [manMonth setActivityName:@"Read Mythical Man Month"];
    [manMonth setCategory:novice];
    [manMonth setPointValue:[NSNumber numberWithInt:5]];
    
    [iOSGuru addActivitiesObject:manMonth];
    [phpNinja addActivitiesObject:manMonth];
    [androidRockstar addActivitiesObject:manMonth];
    
    

    
    
    
}

- (void)createDefaultCategories{
    
}

@end

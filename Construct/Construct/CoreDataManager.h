//
//  CoreDataManager.h
//  Apartments
//
//  Created by Alondo Brewington on 7/26/12.
//  Copyright (c) 2012 DT Squared Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define COREDATA_DEFAULT_EXTENSION @"momd"

@protocol CoreDataManagerDelegate;

@interface CoreDataManager : NSObject

+ (CoreDataManager *)namedManagerWithName:(NSString *)name;
+ (CoreDataManager *)managerWithName:(NSString *)name withFileName:(NSString *) fileName withExtension:(NSString *)extension;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, assign) id<CoreDataManagerDelegate> delegate;

- (void)saveContext;

@end

@protocol CoreDataManagerDelegate <NSObject>

@optional

- (void) coreDataManager:(CoreDataManager *)namedManager didFailToCreatePersistentStoreCoordinator:(NSError *)error;
- (NSDictionary *) optionsForPersistentStoreCoordinatorCreationForCoreDatamanager:(CoreDataManager *)namedManager;
- (NSString *) configurationForPersistentStoreCoordinatorCreationForCoreDataManager:(CoreDataManager *)namedManager;
- (BOOL) shouldUseAutomaticMigrationOptionForPersistentStoreCoordinatorCreationForCoreDataManager:(CoreDataManager *)namedManger;



@end

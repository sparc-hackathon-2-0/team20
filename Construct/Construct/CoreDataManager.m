//
//  CoreDataManager.m
//  Apartments
//
//  Created by Alondo Brewington on 7/26/12.
//  Copyright (c) 2012 DT Squared Software, LLC. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager()

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *extension;

@end

@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize delegate;
@synthesize name = _name;
@synthesize fileName = _fileName;
@synthesize extension = _extension;

#pragma mark - Initialization and Deallocation

static NSMutableDictionary *namedManagers;
static BOOL _persistentStoreIsIncompatible = NO;

- (CoreDataManager *)initWithName:(NSString *)name withFileName:(NSString *) fileName withExtension:(NSString *)extension {
    
    self = [self init];
    
    if (self) {
        
        self.name = name;
        self.fileName = fileName;
        self.extension = extension;
        
        if (namedManagers == nil) {
            
            namedManagers = [[NSMutableDictionary alloc] init];
        }
        [namedManagers setValue:self forKey:name];
    }
    
    return self;
}

+ (CoreDataManager *)managerWithName:(NSString *)name withFileName:(NSString *) fileName withExtension:(NSString *)extension {
    
    return [[CoreDataManager alloc] initWithName:name
                                    withFileName:fileName
                                   withExtension:extension];
}


- (void)dealloc {
    
    self.delegate = nil;
    self.managedObjectModel = nil;
    self.managedObjectContext = nil;
    self.persistentStoreCoordinator = nil;
    self.name = nil;
    self.fileName = nil;
    self.extension = nil;
}

#pragma mark - Convenience Methods

+ (CoreDataManager *)namedManagerWithName:(NSString *)name {
    
    CoreDataManager *manager = [namedManagers objectForKey:name];
    
    return manager;
}

#pragma mark - CoreDataManager

- (void)saveContext {
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


#pragma mark - Core Data Stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */

- (NSManagedObjectContext *)managedObjectContext {
  
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */

- (NSManagedObjectModel *)managedObjectModel {
   
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.name withExtension:self.extension];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.fileName];
    
    NSError *error = nil;
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, 
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
  
    NSString *configuration = nil;
    
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
   
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:configuration URL:storeURL options:options error:&error]) 
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, 
         although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs 
         the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into 
         the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, 
         [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; 
         Consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
		 */
        
        NSLog(@"[CoreDataManager persistentStoreCoordinator] Unresolved error in %@ %@, %@", [self name], error, [error userInfo]);
		
        _persistentStoreIsIncompatible = YES;
        return nil;
    }    

    
    return _persistentStoreCoordinator;
}


- (BOOL)migrationNeeded{
    
    NSError *error = nil;
    NSURL *sourceStoreURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.fileName];
    
    // Determine if a migration is needed
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType
                                                                                              URL:sourceStoreURL
                                                                                            error:&error];
    
    NSManagedObjectModel *destinationModel = [self.persistentStoreCoordinator managedObjectModel];
    
    BOOL pscCompatibile = [destinationModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata];
    
    NSLog(@"Migration needed? %d", !pscCompatibile);
    
    return pscCompatibile;
}

#pragma mark - CoreDataManagerDelegate methods

- (BOOL)shouldUseAutomaticMigrationOptionForPersistentStoreCoordinatorCreationForCoreDataManager:(CoreDataManager *)namedManger{
  
    return YES;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */

- (NSURL *)applicationDocumentsDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory 
                                                   inDomains:NSUserDomainMask] lastObject];
}

@end

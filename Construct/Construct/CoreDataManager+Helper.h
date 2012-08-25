//
//  CoreDataManager+Helper.h
//  Apartments
//
//  Created by Alondo Brewington on 7/26/12.
//  Copyright (c) 2012 DT Squared Software, LLC. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager (Helper)

// Helper Methods

/** Configures an NSFetchedRequest for the provided entityName */ 
- (NSFetchRequest *)fetchForEntityNamed:(NSString *)entityName;
- (NSFetchRequest *)fetchForEntityNamed:(NSString *)entityName withPredicate:(NSPredicate *)predicate;

- (NSArray *)executeFetch:(NSFetchRequest *)fetchRequest;
- (void) deleteAllObjects: (NSString * )entityName;

- (void)deleteObject:(NSManagedObject *)managedObject;

- (NSUInteger)getCountForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate;

- (NSArray *)getAllForEntityNamed:(NSString *)entityName 
                    withPredicate:(NSPredicate *)predicate 
                  sortDescriptors:(NSArray *)sortDescriptors;

- (NSArray *)getAllForEntityNamed:(NSString *)entityName withPredicate:(NSPredicate *)predicate sortDescriptor:(NSString *)currentSortOrder;

- (NSManagedObject *)getEntityNamed:(NSString *)entityName withPropertyNamed:(NSString *)propName matchingValue:(NSString *)value;

- (NSManagedObject *)getEntityNamed:(NSString *)entityName withTitle:(NSString *)title;
- (NSArray *)getAllForEntityNamed:(NSString *)entityName;
- (NSArray *)getAllForEntityNamed:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
- (NSArray *)getMatchesForEntityNamed:(NSString *)entityName withObjectIdArray:(NSArray *)objectIdArray;

- (NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entity withPredicate:(NSPredicate *)predicate;
- (NSManagedObject *)insertManagedObjectForEntityName:(NSString *)entityName;

/**  Returns a fetchedResultsController for the fetchRequest with sectionNameKeyPath  */
- (NSFetchedResultsController *)fetchedResultsControllerForRequest:(NSFetchRequest *)fetchRequest withSectionNameKeyPath:(NSString *) sectionNameKeyPath;

/** 
 Returns an array for the fetchRequest 
 or error.  Error is logged.
 */
- (NSArray *)resultsForRequest:(NSFetchRequest *)fetchRequest;

/** 
 Returns a single instance when fetchRequest returns data, nil if no results 
 or error.  Error is passed through the aError out param 
 */
- (NSManagedObject *)singleResultForRequest:(NSFetchRequest *)fetchRequest error:(NSError **)aError;

/** 
 Returns a single instance when fetchRequest returns data, nil if no results 
 or error.  Error is logged.
 */
- (NSManagedObject *)singleResultForRequest:(NSFetchRequest *)fetchRequest;


- (void)handleFetchError:(NSError *)error forMethodNamed:(NSString *)methodName withMessage:(NSString *)message;

@end

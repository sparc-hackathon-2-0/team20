//
//  CoreDataManager+Helper.m
//  Apartments
//
//  Created by Alondo Brewington on 7/26/12.
//  Copyright (c) 2012 DT Squared Software, LLC. All rights reserved.
//

#import "CoreDataManager+Helper.h"

@implementation CoreDataManager (Helper)

#pragma mark - CoreData Helper Methods

//   Helper method to create a fetch request in the current context for the entity name given
- (NSFetchRequest *)fetchForEntityNamed:(NSString *)entityName
{
	NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
	NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName 
                                                  inManagedObjectContext:[self managedObjectContext]];
	[fetch setEntity:entityDesc];
	return fetch;
}

- (NSFetchRequest *)fetchForEntityNamed:(NSString *)entityName withPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *fetch = [self fetchForEntityNamed:entityName];
    [fetch setPredicate:predicate];
	return fetch;
}

- (NSArray *)executeFetch:(NSFetchRequest *)fetchRequest{
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
	if( error )
    {
        // is there a way to know who called this and pass that to the error handler?
		[self handleFetchError:error 
                forMethodNamed:@"executeFetch" 
                   withMessage:@"Failed to fetch"];
	}
    return results;
}

- (NSArray *)getAllForEntityNamed:(NSString *)entityName
{
    NSFetchRequest *fetch = [self fetchForEntityNamed:entityName];
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch error:&error];
	if( error ){
		[self handleFetchError:error 
                forMethodNamed:@"getAllForEntityNamed" 
                   withMessage:@"Failed to fetch"];
	}
    // return the results
    return results;
    
}

- (NSArray *)getAllForEntityNamed:(NSString *)entityName
                    withPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetch = [self fetchForEntityNamed:entityName];
    [fetch setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch 
                                                                  error:&error];
	if( error )
    {
		[self handleFetchError:error 
                forMethodNamed:@"getAllForEntityNamed" 
                   withMessage:@"Failed to fetch"];
	}
    // return the results
    return results;   
}


- (NSArray *)getAllForEntityNamed:(NSString *)entityName 
                    withPredicate:(NSPredicate *)predicate 
                   sortDescriptor:(NSString *)currentSortOrder
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:currentSortOrder 
                                                                   ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    NSFetchRequest *fetch = [self fetchForEntityNamed:entityName];
    [fetch setSortDescriptors:sortDescriptors];
    [fetch setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch 
                                                                  error:&error];
	if( error ){
		[self handleFetchError:error 
                forMethodNamed:@"getAllForEntityNamed" 
                   withMessage:@"Failed to fetch"];
	}
    
    // return the results
    return results;   
}


- (NSArray *)getAllForEntityNamed:(NSString *)entityName 
                    withPredicate:(NSPredicate *)predicate 
                   sortDescriptors:(NSArray *)sortDescriptors
{
    
    NSFetchRequest *fetch = [self fetchForEntityNamed:entityName];
    [fetch setSortDescriptors:sortDescriptors];
    [fetch setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch 
                                                                  error:&error];
	if( error ){
		[self handleFetchError:error 
                forMethodNamed:@"getAllForEntityNamed" 
                   withMessage:@"Failed to fetch"];
	}
    
    // return the results
    return results;   
}

- (NSManagedObject *)getEntityNamed:(NSString *)entityName 
                  withPropertyNamed:(NSString *)propName 
                      matchingValue:(id)value
{
    NSFetchRequest *fetch = [self fetchForEntityNamed:entityName];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", propName, value]];
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch error:nil];
    
    switch([results count])
    {
        case 0:
            return nil;
        case 1:
            return (NSManagedObject *)[results objectAtIndex:0];
        default:
            NSLog(@"There are more than one %@ records with the %@ = %@.  Returning the first one", entityName, propName, value );
            return (NSManagedObject *)[results objectAtIndex:0];
    }
}

- (NSManagedObject *)getEntityNamed:(NSString *)entityName 
                          withTitle:(NSString *)title
{
    NSFetchRequest *fetch = [self fetchForEntityNamed:entityName];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"title = %@", title]];
    
    NSArray *results = [[self managedObjectContext] executeFetchRequest:fetch error:nil];
    if( [results count] == 0 )
    {
        return nil;   
    }
    
    return (NSManagedObject *)[results objectAtIndex:0];
}

- (void) deleteAllObjects: (NSString *)entityName  
{
    NSFetchRequest *request = [self fetchForEntityNamed:entityName];
    
    NSError *error;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:request error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [[self managedObjectContext] deleteObject:managedObject];
        NSLog(@"%@ object deleted", entityName);
    }
    
}

- (void)deleteObject:(NSManagedObject *)managedObject{
    
    [[self managedObjectContext] deleteObject:managedObject];
}

- (NSUInteger)getCountForEntity:(NSString *)entityName 
                  withPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *request = [self fetchForEntityNamed:entityName];
    
    if (predicate != nil) 
    {
        [request setPredicate:predicate];   
    }    
    
    NSUInteger count =  [[self managedObjectContext] countForFetchRequest:request 
                                                                    error:nil];
    return count;
}

// returns all the NSManagedObjects found matching the given array of object IDs
- (NSArray *)getMatchesForEntityNamed:(NSString *)entityName 
                    withObjectIdArray:(NSArray *)objectIdArray
{
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    
	NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName 
                                                  inManagedObjectContext:[self managedObjectContext]];
	[fetch setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(self IN %@)", objectIdArray];
    [fetch setPredicate:predicate];
    
    return [self executeFetch:fetch];
}

/**                                     */

- (NSFetchedResultsController *)fetchedResultsControllerForRequest:(NSFetchRequest *)fetchRequest withSectionNameKeyPath:(NSString *) sectionNameKeyPath{
    NSFetchedResultsController *frc = 
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                        managedObjectContext:self.managedObjectContext 
                                          sectionNameKeyPath:sectionNameKeyPath 
                                                   cacheName:nil];
	
	return frc;
}

/**                                     */
- (NSArray *)resultsForRequest:(NSFetchRequest *)fetchRequest
{
	NSError *error = nil;
	NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	if (error) {
        // log the error.  This won't be as helpful here as up the stack so 
        // consider calling the other selector from the consuming code
        NSLog( @"[BaseRepository resultsForRequest] Failed to execute query expecting array result.  Error: %@", 
              [error userInfo] );
    }
	return results;
}

/**                                     */
- (NSManagedObject *)singleResultForRequest:(NSFetchRequest *)fetchRequest
{
    NSError *error = nil;
    NSManagedObject *result = [self singleResultForRequest:fetchRequest error:&error];
    if (error) {
        // log the error.  This won't be as helpful here as up the stack so 
        // consider calling the other selector from the consuming code
        NSLog( @"[BaseRepository singleResultForRequest] Failed to execute query expecting single result.  Error: %@", 
              [error userInfo] );
    }
    return result;
}

- (NSManagedObject *)singleResultForRequest:(NSFetchRequest *)fetchRequest error:(NSError **)aError
{
	NSError *error = nil;
	NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // check for error
    if( error || !results )
    {
		if(aError) {
			*aError = error;
		}
    }
    else
    {
        NSManagedObject *result = [results lastObject];
        return result;
    }
    
    return nil;
}


#pragma mark -
#pragma mark CoreData CRUD Methods

- (NSManagedObject *)insertManagedObjectForEntityName:(NSString *)entityName
{
    NSManagedObject *newInstance = (NSManagedObject *)[NSEntityDescription insertNewObjectForEntityForName:entityName 
                                                                                    inManagedObjectContext:[self managedObjectContext]];
    
	// configure the new managed object.
	return newInstance;
}

#pragma mark -
#pragma mark NSFetchedResultsController Properties

- (NSFetchedResultsController *)fetchedResultsControllerForEntityName:(NSString *)entity 
                                                        withPredicate:(NSPredicate *)predicate
{
    if(![NSThread isMainThread]) 
    {
        NSLog(@"Asked for fetchedResultsControllerForEntityName while NOT on the main thread");
    }
    
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [self fetchForEntityNamed:entity];
    
    // Edit the entity name as appropriate.
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entity 
                                                  inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDesc];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // set the filter predicate
    [fetchRequest setPredicate:predicate];
    
    // set sort
    //[fetchRequest setSortDescriptors:[self generateSongListSort]];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"title" 
                                                                                          ascending:YES 
                                                                                           selector:@selector(localizedCaseInsensitiveCompare:)]]];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                                                                                managedObjectContext:self.managedObjectContext 
                                                                                                  sectionNameKeyPath:@"title" // this key defines the sections
                                                                                                           cacheName:nil]; // setting cacheName to nil until we know how to update appropriately on data changes
    return aFetchedResultsController;
}


- (void)handleFetchError:(NSError *)error forMethodNamed:(NSString *)methodName withMessage:(NSString *)message{
    NSLog(@"%@ %@ with error:%@", methodName, message, [error userInfo]);

}

@end

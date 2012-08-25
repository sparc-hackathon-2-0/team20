//
//  GCAppDelegate.m
//  Construct
//
//  Created by Ryan Poolos on 8/25/12.
//  Copyright (c) 2012 Greenville Cocoaheads. All rights reserved.
//

#import "GCAppDelegate.h"
#import "CoreDataManager+Helper.h"

@interface GCAppDelegate (){
    BOOL isAppFirstLaunch;
}
@end

@implementation GCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self initializeApp];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -  Initialization

- (void)initializeApp{
    
    // Check for the initial run of the app
    isAppFirstLaunch = (BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsFirstRun];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Setup persistent data stores
    [self setupDataModels];
}

- (void)setupDataModels{
    
    // Create the config file on initial launch
    if (!isAppFirstLaunch){
        
        // Create Data Models
        [CoreDataManager managerWithName:COREDATA_CONSTRUCT
                            withFileName:COREDATA_CONSTRUCT_DBFILE
                           withExtension:COREDATA_DEFAULT_EXTENSION];
        
        [self createDataFile:COREDATA_CONSTRUCT_DBFILE fromDefault:COREDATA_CONSTRUCT_DEFAULT_DBFILE];
        
        // Setup Sample Data
        CoreDataManager *coreDataManager = [CoreDataManager namedManagerWithName:COREDATA_CONSTRUCT];
        Goal *firstGoal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                      inManagedObjectContext:[coreDataManager managedObjectContext]];
        
        [firstGoal setGoalName:@"My first goal"];
        [coreDataManager saveContext];
    }
    
    
}

- (void)createDataFile:(NSString *)dataFile fromDefault:(NSString *)defaultDataFile
{
    //First, test for existence - we don't want to wipe out a user's DB
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [[self applicationDocumentsDirectory] path];
    
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:dataFile];
    
    BOOL dbexists = [fileManager fileExistsAtPath: writableDBPath];
    
    if (!dbexists)
    {
        // The writable database does not exist, so copy the default to the appropriate location
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:defaultDataFile];
        
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        
        if (!success) {
            //NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            // create new database is one doesn't exist
        }
        
    }else {
        // Default file doesn't exist, create new file
        
    }
}

@end

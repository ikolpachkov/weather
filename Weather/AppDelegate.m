//
//  AppDelegate.m
//  Weather
//
//  Created by Igor Kolpachkov on 18.10.15.
//  Copyright (c) 2015 com.ikolpachkov. All rights reserved.
//

#import "AppDelegate.h"
#import "WeatherViewController.h"

#import <MagicalRecord/MagicalRecord.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    WeatherViewController *weatherVC = [[WeatherViewController alloc] init];
    UINavigationController *rootVC = [[UINavigationController alloc] initWithRootViewController:weatherVC];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

#pragma mark - Core Data stack

#define CODE_DATA_MODEL_FILE_NAME "Weather"

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Core Data
- (void)setupDB
{
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
    _managedObjectContext = [NSManagedObjectContext MR_defaultContext];
}


- (void)saveContext
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error)
     {
         if (success)
             NSLog(@"You successfully saved your context.");
         else if (error)
             NSLog(@"Error saving context: %@", error.description);
     }];
}

- (NSString *)dbStore
{
    NSString *bundleID = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    return [NSString stringWithFormat:@"%@.sqlite", bundleID];
}

- (void)cleanAndResetupDB
{
    NSString *dbStore = [self dbStore];
    NSError *error = nil;
    NSURL *storeURL = [NSPersistentStore MR_urlForStoreName:dbStore];
    [MagicalRecord cleanUp];
    
    if (![[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error])
    {
        NSLog(@"An error has occurred while deleting %@", dbStore);
        NSLog(@"Error description: %@", error.description);
    }
    [self setupDB];
}

@end

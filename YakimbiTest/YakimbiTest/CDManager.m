/**
 
 @application   
 @developers    [Roman Jakov] 
 @copyright     
 
 */

#import "CDManager.h"

#define CDBASENAME @"YakimbiTest.xcdatamodeld"
#define DEFAULT_ERROR_MESSAGE @"Error in createPredicate function"

@implementation CDManager

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (CDManager *) sharedInstance
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    static dispatch_once_t predicate = 0;
	static CDManager *object = nil; 
	dispatch_once(&predicate, ^{ object = [self new]; });
	return object; 
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) getManagedObjectContext 
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    if (self.managedObjectContext != nil) 
    {
        return self.managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self getPersistentStoreCoordinator];
    if (coordinator != nil) 
    {
        self.managedObjectContext = [[NSManagedObjectContext alloc] init];
        [self.managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return self.managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *) getManagedObjectModel 
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    if (self.managedObjectModel != nil) 
    {
        return self.managedObjectModel;
    }
    //self.managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"YakimbiTest" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
    return self.managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)getPersistentStoreCoordinator 
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    if (self.persistentStoreCoordinator != nil) 
    {
        return self.persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: CDBASENAME]];
	
	NSError *error = nil;
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self getManagedObjectModel]];
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) 
    {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return self.persistentStoreCoordinator;
}

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory 
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSArray*)requestCreating: (NSString*)entityPredicate andEntityName:(NSString *)entityName 
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self getManagedObjectContext]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:entityPredicate];
    [request setPredicate:predicate];    
    NSError* error = nil;
    NSArray *results = [[self getManagedObjectContext] executeFetchRequest:request error:&error];
    if (error) 
    {
        NSLog(@"%@ - description: %@", DEFAULT_ERROR_MESSAGE, error);
        return nil;
    } 
    return results;
}

- (NSArray*)requestSortingBy:(NSString*)sortField andEntityName:(NSString *)entityName forLimit:(NSInteger)limit andOffset:(NSInteger)offset;   
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self getManagedObjectContext]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:sortField     
                                        ascending:NO];
    
    NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [request setSortDescriptors:descriptors];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:nil];
    [request setPredicate:predicate];
    request.fetchLimit = limit;
    request.fetchOffset = offset;
    NSError* error = nil;
    NSArray *results = [[self getManagedObjectContext] executeFetchRequest:request error:&error];
    if (error) 
    {
        NSLog(@"%@ - description: %@", DEFAULT_ERROR_MESSAGE, error);
        return nil;
    } 
    return results;
}


@end

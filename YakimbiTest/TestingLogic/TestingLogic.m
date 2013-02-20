#import "TestingLogic.h"
#import "ServerApi.h"
#import "CDManager.h"
#import "TestServerApiDelegate.h"

@implementation TestingLogic

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
        
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];    
    STAssertNotNil(bundle, @"Error finding bundle to create Core Data stack.");
    
    NSString *path = [bundle pathForResource:@"YakimbiTest" ofType:@"momd"];
    STAssertNotNil(path, @"The path to the resource cannot be nil.");
    
    NSURL *modelURL = [NSURL URLWithString:path];
    STAssertNotNil(modelURL, @"The URL to the resource cannot be nil. (tried to use path:%@, modelURL is %@)", path, modelURL);

   [CDManager sharedInstance].managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];       
	
	NSError *error = nil;
   [CDManager sharedInstance].persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[CDManager sharedInstance].managedObjectModel];
      
 
    if (![ [CDManager sharedInstance].persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error]) 
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
    
   _apiDlg = [[TestServerApiDelegate alloc] init];
    
    [[ServerApi sharedInstance] setDelegate:_apiDlg];
    [[ServerApi sharedInstance] getDataRequest:NO];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    
    STAssertNotNil([ServerApi sharedInstance], @"Not correct initialization of ServerApi", nil);
    STAssertFalse(_apiDlg.failedToLoadData, @"Failed to load data", nil);    
   
    NSArray* tmpArray = [[CDManager sharedInstance] requestCreating:nil andEntityName:@"FileCD"];
    
    STAssertEquals([tmpArray count], (NSUInteger)_apiDlg.pageCount, @"Problem with properly data storing", nil);
}


@end

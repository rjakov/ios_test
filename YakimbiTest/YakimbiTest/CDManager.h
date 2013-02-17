/**
 
 @application   
 @developers    [Roman Jakov] 
 @copyright     
 
 */

#import <CoreData/CoreData.h>

@interface CDManager : NSObject
{
    NSManagedObjectModel *_managedObjectModel;
    NSManagedObjectContext *_managedObjectContext;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CDManager *) sharedInstance;
- (NSManagedObjectContext *) getManagedObjectContext;
- (NSManagedObjectModel *) getManagedObjectModel;
- (NSPersistentStoreCoordinator *) getPersistentStoreCoordinator; 
- (NSString *) applicationDocumentsDirectory; 
- (NSArray*)requestCreating: (NSString*)entityPredicate andEntityName:(NSString *)entityName;
- (NSArray*)requestSortingBy:(NSString*)sortField andEntityName:(NSString *)entityName forLimit:(NSInteger)limit andOffset:(NSInteger)offset;  


@end

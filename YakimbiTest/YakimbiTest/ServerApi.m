/**
 
 @application   
 @developers    [Roman Jakov] 
 @copyright     
 
 */

#import "ServerApi.h"
#import "CDManager.h"
#import "MyFilesCD.h"
#import "FileCD.h"
#import "ServiceInfoCD.h"


@implementation ServerApi

static ServerApi *sharedSampleSingletonDelegate = nil;

@synthesize delegate = _delegate;

- (void) dealloc 
{       
    [super dealloc];
}

- (id) init 
{
    self = [super init];
    if (self != nil) {
    }
    return self;
}

#pragma mark SINGLETONE
//--------------------------------------------[
+ (ServerApi*)sharedInstance 
{
    @synchronized(self) {
        if (sharedSampleSingletonDelegate == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedSampleSingletonDelegate;
}

+ (id)allocWithZone:(NSZone *)zone 
{
    @synchronized(self) {
        if (sharedSampleSingletonDelegate == nil) {
            sharedSampleSingletonDelegate = [super allocWithZone:zone];
            // assignment and return on first allocation
            return sharedSampleSingletonDelegate;
        }
    }
    // on subsequent allocation attempts return nil
    return nil;
}

- (id)copyWithZone:(NSZone *)zone 
{
    return self;
}

- (id)retain 
{
    return self;
}

- (unsigned)retainCount 
{
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release 
{
    //do nothing
}

- (id)autorelease 
{
    return self;
}
//--------------------------------------------[
- (void) getDataRequest {
    
    dispatch_async(mBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:mJsonDataURL];        
        [self performSelectorOnMainThread:@selector(getDataOK:) 
                               withObject:data waitUntilDone:YES];
    });
    
}

- (void) getDataOK: (NSData*) data {
    
    //parse out the json data
    NSError* error = nil;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data                          
                          options:kNilOptions 
                          error:&error];

    [self processJson:json];  
    [self.delegate gotDataOK:nil];
}



- (void)processJson:(NSDictionary*)json {
    
    NSNumber* last_rev_id = [json objectForKey:@"last_rev_id"];    
    NSDictionary* my_files = [json objectForKey:@"my_files"];
    NSArray* my_files_content = [my_files objectForKey:@"content"];
     
    NSLog(@"last_rev_id: %@", last_rev_id);
    NSLog(@"my_files: %@", my_files);   
    
    ServiceInfoCD* sInfo = [[[CDManager sharedInstance] requestCreating:nil andEntityName:@"ServiceInfoCD"] lastObject];
    
    if ([sInfo.last_rev_id intValue] == [last_rev_id intValue]) {
        
        return;
    }
    
    
    NSManagedObjectContext *context = [[CDManager sharedInstance] getManagedObjectContext];
    NSError* error;
    
    NSManagedObject* serviceInfoCDEntDescr = [NSEntityDescription insertNewObjectForEntityForName:@"ServiceInfoCD" inManagedObjectContext:context];    
    [serviceInfoCDEntDescr setValue:[json objectForKey:@"totalSpace"] forKey:@"totalSpace"];
    [serviceInfoCDEntDescr setValue:[json objectForKey:@"last_rev_id"] forKey:@"last_rev_id"];
    [serviceInfoCDEntDescr setValue:[json objectForKey:@"usedSpace"] forKey:@"usedSpace"];
    [serviceInfoCDEntDescr setValue:[json objectForKey:@"availableSpace"] forKey:@"availableSpace"];
    [serviceInfoCDEntDescr setValue:[json objectForKey:@"mode"] forKey:@"mode"];    
    [serviceInfoCDEntDescr setValue:[json objectForKey:@"pendingRequests"] forKey:@"pendingRequests"];
    if (![context save:&error]) {
        NSLog(@"Problem while CD saving %@", [error localizedDescription]);
    }
    
    NSManagedObject* myFilesCDEntDescr = [NSEntityDescription insertNewObjectForEntityForName:@"MyFilesCD" inManagedObjectContext:context]; 
    NSLog(@"my_files_name %@", [my_files objectForKey:@"name"]);
    NSLog(@"my_files_id %@", [my_files objectForKey:@"id"]);    
    [myFilesCDEntDescr setValue:[my_files objectForKey:@"name"] forKey:@"name"];
    [myFilesCDEntDescr setValue:[my_files objectForKey:@"id"] forKey:@"id"];    
    for (NSDictionary* file in my_files_content) {
               
        NSManagedObject* fileCDEntDescr = [NSEntityDescription insertNewObjectForEntityForName:@"FileCD" inManagedObjectContext:context];
        NSDictionary *attributes = [[fileCDEntDescr entity] attributesByName];
        for (NSString *attribute in attributes) {
            id value = [file objectForKey:attribute];
            if (value == nil || [value isKindOfClass:[NSNull class]]) {
                continue;
            }            
            //NSLog(@"attribute: %@, value: %@, value class: %@ \n", attribute, value, [value class]);            
            [fileCDEntDescr setValue:value forKey:attribute];
        }       
         
        [(MyFilesCD*) myFilesCDEntDescr addFilesObject:fileCDEntDescr];
        [(FileCD*)fileCDEntDescr  setMyfiles:myFilesCDEntDescr];
        
    }
    
    if (![context save:&error]) {
        NSLog(@"Problem while CD saving %@", [error localizedDescription]);
    }    

}


@end

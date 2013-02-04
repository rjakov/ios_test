/**
 
 @application   
 @developers    [Roman Jakov] 
 @copyright     
 
 */

#import <UIKit/UIKit.h>
#import "ServerApi.h"

@interface RootTableController: UITableViewController <ServerApiDelegate> {
    
    NSArray* _filesArray;
}

@property (nonatomic, retain) NSArray* filesArray;

- (void) gotDataOK:(NSDictionary*) data;

@end

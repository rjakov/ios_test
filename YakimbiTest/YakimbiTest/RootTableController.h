/**
 
 @application   
 @developers    [Roman Jakov] 
 @copyright     
 
 */

#import <UIKit/UIKit.h>
#import "ServerApi.h"

@interface RootTableController: UITableViewController <ServerApiDelegate> {
    
    NSMutableArray* _filesArray;
    int _currentPage;
    int _pageCount;
}

@property (nonatomic, retain) NSMutableArray* filesArray;

- (void) gotDataOK:(NSDictionary*) data;
- (void) loadNextPage;

@end

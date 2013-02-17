/**
 
 @application   
 @developers    [Roman Jakov] 
 @copyright     
 
 */

#import <UIKit/UIKit.h>
#import "FileCD.h"

@interface DetailsViewController : UITableViewController {
    
    FileCD* _file;
    int detailsRowCount;
}

@property (nonatomic, strong) FileCD* file;


@end

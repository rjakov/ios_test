#import <Foundation/Foundation.h>



@interface TestServerApiDelegate : NSObject {
    

    BOOL _failedToLoadData;
    int _pageCount;
    
}

@property BOOL failedToLoadData;
@property int pageCount;

@end

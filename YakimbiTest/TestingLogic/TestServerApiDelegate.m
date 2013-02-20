#import "TestServerApiDelegate.h"

@implementation TestServerApiDelegate

@synthesize failedToLoadData = _failedToLoadData;
@synthesize pageCount = _pageCount;


- (void) gotDataOK:(NSDictionary*) data {
    
    NSLog(@"gotDataOK:");
    _failedToLoadData = NO;
    
    _pageCount = [[[data objectForKey:@"my_files"] objectForKey:@"content"] count];
    
    
}

- (void) gotDataFailed:(NSError*) error {
    
    _failedToLoadData = YES;
}

@end

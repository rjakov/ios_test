/**
 
 @application   
 @developers    [Roman Jakov] 
 @copyright     
 
 */

#import <Foundation/Foundation.h>

#define mBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define mJsonDataURL [NSURL URLWithString:@"https://gist.github.com/raw/4680060/aac6d818e7103edfe721e719b1512f707bcfb478/sample.json"]




/**
 create the delegates for the singletone in order to centralize all
 the calls in<>out in a clean way
 */
@class ServerApi;

@protocol ServerApiDelegate
@optional

//Got data handlers
- (void) gotDataOK:(NSDictionary*) data;
- (void) gotDataFailed:(NSError*) error;

@end

@interface ServerApi : NSObject {
    id <ServerApiDelegate> __unsafe_unretained _delegate;
}
@property (nonatomic, unsafe_unretained) id <ServerApiDelegate> delegate;

+ (ServerApi*)sharedInstance;

#pragma mark
- (void) getDataRequest;
- (void) getDataOK: (NSData*) data;
- (void) getDataFailed: (NSDictionary*) request;
- (void) processJson:(NSDictionary*)json;

@end

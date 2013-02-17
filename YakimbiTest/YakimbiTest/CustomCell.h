

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, strong) UILabel *mainTextLabel;
@property (nonatomic, strong) UILabel *subTextLabel;

- (void) addMainLabel;
- (void) addSubLabel;
- (void) setupBackground;

@end


#import <UIKit/UIKit.h>

@interface todoTableViewCell : UITableViewCell

@property (assign, nonatomic) IBOutlet UILabel *todoTextLabel;
@property (retain, nonatomic) IBOutlet UILabel *strikeFontLabel;
@property (retain, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic,retain)  NSNumber *record_Id;
@property (nonatomic) BOOL isComplete;

-(void)setTaskComplete:(BOOL)complete;
@end

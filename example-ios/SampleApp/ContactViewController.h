#ifndef example_ios_ContactViewController_h
#define example_ios_ContactViewController_h

#import <UIKit/UIKit.h>
#import "ContactRecord.h"

@interface ContactViewController : UIViewController

@property(weak, nonatomic) IBOutlet UIScrollView* contactDetailScrollView;

// the contact being looked at
@property(nonatomic, retain) ContactRecord* contactRecord;

@property(nonatomic) BOOL didPrecall;

- (void) canclePrefetch;

- (void) prefetch;

- (void) waitToReady;
@end
#endif

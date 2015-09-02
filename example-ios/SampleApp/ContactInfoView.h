#ifndef example_ios_ContactInfoView_h
#define example_ios_ContactInfoView_h

#import <UIKit/UIKit.h>
#include "ContactDetailRecord.h"

// subview of contact view
// displays a contactinfo table record
@interface ContactInfoView : UIView

@property(nonatomic, retain) ContactDetailRecord* record;

- (void) updateFields;
- (void) updateRecord;
- (NSDictionary*) buildToDictionary;

@end
#endif

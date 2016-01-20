#ifndef example_ios_ContactInfoView_h
#define example_ios_ContactInfoView_h

#import <UIKit/UIKit.h>
#include "ContactDetailRecord.h"

@class ContactInfoView;

@protocol ContactInfoDelegate <NSObject>

- (void)onContactTypeClick:(ContactInfoView *)view withTypes:(NSArray *)types;

@end

// subview of contact view
// displays a contactinfo table record
@interface ContactInfoView : UIView

@property(nonatomic, retain) ContactDetailRecord* record;
@property (nonatomic, weak) id<ContactInfoDelegate> delegate;
@property (nonatomic, copy) NSString *contactType;

- (void)setTextFieldsDelegate:(id<UITextFieldDelegate>) delegate;
- (void) updateFields;
- (void) updateRecord;
- (NSDictionary*) buildToDictionary;
- (void)validateInfoWithResult:(void (^)(BOOL valid, NSString *message))result;

@end
#endif

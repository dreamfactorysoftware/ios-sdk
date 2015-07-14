#ifndef example_ios_CustomNavBar_h
#define example_ios_CustomNavBar_h

#import <UIKit/UIKit.h>

@interface CustomNavBar : UIToolbar

// custom navigation bar so that we can persistently store the dreamfactory
// logo on the header bar

@property(retain, nonatomic) UIButton* backButton;
@property(retain, nonatomic) UIButton* addButton;
@property(retain, nonatomic) UIButton* editButton;
@property(retain, nonatomic) UIButton* doneButton;

- (void) buildLogo;
- (void) buildButtons;

// make pretty transitions
- (void) showEditAndAdd;
- (void) showAdd;
- (void) showEdit;
- (void) showDone;

- (void) showEditButton:(BOOL)show;
- (void) showAddButton:(BOOL)show;
- (void) showBackButton:(BOOL)show;
- (void) showDoneButton:(BOOL)show;

// to prevend silly things with people spamming buttons
- (void) disableAllTouch;
- (void) enableAllTouch;

@end

#endif

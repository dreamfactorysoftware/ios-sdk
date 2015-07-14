#ifndef example_ios_ContactEditViewController_h
#define example_ios_ContactEditViewController_h

#import <UIKit/UIKit.h>
#import "ContactRecord.h"
#import "ProfileImagePickerViewController.h"
#import "ContactViewController.h"


@interface ContactEditViewController : UIViewController <ProfileImagePickerViewControllerDelegate>

@property(weak, nonatomic) ContactViewController* contactViewController;

@property(weak, nonatomic) IBOutlet UIScrollView* contactEditScrollView;

// contact being looked at
@property(nonatomic, retain) ContactRecord* contactRecord;

// set when editing an existing contact
// list of contactinfo records
@property(nonatomic, retain) NSMutableArray* contactDetails;

// set when creating a new contact
// id of the group the contact is being created in
@property(nonatomic, retain) NSNumber* contactGroupId;

@end
#endif

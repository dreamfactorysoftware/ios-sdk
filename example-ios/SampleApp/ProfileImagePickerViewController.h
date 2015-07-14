#ifndef example_ios_ProfileImagePickerViewController_h
#define example_ios_ProfileImagePickerViewController_h

#import <UIKit/UIKit.h>
#import "ContactRecord.h"

@class ProfileImagePickerViewController;

@protocol ProfileImagePickerViewControllerDelegate <NSObject>
// for sending info back up to the contact-edit controller
- (void)addItemViewController:(ProfileImagePickerViewController *)controller didFinishEnteringItem:(NSString *)item;

- (void) addItemWithoutContactViewController:(ProfileImagePickerViewController *)controller didFinishEnteringItem:(NSString *)item didChooseImageFromPicker:(UIImage*) image;
@end

@interface ProfileImagePickerViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (retain, nonatomic) IBOutlet UITableView *imageListTableView;

@property (retain, nonatomic) IBOutlet UITextField *imageNameTextField;

// set only when editing an existing contact
// the contact we are choosing a profile image for
@property (retain, nonatomic) ContactRecord* record;


@property (nonatomic, weak) id <ProfileImagePickerViewControllerDelegate> delegate;

@end

#endif

//
//  PickerSelector.h
//  SampleApp
//
//  Created by Timur Umayev on 1/14/16.
//  Copyright © 2016 dreamfactory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerSelector;

@protocol PickerSelectorDelegate <NSObject>

@optional

-(void) pickerSelector:(PickerSelector *)selector selectedValue:(NSString *)value index:(NSInteger)idx;

@end

@interface PickerSelector : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIViewController *parent_;
    CGPoint origin_;
}

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIToolbar *optionsToolBar;

@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) NSArray *pickerData;
@property (nonatomic, weak) id<PickerSelectorDelegate> delegate;
@property (nonatomic, assign) int numberOfComponents;

+ (instancetype) picker;
- (void) showPickerOver:(UIViewController *)parent;

@end

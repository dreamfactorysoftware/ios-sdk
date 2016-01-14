//
//  PickerSelector.m
//  SampleApp
//
//  Created by Timur Umayev on 1/14/16.
//  Copyright © 2016 dreamfactory. All rights reserved.
//

#import "PickerSelector.h"

@interface PickerSelector()

@end

@implementation PickerSelector

+ (instancetype) picker {
    return [PickerSelector pickerWithNibName:@"PickerSelector"];
}

+ (instancetype) pickerWithNibName:(NSString*)nibName {
    PickerSelector *instance = [[self alloc] initWithNibName:nibName bundle:[NSBundle bundleForClass:[PickerSelector class]]];
    instance.pickerData = [NSMutableArray arrayWithCapacity:0];
    instance.numberOfComponents = 1;
    
    return instance;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect frame = self.view.frame;
        
        [self.view addSubview:self.pickerView];
        
        frame = self.pickerView.frame;
        frame.origin.y = CGRectGetMaxY(self.optionsToolBar.frame);
        self.pickerView.frame = frame;
    }
    return self;
}

- (void) showPickerOver:(UIViewController *)parent
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    self.background = [[UIView alloc] initWithFrame:window.bounds];
    [self.background setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.0]];
    [window addSubview:self.background];
    [window addSubview:self.view];
    [parent addChildViewController:self];
    
    __block CGRect frame = self.view.frame;
    float rotateAngle = 0;
    CGSize screenSize = CGSizeMake(window.frame.size.width, [self pickerSize].height);
    origin_ = CGPointMake(0,CGRectGetMaxY(window.bounds));
    CGPoint target = CGPointMake(0,origin_.y - CGRectGetHeight(frame));
    
    self.view.transform = CGAffineTransformMakeRotation(rotateAngle);
    frame = self.view.frame;
    frame.size = screenSize;
    frame.origin = origin_;
    self.view.frame = frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.background.backgroundColor = [self.background.backgroundColor colorWithAlphaComponent:0.5];
        frame = self.view.frame;
        frame.origin = target;
        self.view.frame = frame;
    }];
    
    [self.pickerView reloadAllComponents];
}

-(CGSize) pickerSize
{
    CGSize size = self.view.frame.size;
    size.height = CGRectGetHeight(self.optionsToolBar.frame) + CGRectGetHeight(self.pickerView.frame);
    size.width = CGRectGetWidth(self.pickerView.frame);
    return size;
}

- (IBAction)setAction:(id)sender
{
    if (self.delegate && self.pickerData.count > 0) {
        NSMutableString *str = [NSMutableString stringWithString:@""];
        for (int i = 0; i < self.numberOfComponents; i++) {
            if (self.numberOfComponents == 1) {
                [str appendString:self.pickerData[[self.pickerView selectedRowInComponent:0]]];
            }else{
                NSMutableArray *componentData = self.pickerData[i];
                [str appendString:componentData[[self.pickerView selectedRowInComponent:i]]];
                if (i<self.numberOfComponents-1) {
                    [str appendString:@" "];
                }
            }
        }
        
        
        if ([self.delegate respondsToSelector:@selector(pickerSelector:selectedValue:index:)]) {
            [self.delegate pickerSelector:self selectedValue:str index:[self.pickerView selectedRowInComponent:0]];
        }
        
    }
    
    [self dismissPicker];
}

- (IBAction)cancelAction:(id)sender
{
    [self dismissPicker];
}

- (void) dismissPicker
{
    [UIView animateWithDuration:0.3 animations:^{
        self.background.backgroundColor = [self.background.backgroundColor colorWithAlphaComponent:0];
        CGRect frame = self.view.frame;
        frame.origin = origin_;
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        [self.background removeFromSuperview];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

#pragma mark - picker delegate and datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.numberOfComponents > 1) {
        NSMutableArray *comp = self.pickerData[component];
        return comp.count;
    }
    return self.pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.numberOfComponents > 1) {
        NSMutableArray *comp = self.pickerData[component];
        return comp[row];
    }
    return self.pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.delegate && self.pickerData.count > 0) {
        NSMutableString *str = [NSMutableString stringWithString:@""];
        for (int i = 0; i < self.numberOfComponents; i++) {
            if (self.numberOfComponents == 1) {
                [str appendString:self.pickerData[[self.pickerView selectedRowInComponent:0]]];
            } else {
                NSMutableArray *componentData = self.pickerData[i];
                [str appendString:componentData[[self.pickerView selectedRowInComponent:i]]];
                if (i<self.numberOfComponents-1) {
                    [str appendString:@" "];
                }
            }
        }
    }
}

@end

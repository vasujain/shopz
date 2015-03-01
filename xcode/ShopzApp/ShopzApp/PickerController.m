//
//  FLPickerController.m
//  Autolayout
//
//  Created by Francisco Magdaleno on 6/1/14.
//  Copyright (c) 2014 pako. All rights reserved.
//

#import "PickerController.h"
#import "UIView+LayoutConstraints.h"
#import "ImageCapturing.h"
@interface PickerController ()<UIPickerViewDataSource,UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *pickerContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *pickerBackgroundImage;
@property (weak, nonatomic) IBOutlet UIView *dismissTouchView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomContainerToBottomView;
@property (strong, nonatomic) NSLayoutConstraint *bottomContainerToTopOfView;
@property (nonatomic,strong) NSDictionary *selectedValue;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundBlurView;

@end

@implementation PickerController


+(PickerController *)createPickerControllerWithDelegate:(id<PickerControllerDelegate>)delegate {
    PickerController *controller = [[PickerController alloc]initWithNibName:NSStringFromClass([PickerController class])
                                                                     bundle:nil];
    [controller setDelegate:delegate];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.doneButton.tintColor = self.view.superview.tintColor;
    //configure the background view that will show the blurred image
    self.backgroundBlurView.alpha = 0;
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    //make the controller disappear when tapped on the background image
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(cancelPressed:)];
    [self.dismissTouchView addGestureRecognizer:recognizer];
    _bottomContainerToTopOfView = [[self.pickerContainerView positionBelowOtherView:self.view
                                                                        withPadding:0]lastObject];
    [self.view removeConstraint:_bottomContainerToBottomView];
    [self.view addConstraint:_bottomContainerToTopOfView];
    [self.view layoutIfNeeded];
}

-(void)setFullData:(NSArray *)fullData {
    if (_fullData != fullData) {
        _fullData = fullData;
        _fullData = fullData;
        [self.picker reloadAllComponents];
    }
}

- (IBAction)donePressed:(UIBarButtonItem *)sender {
    [self hidePicker:^{
        [self.delegate pickerController:self
                         didSelectValue:_selectedValue];
    }];
}

- (IBAction)cancelPressed:(UIBarButtonItem *)sender {
    [self hidePicker:^{
        [self.delegate pickerControllerDidCancel:self];
    }];
}

#pragma mark showing and dismissing
-(void)showPickerInView:(UIView *)masterView withInfo:(NSArray *)informationToDisplay layoutGuide:(id)guide {
    self.fullData = informationToDisplay;
    //add completeView to masterview
    [masterView addSubview:self.view];
    [masterView addConstraints:[self.view positionAlignLeadingEdgeOfSuperView]];
    [masterView addConstraints:[self.view positionAlignTrailingEdgeOfSuperView]];
    [masterView addConstraints:[self.view positionAlignTopEdgeOfSuperView]];
    if (guide)
        [masterView addConstraints:[self.view positionAlignBottomGuide:guide]];
    else
        [masterView addConstraints:[self.view positionAlignBottomEdgeOfSuperView]];
    
    
    [self.view layoutIfNeeded];
    [self.view removeConstraint:_bottomContainerToTopOfView];
    [self.view addConstraint:_bottomContainerToBottomView];

    //add the blur image behind the picker
    UIImage *blurImage = [ImageCapturing captureBlurImageForView:masterView
                                                           inFrame:self.view.frame];
    [self.backgroundBlurView setImage:blurImage];
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:0
                     animations:^{
                         self.backgroundBlurView.alpha = 1;
                         [self.view layoutIfNeeded];
                         NSInteger selectedRow = [self.picker selectedRowInComponent:0];
                         self.selectedValue = [_fullData objectAtIndex:selectedRow];
                         
                     } completion:nil];
}


-(void)hidePicker:(void (^)(void))completion {
    [self.view removeConstraint:_bottomContainerToBottomView];
    [self.view addConstraint:_bottomContainerToTopOfView];

    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        self.backgroundBlurView.alpha = 0;
    }completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}

#pragma mark picker datasource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _fullData.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[_fullData objectAtIndex:row] objectForKey:PICKER_VALUE_KEY];
}

#pragma mark picker delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedValue = [_fullData objectAtIndex:row];
}

-(void)selectFirstValue {
    [self pickerView:self.picker didSelectRow:0 inComponent:0];
}

@end

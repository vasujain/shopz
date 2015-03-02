//
//  ViewController.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/27/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "HomeVC.h"
//classes
#import "CustomButtons.h"
#import "UIView+LayoutConstraints.h"
#import "PickerController.h"
#import "AuthenticationHelper.h"
//controllers
#import "AppDelegate.h"
#import "BrowseVC.h"

@interface HomeVC () <PickerControllerDelegate,AuthenticationHelperDelegate>
///Label with the title question
//@property (nonatomic,strong) UILabel *questionLabel;
@property (nonatomic,strong) UITextField *questionLabel;
/////Free text textfield. Non editable.
//@property (nonatomic,strong) UITextField *searchTextField;
///Triggers the choose categories button.
@property (nonatomic,strong) UIButton *chooseCategoryButton;
///Triggers the search.
@property (nonatomic,strong) UIButton *submitSearchButton;
///Picker controller for the categories.
@property (nonatomic,strong) PickerController *pickerController;
@property (nonatomic,strong) NSDictionary *selectedInfo;

@end

@implementation HomeVC


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationItem.title = @"Home";
    self.navigationItem.leftBarButtonItem = [CustomButtons textButtonWithText:@"Logout"
                                                                forController:self
                                                                     selector:@selector(logoutPressed)];
    //start craeting ui
    [self createUIElements];
    [[AuthenticationHelper sharedInstance] setDelegate:self];
}

#pragma mark create ui methods
-(UITextField *)questionLabel {
    /*
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc]init];
        _questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _questionLabel.textAlignment = NSTextAlignmentCenter;
        _questionLabel.numberOfLines = 0;
        [_questionLabel setFont:[UIFont fontWithName:FONT_REGULAR size:20]];
        [_questionLabel setTextColor:[UIColor grayColor]];
        [_questionLabel setText:@"What are you looking for today?"];
    }
    return _questionLabel;
    */
    if (!_questionLabel) {
        _questionLabel = [[UITextField alloc]init];
        _questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_questionLabel setBorderStyle:UITextBorderStyleRoundedRect];
        [_questionLabel setFont:[UIFont fontWithName:FONT_REGULAR size:18]];
        [_questionLabel setTextColor:[UIColor darkGrayColor]];
        [_questionLabel setPlaceholder:@"Enter search query"];
        [_questionLabel setTextAlignment:NSTextAlignmentCenter];
        [_questionLabel positionHeight:40];
    }
    return _questionLabel;

}

-(UIButton *)chooseCategoryButton {
    if (!_chooseCategoryButton) {
        _chooseCategoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseCategoryButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_chooseCategoryButton setBackgroundColor:[UIColor clearColor]];
        [_chooseCategoryButton setTitleColor:BLUE_TINT_COLOR forState:UIControlStateNormal];
        [_chooseCategoryButton addTarget:self
                                  action:@selector(chooseCategoryButtonPressed)
                        forControlEvents:UIControlEventTouchUpInside];
        [_chooseCategoryButton.titleLabel setFont:[UIFont fontWithName:FONT_REGULAR size:18]];
        [_chooseCategoryButton setTitle:@"Choose Store" forState:UIControlStateNormal];
        _chooseCategoryButton.layer.cornerRadius = 3.0f;
        _chooseCategoryButton.clipsToBounds = YES;
        [_chooseCategoryButton.layer setBorderColor:[BLUE_TINT_COLOR CGColor]];
        [_chooseCategoryButton.layer setBorderWidth:0.8];
    }
    return _chooseCategoryButton;
}

//-(UITextField *)searchTextField {
//    if (!_searchTextField) {
//        _searchTextField = [[UITextField alloc]init];
//        _searchTextField.translatesAutoresizingMaskIntoConstraints = NO;
//        [_searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
//        [_searchTextField setFont:[UIFont fontWithName:FONT_REGULAR size:18]];
//        [_searchTextField setTextColor:[UIColor darkGrayColor]];
//        [_searchTextField setPlaceholder:@"Select a category"];
//        [_searchTextField setTextAlignment:NSTextAlignmentCenter];
//        [_searchTextField positionHeight:40];
//    }
//    return _searchTextField;
//}

-(UIButton *)submitSearchButton {
    if (!_submitSearchButton) {
        _submitSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitSearchButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_submitSearchButton setBackgroundColor:BLUE_TINT_COLOR];
        [_submitSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitSearchButton addTarget:self
                                  action:@selector(submitSearchPressed)
                        forControlEvents:UIControlEventTouchUpInside];
        [_submitSearchButton.titleLabel setFont:[UIFont fontWithName:FONT_REGULAR size:18]];
        [_submitSearchButton setTitle:@"Search" forState:UIControlStateNormal];
        _submitSearchButton.layer.cornerRadius = 3.0f;
        _submitSearchButton.clipsToBounds = YES;
        [self disableSubmitButton];
    }
    return _submitSearchButton;
}

-(void)disableSubmitButton {
    self.submitSearchButton.enabled = NO;
    self.submitSearchButton.alpha = 0.5;
}

-(void)enableSubmitButton {
    self.submitSearchButton.enabled = YES;
    self.submitSearchButton.alpha = 1;
}

-(void)createUIElements {
    //add the top question label first
    
    [self.view addSubview:self.questionLabel];
    [self.view addConstraints:[self.questionLabel positionAlignTopEdgeOfSuperViewWithPadding:20]];
    [self.view addConstraints:[self.questionLabel positionAlignLeadingEdgeOfSuperViewWithPadding:20]];
    [self.view addConstraints:[self.questionLabel positionAlignTrailingEdgeOfSuperViewWithPadding:20]];
    //add the textfield below the question label
    /*
    [self.view addSubview:self.searchTextField];
    [self.view addConstraints:[self. searchTextField positionBelowOtherView:self.questionLabel withPadding:20]];
    [self.view addConstraints:[self.searchTextField positionAlignTrailingEdgeOfSuperViewWithPadding:20]];
     */
    //add the button, align it y to the textfield and the trailing edge of the superview
    [self.view addSubview:self.chooseCategoryButton];
    [self.view addConstraints:[self. chooseCategoryButton positionBelowOtherView:self.questionLabel withPadding:20]];
    [self.view addConstraints:[self.chooseCategoryButton positionAlignLeadingEdgeOfSuperViewWithPadding:20]];
//    [self.view addConstraints:[self.chooseCategoryButton positionCenterYToCenterYForOtherView:self.searchTextField offSet:0]];
    [self.view addConstraints:[self.chooseCategoryButton positionAlignTrailingEdgeOfSuperViewWithPadding: 20]];
    //make the button half the width of the search
    [self.view addConstraints:[self.chooseCategoryButton sameWidthWithOtherView:self.chooseCategoryButton withRatio:1]];
    [self.chooseCategoryButton positionHeight:44];
    //add the submit search button aligning edges with the textfield and the button.
    [self.view addSubview:self.submitSearchButton];
    [self.view addConstraints:[self.submitSearchButton positionBelowOtherView:self.chooseCategoryButton withPadding:10]];
    [self.view addConstraints:[self.submitSearchButton positionAlignLeadingEdgesOfOtherView:self.chooseCategoryButton withPadding:0]];
    [self.view addConstraints:[self.submitSearchButton positionAlignTrailingEdgesOfOtherView:self.chooseCategoryButton withPadding:0]];
    [self.submitSearchButton positionHeight:44];
}

#pragma mark picker controller methods
-(PickerController *)pickerController {
    if (!_pickerController) {
        _pickerController = [PickerController createPickerControllerWithDelegate:self];
    }
    return _pickerController;
}

#pragma mark picker controller delegate methods
-(void)pickerController:(PickerController *)sender didSelectValue:(NSDictionary *)selectedValue {
    [self enableSubmitButton];
    self.selectedInfo = selectedValue;
    [self.chooseCategoryButton setTitle:selectedValue[PICKER_VALUE_KEY] forState:UIControlStateNormal];
    _pickerController = nil;
}

-(void)pickerControllerDidCancel:(PickerController *)sender {
    _pickerController = nil;
}


#pragma mark show views methods 
-(void)showPickerController {
    [self.view endEditing:YES];
    //add it in the application delegate window so it's not covered by the tab bar
    [self.pickerController showPickerInView:[[UIApplication sharedApplication].delegate window]
                                   withInfo:@[@{PICKER_ID_KEY:@"macys",
                                                PICKER_VALUE_KEY:@"Macy's"},
                                              @{PICKER_ID_KEY:@"bestbuy",
                                                PICKER_VALUE_KEY:@"Best buy"}]
                                layoutGuide:nil];
}
#pragma mark button methods
-(void)logoutPressed {
    [[AuthenticationHelper sharedInstance] logout];
}

-(void)authenticationHelperDidLogOff:(AuthenticationHelper *)sender {
    [ApplicationDelegate showAuthenticationView];
}

-(void)chooseCategoryButtonPressed {
    //show the picker with the categories option
    [self showPickerController];
}

-(void)submitSearchPressed {
    BrowseVC *controller = [[BrowseVC alloc]initWithTableViewStyle:UITableViewStyleGrouped];
    [controller setStore:[self.selectedInfo objectForKey:PICKER_ID_KEY]];
    [controller setCategory:self.questionLabel.text];
    [controller setSearchString:self.questionLabel.text];
    [self.navigationController pushViewController:controller animated:YES];
}

@end

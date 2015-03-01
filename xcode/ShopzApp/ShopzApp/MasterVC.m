//
//  MasterVC.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "MasterVC.h"
#import "UIView+LayoutConstraints.h"
#import "CustomButtons.h"

@implementation MasterVC


#pragma mark lifecycle 
-(void)viewDidLoad {
    [super viewDidLoad];
    self.isLoading = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isLoading) {
        [self showSpinner];
    } else {
        [self hideSpinner];
    }
}

#pragma mark back buttons methods
-(void)backArrownButton {
    self.navigationController.navigationBar.topItem.backBarButtonItem = [CustomButtons backButton];

}

-(void)backDownArrowButton {
    self.navigationItem.leftBarButtonItem = [CustomButtons textButtonWithText:@"X"
                                                                forController:self
                                                                     selector:@selector(backPressed)];
}

-(void)backPressed {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark loading methods
-(UIActivityIndicatorView *)spinner {
    if (!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _spinner.translatesAutoresizingMaskIntoConstraints = NO;
        [_spinner startAnimating];
    }
    return _spinner;
}

-(void)showSpinner {
    [self.view addSubview:self.spinner];
    [self.view addConstraints:[self.spinner positionToCenterOfSuperview]];
    self.isLoading = YES;
}

-(void)hideSpinner {
    [self.spinner removeFromSuperview];
    self.spinner = nil;
    self.isLoading = NO;
}

#pragma mark alert methods
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    [[[UIAlertView alloc]initWithTitle:title
                               message:message
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil]show];
}

@end

//
//  AuthenticationVC.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "AuthenticationVC.h"
//controller
#import "AppDelegate.h"
//classes
#import "AuthenticationHelper.h"
@interface AuthenticationVC () <AuthenticationHelperDelegate>

@end
@implementation AuthenticationVC


#pragma mark lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self.facebookButton setBackgroundColor:BLUE_TINT_COLOR];
    [self.twitterButton setBackgroundColor:BLUE_TINT_COLOR];
    [[AuthenticationHelper sharedInstance] setDelegate:self];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}


#pragma mark button methods
- (IBAction)fbButtonPressed:(UIButton *)sender {
    [ApplicationDelegate showLoggedInViews];
#warning removed for testing
//    [self showSpinner];
//    [[AuthenticationHelper sharedInstance] loginWithFB];
}

- (IBAction)twitterButtonPressed:(UIButton *)sender {
    [ApplicationDelegate showLoggedInViews];

#warning removed for testing
//    [self showSpinner];
//    [[AuthenticationHelper sharedInstance] loginWithTwitter];
}

#pragma mark authentication delegate
-(void)authenticationHelperDidLogin:(AuthenticationHelper *)sender {
    [self hideSpinner];
    [ApplicationDelegate showLoggedInViews];
}

-(void)authenticationHelper:(AuthenticationHelper *)sender failedToLoginwithError:(NSError *)error {
    [self hideSpinner];
    [[[UIAlertView alloc]initWithTitle:@"Error"
                               message:error.localizedDescription
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil]show];
}

@end

//
//  AppDelegate.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/27/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BLUE_TINT_COLOR [UIColor colorWithRed:0.0f green:105/255.0 blue:148/255.0 alpha:1]
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define FONT_REGULAR @"AvenirNext-Regular"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

///Main app window
@property (strong, nonatomic) UIWindow *window;
///Main tab bar controller. 
@property (nonatomic,strong) UITabBarController *tabBarController;

/**
 * Shows the authentication view controller.
 * @author Francisco Magdaleno
 *
 */
-(void)showAuthenticationView;

/**
 * Show the logged in views.
 * @author Francisco Magdaleno
 */
-(void)showLoggedInViews;

@end


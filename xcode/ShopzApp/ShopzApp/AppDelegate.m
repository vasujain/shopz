//
//  AppDelegate.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/27/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "AppDelegate.h"
//libraries
#import <FacebookSDK/FacebookSDK.h>
//controllers
#import "AuthenticationVC.h"

@interface AppDelegate ()
@property (nonatomic,strong) AuthenticationVC *authenticationVC;
@end

@implementation AppDelegate


#pragma mark app delegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Set the color for the app
    self.window.tintColor = BLUE_TINT_COLOR;
    [self showAuthenticationView];
    return YES;
}

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

#pragma mark custom methods
-(void)showAuthenticationView {
    _authenticationVC = nil;
    _authenticationVC = [[AuthenticationVC alloc]initWithNibName:NSStringFromClass([AuthenticationVC class])
                                                          bundle:nil];
    [self changeRootViewController:_authenticationVC];
}

-(void)showLoggedInViews {
    //reset the tabcontrolelr
    _tabBarController = nil;
    //we do it from storyboard to save time. only the root vcs will be from storyboard, the rest will be from code
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _tabBarController = (UITabBarController *)[storyboard instantiateInitialViewController];
    [_tabBarController.tabBar setTintColor:BLUE_TINT_COLOR];
    [_tabBarController.tabBar setBarTintColor:[UIColor whiteColor]];
    _tabBarController.tabBar.translucent = NO;
    [self changeRootViewController:_tabBarController];
}

-(void)changeRootViewController:(id)controller {
    //if it's not a subclass of a view controller it can't be presented
    if (![controller isKindOfClass:[UIViewController class]]) {
        NSLog(@"This is not a valid type to present");
        return;
    }
    //make sure we release whatever is there at the moment.
    self.window.rootViewController = nil;
    self.window.rootViewController = controller;
}

@end

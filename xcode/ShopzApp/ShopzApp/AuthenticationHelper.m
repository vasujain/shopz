//
//  AuthenticationHelper.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "AuthenticationHelper.h"
//classes
#import "TwitterAuthHelper.h"
//libraries
#import <FacebookSDK/FacebookSDK.h>
@interface AuthenticationHelper ()

///The root Firebase object
@property (nonatomic, strong) Firebase *rootRef;
@property (nonatomic,strong) TwitterAuthHelper *twitterAuthHelper;

@end

@implementation AuthenticationHelper

// You must setup Simple Login for the various authentication providers in Forge
static NSString * const kFirebaseURL = @"https://intense-fire-2616.firebaseio.com";

+(AuthenticationHelper *)sharedInstance {
    static AuthenticationHelper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[AuthenticationHelper alloc] init];
        _sharedInstance.rootRef = [[Firebase alloc] initWithUrl:kFirebaseURL];
        _sharedInstance.twitterAuthHelper = [[TwitterAuthHelper alloc] initWithFirebaseRef:_sharedInstance.rootRef
                                                                                    apiKey:@"XgfEfCRBDjkb5JPsG3MYMfx6w"];
        
        [_sharedInstance listenToAuthentication];
    });
    
    return _sharedInstance;
}


#pragma mark twitter methods
-(void)loginWithTwitter {
    [self.twitterAuthHelper selectTwitterAccountWithCallback:^(NSError *error, NSArray *accounts) {
        if (error) {
            [self.delegate authenticationHelper:self failedToLoginwithError:error];
            // Error retrieving Twitter accounts
        } else if ([accounts count] == 0) {
            [[[UIAlertView alloc]initWithTitle:@"No accounts"
                                       message:nil
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil]show];
            // No Twitter accounts found on device
        } else {
            // Select an account. Here we pick the first one for simplicity
            ACAccount *account = [accounts firstObject];
            [self.twitterAuthHelper authenticateAccount:account
                                           withCallback:^(NSError *error, FAuthData *authData) {
                                               if (error) {
                                                   [self.delegate authenticationHelper:self failedToLoginwithError:error];
                                                   // Error authenticating account
                                               } else {
                                                   NSLog(@"Auth data %@",authData);
                                                   [self.delegate authenticationHelperDidLogin:self];
                                                   // User logged in!
                                               }
                                           }];
        }
    }];
    
}

#pragma mark facebook login methods
-(void)loginWithFB {
    
    
    [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObjects: @"publish_actions",@"public_profile", nil]
                                        defaultAudience:FBSessionDefaultAudienceEveryone
                                        allowLoginUI:YES
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      if (error) {
                                          
                                          NSLog(@"Facebook login failed. Error: %@", error);
                                          [self.delegate authenticationHelper:self failedToLoginwithError:error];
                                          
                                      } else if (state == FBSessionStateOpen) {
                                          
                                          NSString *accessToken = session.accessTokenData.accessToken;
                                          
                                          [self.rootRef authWithOAuthProvider:@"facebook"
                                                                        token:accessToken
                                                          withCompletionBlock:^(NSError *error, FAuthData *authData) {
                                          
                                                              if (error) {
                                                                  [self.delegate authenticationHelper:self failedToLoginwithError:error];
                                                                  NSLog(@"Login failed. %@", error);
                                                              } else {
                                                                  [self.delegate authenticationHelperDidLogin:self];
                                                                  NSLog(@"Logged in! %@", authData);
                                                              }
                                                              NSLog(@"auth data %@",authData);

                                                          }];
                                      }
                                  }];
}

#pragma mark listening to login
-(void)logout {
    [self.rootRef unauth];
    [[FBSession activeSession] closeAndClearTokenInformation];
    [self.delegate authenticationHelperDidLogOff:self];
}

-(void)listenToAuthentication {
    [self.rootRef  observeAuthEventWithBlock:^(FAuthData *authData) {
        if (authData) {
            // user authenticated with Firebase
            NSLog(@"%@", authData);
        } else {
            // No user is logged in
            NSLog(@"User logged out");
        }
    }];
}




@end

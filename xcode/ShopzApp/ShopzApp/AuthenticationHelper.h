//
//  AuthenticationHelper.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <Foundation/Foundation.h>
//libraries
#import <Firebase/Firebase.h>

@class AuthenticationHelper;
@protocol AuthenticationHelperDelegate
@optional
-(void)authenticationHelperDidLogin:(AuthenticationHelper *)sender;
-(void)authenticationHelperDidLogOff:(AuthenticationHelper *)sender;
-(void)authenticationHelper:(AuthenticationHelper *)sender failedToLoginwithError:(NSError *)error;

@end

@interface AuthenticationHelper : NSObject

@property (nonatomic,weak) id<AuthenticationHelperDelegate>delegate;
/**
 * Creates a shared insatance of the authentication helper
 * @author Francisco Magdaleno
 *
 * @param AuthenticationHelper instance.
 */

+(AuthenticationHelper *)sharedInstance;

/**
 * Login with Fb
 * @author Francisco Magdaleno

 */
-(void)loginWithFB;

/**
 * Login with Twitter
 * @author Francisco Magdaleno
 
 */
-(void)loginWithTwitter;
/**
 * Log user out
 * @author Francisco Magdaleno
 *
 */
-(void)logout;



@end

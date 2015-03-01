//
//  MasterVC.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterVC : UIViewController

///Indicates if the spinners is currently active.
@property (nonatomic) BOOL isLoading;
///Loading spinner
@property (nonatomic,strong) UIActivityIndicatorView *spinner;

/**
 * Changes the back button to an X. Use for modal views.
 * @author Francisco Magdaleno
 *
 */
-(void)backDownArrowButton;

/**
 * Changes the back button to an single arrow. Use for pushed VCs.
 * @author Francisco Magdaleno
 *
 */
-(void)backArrownButton;

/**
 * Shows the loading spinner.
 * @author Francisco Magdaleno
 *
 */
-(void)showSpinner;

/**
 * Hides the loading spinner.
 * @author Francisco Magdaleno
 *
 */
-(void)hideSpinner;

/**
 * Shows an alert view with a custom title and message. Only an "OK" button. Use this for informative purpose, not expecting a reaction.
 * @author Francisco Magdaleno
 *
 * @param title Alert title
 * @param message Alert message
 */
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end

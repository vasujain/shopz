//
//  CustomButtons.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CustomButtons : NSObject

/**
 * Creates a button with a given title
 * @author Francisco Magdaleno
 *
 * @param text Title for the button
 * @param controller Controller to execute the action
 * @param selector Action triggered whtn tapping the button
 * @return Button item
 */
+(UIBarButtonItem *)textButtonWithText:(NSString *)text
                         forController:(id)controller
                              selector:(SEL)selector;

/**
 * Creates a button with a given iamge
 * @author Francisco Magdaleno
 *
 * @param text Title for the button
 * @param controller Controller to execute the action
 * @param selector Action triggered whtn tapping the button
 * @return Button item
 */
+(UIBarButtonItem *)imageButtonWithName:(NSString *)name
                          forController:(id)controller
                               selector:(SEL)selector;

/**
 * Single back arrow.
 * @author Francisco Magdaleno
 * @return Single arrow back buton.
 */
+(UIBarButtonItem *)backButton;
@end

//
//  CustomButtons.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "CustomButtons.h"

@implementation CustomButtons

+(UIBarButtonItem *)backButton {
    return [[UIBarButtonItem alloc] initWithTitle:@""
                                            style:UIBarButtonItemStylePlain
                                           target:nil
                                           action:nil];
    
}

+(UIBarButtonItem *)textButtonWithText:(NSString *)text
                         forController:(id)controller
                              selector:(SEL)selector {
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:text
                                                              style:UIBarButtonItemStylePlain
                                                             target:controller
                                                             action:selector];
    [button setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"AvenirNext-Medium" size:17.0], NSFontAttributeName,
                                    nil]
                          forState:UIControlStateNormal];
    
    return button;
}

+(UIBarButtonItem *)imageButtonWithName:(NSString *)name forController:(id)controller selector:(SEL)selector {
    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:name]
                                           style:UIBarButtonItemStylePlain
                                          target:controller
                                          action:selector];
}

@end

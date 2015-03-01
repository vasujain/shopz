//
//  ToastView.h
//  ShopzApp
//
//  Created by Mahesh Kumar on 3/1/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastView : UIView

@property (strong, nonatomic) NSString *text;

+ (void)showToastInParentView: (UIView *)parentView withText:(NSString *)text withDuaration:(float)duration;

@end

//
//  AuthenticationVC.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "MasterVC.h"

@interface AuthenticationVC : MasterVC

///Background image.
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
///Label with the logo or company name.
@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
///Fb login button.
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
///Twitter login button.
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
///Button separator.
@property (weak, nonatomic) IBOutlet UIImageView *separatorImageView;
@end

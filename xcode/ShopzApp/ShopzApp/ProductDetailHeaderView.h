//
//  ProductDetailHeaderView.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductModel;

@interface ProductDetailHeaderView : UIView
///Product image view
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
///Product name label
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
///Product store
@property (weak, nonatomic) IBOutlet UILabel *productStoreLabel;
///Product reviews by friends image
@property (weak, nonatomic) IBOutlet UIImageView *groupImageView;
///Products reviews by friends
@property (weak, nonatomic) IBOutlet UILabel *groupCountLabel;
///Black overlay view
@property (weak, nonatomic) IBOutlet UIView *overlayView;
///Product description label.
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
///Triggers the invitation to friends reviews.
@property (weak, nonatomic) IBOutlet UIButton *reviewsButton;
///Triggers the sare action for the product.
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

/**
 * Configures the view with a given product.
 * @author Francisco Magdaleno
 *
 * @param product Product holding the full information.
 */
-(void)configureWithProduct:(ProductModel *)product;

@end

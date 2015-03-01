//
//  ProductDetailHeaderView.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "ProductDetailHeaderView.h"

//controller
#import "AppDelegate.h"

//classes
#import "ProductModel.h"
#import "UIImageView+AFNetworking.h"

@implementation ProductDetailHeaderView

-(void)configureWithProduct:(ProductModel *)product {
    __weak ProductDetailHeaderView *weakSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:product.largeFrontImage];
    UIImage *placeholderImage = [UIImage imageNamed:@"shoes"];
    [self.productImageView setImageWithURLRequest:request
                                 placeholderImage:placeholderImage
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                              
                                              weakSelf.productImageView.image = image;
                                              [weakSelf setNeedsLayout];
                                              
                                          } failure:nil];
    [self.productNameLabel setText:product.name];
    [self.productStoreLabel setText:[NSString stringWithFormat:@"by %@",product.fromStore]];
    //configure description
    [self.reviewsButton setBackgroundColor:BLUE_TINT_COLOR];
    [self.reviewsButton setTitle:@"Review" forState:UIControlStateNormal];
    [self.reviewsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.reviewsButton.layer.cornerRadius = 6.0;
    self.reviewsButton.clipsToBounds = YES;
}

#pragma mark buttons
- (IBAction)reviewsPressed:(UIButton *)sender {
}

- (IBAction)sharePressed:(UIButton *)sender {
}

@end

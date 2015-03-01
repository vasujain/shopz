//
//  ProductCell.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "ProductCell.h"
//classes
#import "ProductModel.h"
#import "ProductModel.h"
#import "UIImageView+AFNetworking.h"

@implementation ProductCell

-(void)prepareForReuse {
    self.productImageView.image = nil;
    self.productNameLabel.text = nil;
    self.storeNameLabel.text = nil;
//    self.groupCountLabel.text = nil;
//    self.groupImageView.image = nil;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)configureWithProductModel:(ProductModel *)product {
    
//    [self.productImageView setImage:[UIImage imageNamed:product.productImageURLString]];
    __weak ProductCell *weakCell = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:product.largeFrontImage];
    UIImage *placeholderImage = [UIImage imageNamed:@"shoes"];
    [self.productImageView setImageWithURLRequest:request
                                 placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.productImageView.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
    [self.productNameLabel setText:product.name];

#warning real store
    [self.storeNameLabel setText:[NSString stringWithFormat:@"by %@",product.fromStore]];
    
    
}


@end

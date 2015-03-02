//
//  ProductCell.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendationCollectionModel.h"

@class ProductModel;
@interface ProductCell : UITableViewCell

///Product image.
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
///Product name.
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
///Store that sells the product.
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
///Group image icon.
@property (weak, nonatomic) IBOutlet UIImageView *groupImageView;
///Group count label.
@property (weak, nonatomic) IBOutlet UILabel *groupCountLabel;

@property (strong, nonatomic) RecommendationCollectionModel* productRecommendations;
//Configure the internal views with the given information.
-(void)configureWithProductModel:(ProductModel *)product;


@end

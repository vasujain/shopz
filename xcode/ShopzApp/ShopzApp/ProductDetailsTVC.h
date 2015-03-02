//
//  ProductDetailsTVC.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "MasterTVC.h"
#import "RecommendationCollectionModel.h"

@class ProductModel;
@interface ProductDetailsTVC : MasterTVC

///Product to display.
@property (nonatomic,strong) ProductModel *product;
@property (nonatomic,strong) RecommendationCollectionModel* productRecommendations;

- (IBAction)buyButtonPressed:(UIButton *)sender;


@end

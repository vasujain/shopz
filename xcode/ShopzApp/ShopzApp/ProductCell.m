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
#import "UIImageView+AFNetworking.h"
#import "SearchManager.h"
#import "RecommendationCollectionModel.h"
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
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.productImageView setImageWithURLRequest:request
                                 placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.productImageView.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
    [self.productNameLabel setText:product.name];

    [self.storeNameLabel setText:[NSString stringWithFormat:@"by %@",product.fromStore]];
    
    
    //Query server for recommendations
    [SearchManager queryRecommendationsForProduct: [NSString stringWithFormat:@"%@",product.sku ]
                                          success:^(id responseObject) {
        
        RecommendationCollectionModel* searchResults = (RecommendationCollectionModel*) responseObject;
          weakCell.productRecommendations = searchResults;
        NSLog(@"output : %@" , searchResults.toJSONString);
        
        //Update UI on main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            long count = searchResults.buyit.integerValue + searchResults.forgetit.integerValue;
            weakCell.groupCountLabel.text = [NSString stringWithFormat:@"%ld", count];
            [weakCell setNeedsLayout];
            
        });
    } failure:^(NSError *error) {
        NSLog(@"query recommendations error: %@", error);
    }];

    
    
}


@end

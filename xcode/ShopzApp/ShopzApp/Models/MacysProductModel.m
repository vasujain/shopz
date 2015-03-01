//
//  MacysProductModel.m
//  ShopzApp
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "MacysProductModel.h"

@implementation MacysProductModel
/*
 @property (strong, nonatomic) NSNumber* sku;
 @property (strong, nonatomic) NSString<Optional>* name;
 @property (strong, nonatomic) NSNumber<Optional>* salePrice;
 @property (assign, nonatomic) BOOL onSale;
 @property (strong, nonatomic) NSString<Optional>* regularPrice;
 @property (strong, nonatomic) NSURL<Optional>* image;
 @property (strong, nonatomic) NSString<Optional>* shortDescription;
 @property (strong, nonatomic) NSURL<Optional>* largeFrontImage;
 @property (strong, nonatomic) NSURL<Optional>* url;
 @property (strong, nonatomic) NSURL<Optional>* spin360Url;
 @property (strong, nonatomic) NSURL<Optional>*  mobileUrl;
 @property (strong, nonatomic) NSURL<Optional>* addToCartUrl;
 @property (strong, nonatomic) NSURL<Optional>* mediumImage;
 @property (strong, nonatomic) NSURL<Optional>* thumbnailImage;
 @property (strong, nonatomic) NSURL<Optional>* largeImage;
 @property (strong, nonatomic) NSString<Optional>* longDescription;
 */

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"sku",
                                                       @"summary.name": @"name",
                                                       @"summary.producturl": @"url",
                                                       @"summary.onsale": @"onSale",
                                                       @"price.sale.value": @"salePrice",
                                                       @"price.regular.value": @"regularPrice",
                                                       @"image": @"images"
                                                       }];
}
@end

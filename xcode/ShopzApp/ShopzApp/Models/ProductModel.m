//
//  ProductModel.m
//  shopZ
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 brk.im. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel



- (id) initWithMacysProduct: (MacysProductModel*) macysProduct
{
    self = [super init];

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
    
    self.sku = macysProduct.sku;
    self.name = macysProduct.name;
    self.url = macysProduct.url;
    self.largeFrontImage = [macysProduct.images[0] imageurl];
    self.fromStore = macysProduct.fromStore;
    self.longDescription = macysProduct.longDescription;
    self.salePrice = macysProduct.salePrice;
    self.regularPrice = macysProduct.regularPrice;
    self.onSale = macysProduct.onSale;
    
    return self;

    
}



@end

//
//  Product.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

#define PRODUCT_ID_KEY @"_id"
#define PRODUCT_NAME_KEY @"name"
#define PRODUCT_IMAGE_URL_KEY @"image"
#define PRODUCT_STORE_KEY @"store"
#define PRODUCT_PRICE_KEY @"price"
///ID for product.
@property (nonatomic,strong) NSString *productID;
///Product name.
@property (nonatomic,strong) NSString *productName;
///URL String for the product image
@property (nonatomic,strong) NSString *productImageURLString;
///The store name where this product belongs.
@property (nonatomic,strong) NSString *productStore;
///Price of the product.
@property (nonatomic,strong) NSString *productPrice;

+(Product *)productWithInfo:(NSDictionary *)info;

@end

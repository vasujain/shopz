//
//  Product.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "Product.h"
//classes
#import "NSObject+NullObjects.h"
@implementation Product

+(Product *)productWithInfo:(NSDictionary *)info {
    
    Product *product = [[Product alloc]init];
    product.productID = [info[PRODUCT_ID_KEY] nilIfNull];
    product.productName = [info[PRODUCT_NAME_KEY] nilIfNull];
    product.productImageURLString = [info[PRODUCT_IMAGE_URL_KEY] nilIfNull];
    product.productStore = [info[PRODUCT_STORE_KEY] nilIfNull];
    product.productPrice = [info[PRODUCT_PRICE_KEY] nilIfNull];
    
    return product;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"ID:%@\nName:%@\nImageURL%@\nStore:%@\nPrice:%@",self.productID,self.productName,self.productImageURLString,self.productStore,self.productPrice];
}
@end

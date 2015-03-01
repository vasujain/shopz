//
//  MacysSearchResultModel.m
//  ShopzApp
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "MacysSearchResultModel.h"

@implementation MacysSearchResultModel


+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"products.product": @"products",
                                                       }];
}

- (void) setStore: (NSString*) store
{
    for (MacysProductModel* product in self.products) {
        product.fromStore = store;
    }
}

@end

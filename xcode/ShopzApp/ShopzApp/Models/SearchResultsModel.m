//
//  SearchResultsModel.m
//  shopZ
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 brk.im. All rights reserved.
//

#import "SearchResultsModel.h"

@implementation SearchResultsModel

- (void) setStore: (NSString*) store
{
    //searchresultgroups
    
    for (ProductModel* product in self.products) {
        product.fromStore = store;
    }
}

- (id) initWithMacysProductResults: (MacysSearchResultModel*) macysResult
{
    self = [super init];
    self.products = (NSMutableArray<ProductModel>*)[[NSMutableArray alloc]init];
    for (MacysProductModel* product  in macysResult.products) {
        ProductModel* newProduct = [[ProductModel alloc]initWithMacysProduct:product];
        [self.products addObject:newProduct];
    }
    
    return self;
}


@end


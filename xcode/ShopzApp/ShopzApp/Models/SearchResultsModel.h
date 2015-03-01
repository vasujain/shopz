//
//  SearchResultsModel.h
//  shopZ
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 brk.im. All rights reserved.
//

#import "JSONModel.h"
#import "ProductModel.h"
#import "MacysSearchResultModel.h"

@interface SearchResultsModel : JSONModel

@property (strong, nonatomic) NSMutableArray<ProductModel>* products;

- (void) setStore: (NSString*) store;

- (id) initWithMacysProductResults: (MacysSearchResultModel*) macysResult;


@end

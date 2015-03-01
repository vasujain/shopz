//
//  MacysSearchResultModel.h
//  ShopzApp
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "JSONModel.h"
#import "MacysProductModel.h"


@interface MacysSearchResultModel : JSONModel

@property (strong, nonatomic) NSMutableArray<MacysProductModel>* products;

- (void) setStore: (NSString*) store;
@end

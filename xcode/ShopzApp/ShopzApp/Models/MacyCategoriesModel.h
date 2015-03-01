//
//  MacyCategoriesModel.h
//  ShopzApp
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "JSONModel.h"
#import "CategoryModel.h"

@interface MacyCategoriesModel : JSONModel

@property (strong, nonatomic) NSMutableArray<CategoryModel>* categories;
- (void) setStore: (NSString*) store;

@end

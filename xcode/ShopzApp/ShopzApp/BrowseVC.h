//
//  BrowseVC.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "MasterTVC.h"

@interface BrowseVC : MasterTVC
///Store to show products.
@property (nonatomic,strong) NSString *store;
///Category to search.
@property (nonatomic,strong) NSString *category;

@property (nonatomic, strong) NSString * searchString;
@end

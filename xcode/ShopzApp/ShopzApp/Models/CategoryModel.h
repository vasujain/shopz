//
//  CategoryModel.h
//  ShopzApp
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "JSONModel.h"
@protocol CategoryModel
@end

@interface CategoryModel : JSONModel
@property (strong, nonatomic) NSNumber* id;
@property (strong, nonatomic) NSString<Optional>* name;

@end

//
//  RecommendationCollectionModel.m
//  ShopzApp
//
//  Created by Mahesh Kumar on 3/1/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "RecommendationCollectionModel.h"

@implementation RecommendationCollectionModel


+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"value.buyit": @"buyit",
                                                       @"value.forgetit": @"forgetit",
                                                       @"value.comment": @"comment",
                                                       @"value.pid": @"pid",
                                                       }];
}

@end

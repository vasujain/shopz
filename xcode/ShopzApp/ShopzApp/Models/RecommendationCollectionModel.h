//
//  RecommendationCollectionModel.h
//  ShopzApp
//
//  Created by Mahesh Kumar on 3/1/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "JSONModel.h"

@interface RecommendationCollectionModel : JSONModel
/*
{
    "key": "-JjKv0yZCMkYkqJUHfqo",
    "value": {
        "buyit": 1,
        "comment": "[\"good\". \"go 4 it\"]",
        "forgetit": 0,
        "pid": "101"
    }
}*/
@property (strong, nonatomic) NSNumber<Optional>* pid;
@property (strong, nonatomic) NSNumber<Optional>* buyit;
@property (strong, nonatomic) NSNumber<Optional>* forgetit;
@property (strong, nonatomic) NSString<Optional>* friendName;
@property (strong, nonatomic) NSArray<Optional>* comment;

@end

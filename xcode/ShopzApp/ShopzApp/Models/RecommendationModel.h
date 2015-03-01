//
//  RecommendationModel.h
//  ShopzApp
//
//  Created by Mahesh Kumar on 3/1/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "JSONModel.h"

@interface RecommendationModel : JSONModel

@property (strong, nonatomic) NSNumber* pid;
@property (strong, nonatomic) NSNumber<Optional>* thumbsUp;
@property (strong, nonatomic) NSNumber<Optional>* thumbsDown;
@property (strong, nonatomic) NSString<Optional>* comment;
@property (strong, nonatomic) NSString<Optional>* friendName;

@end

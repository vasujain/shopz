//
//  Review.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "Review.h"
#import "NSObject+NullObjects.h"
@implementation Review

+(Review *)reviewWithInfo:(NSDictionary *)reviewInfo {
    Review *review = [[Review alloc]init];
    review.reviewText = [reviewInfo[REVIEW_TEXT_KEY]nilIfNull];
    review.reviewCreationDate = [reviewInfo[REVIEW_CREATION_DATE_KEY]nilIfNull];
    review.reviewFriendName = [reviewInfo[REVIEW_FRIEND_NAME_KEY]nilIfNull];
    return review;
}

@end

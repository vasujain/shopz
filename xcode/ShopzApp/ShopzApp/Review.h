//
//  Review.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

#define REVIEW_FRIEND_NAME_KEY @"friend_name"
#define REVIEW_CREATION_DATE_KEY @"creation_date"
#define REVIEW_TEXT_KEY @"review_text"

///Reviewer friend name
@property (nonatomic,strong) NSString *reviewFriendName;
///Timestamp of review creation
@property (nonatomic,strong) NSString *reviewCreationDate;
///Review content
@property (nonatomic,strong) NSString *reviewText;
//ThumbsDown
@property (nonatomic,assign) BOOL thumbsUp;
/**
 * Creates a review instance.
 * @author Francisco Magdaleno
 *
 * @param reviewInfo Dictionary with the info needed to create a review object.
 * @return Review instance
 */

+(Review *)reviewWithInfo:(NSDictionary *)reviewInfo;
@end

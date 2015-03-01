//
//  ProductReviewCell.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "ProductReviewCell.h"

@implementation ProductReviewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)configureCellWithReview:(Review *)review {
    
//    NSString *timeSetString = note.noteUpdateAt ? @"Updated by" : @"Created by";
//    NSDate *dateToShow = note.noteUpdateAt ? note.noteUpdateAt : note.noteCreatedAt;
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"dd/MMM hh:mm a"];
//    NSString *dateString = [formatter stringFromDate:dateToShow];
//    //get the string from the date
    NSString *creatorText = [NSString stringWithFormat:@"Created by %@  at %@",
                                            review.reviewFriendName,
                                            review.reviewCreationDate];
    
    [self.creationLabel setText:creatorText];
    [self.contentLabel setText:review.reviewText];
    
}


@end

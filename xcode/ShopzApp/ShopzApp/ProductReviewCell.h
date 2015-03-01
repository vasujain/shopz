//
//  ProductReviewCell.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"
@interface ProductReviewCell : UITableViewCell
///Shows the creator fo the review and timestamp
@property (weak, nonatomic) IBOutlet UILabel *creationLabel;
///Shows the content of the actual review
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/**
 * Configure the cell internal views with a given review.
 * @author Francisco Magdaleno
 *
 * @param review Review withe the info.
 */
-(void)configureCellWithReview:(Review *)review;

@end

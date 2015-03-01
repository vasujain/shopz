//
//  UIView+LayoutConstraints.m
//  Autolayout
//
//  Created by Francisco Magdaleno on 4/7/14.
//  Copyright (c) 2014 pako. All rights reserved.
//

#import "UIView+LayoutConstraints.h"

//define vistual contraints

//horizontal
#define kHorizontalEdgesForSuperView @"|[view]|"
#define kHorizontalEdgesForSuperViewWithPadding @"|-padding-[view]-padding-|"
#define kHorizontalLeadingEdgeForSuperViewPadding @"|-padding-[view]"
#define kHorizontalTrailingEdgeForSuperViewPadding @"[view]-padding-|"

//vertical
#define kVerticalEdgesForSuperView @"V:|[view]|"
#define kVerticalEdgesForSuperViewWithPadding @"V:|-padding-[view]-padding-|"
#define kVerticalTopEdgeForSuperViewPadding @"V:|-padding-[view]"
#define kVerticalBottomEdgeForSuperViewPadding @"V:[view]-padding-|"

#define kVerticalEdgesForSuperViewWithGuides @"V:[topGuide][view][bottomGuide]"
#define kVerticalEdgesForSuperViewWithTopGuide @"V:[topGuide][view]"
#define kVerticalEdgesForSuperViewWithBottomGuide @"V:[view][bottomGuide]"

#define kVerticalToBottomGuide @"V:[view][bottomGuide]"
#define kVerticalToTopGuide @"V:[topGuide][view]"


//metrics
#define kViewKey @"view"
#define kOtherViewKey @"otherView"
#define kWidthKey @"width"
#define kHeightKey @"height"
#define kTopGuideKey @"topGuide"
#define kBottomGuideKey @"bottomGuide"
#define kPadding @"padding"

@implementation UIView (LayoutConstraints)


#pragma mark view size method
-(void)positionWidthSameAsHeight {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //set the width same as height
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0f
                                                                   constant:0.0f];
    [totalConstraints addObject:constraint];
    [self addConstraints:totalConstraints];
}

-(void)positionHeightSameAsWidth {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //set the height same as width
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0f
                                                                   constant:0.0f];
    [totalConstraints addObject:constraint];
    [self addConstraints:totalConstraints];
}

-(void)positionWidth:(float)width {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //width with value
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0f
                                                                   constant:width];
    [totalConstraints addObject:constraint];
    [self addConstraints:totalConstraints];

}

-(void)positionHeight:(float)height {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //height with value
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0f
                                                                    constant:height];
    [totalConstraints addObject:constraint];
    [self addConstraints:totalConstraints];
}

-(void)positionWidth:(float)width
              height:(float)height {
    //add with constraint
    [self positionWidth:width];
    //add height constraint
    [self positionHeight:height];
}

#pragma mark Aligning with super view
-(NSArray *)positionCenterXToCenterXOfSuperView {
    return [self positionCenterXToCenterXForOtherView:self.superview offSet:0];
}

-(NSArray *)positionCenterYToCenterYOfSuperView {
    return [self positionCenterYToCenterYForOtherView:self.superview offSet:0];
}

-(NSArray *)positionCenterXToCenterXOfSuperViewWithOffSet:(float)offset {
    return [self positionCenterXToCenterXForOtherView:self.superview offSet:offset];
}

-(NSArray *)positionCenterYToCenterYOfSuperViewWithOffSet:(float)offset {
    return [self positionCenterYToCenterYForOtherView:self.superview offSet:offset];
}

-(NSArray *)positionToCenterOfSuperview {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //align center X
    [totalConstraints addObjectsFromArray:[self positionCenterXToCenterXOfSuperView]];
    //align center Y
    [totalConstraints addObjectsFromArray:[self positionCenterYToCenterYOfSuperView]];
    
    return totalConstraints;
}

-(NSArray *)positionToCenterOfSuperviewWithXOffset:(float)offset {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //align center x
    [totalConstraints addObjectsFromArray:[self positionCenterXToCenterXOfSuperViewWithOffSet:offset]];
    //align y
    [totalConstraints addObjectsFromArray:[self positionCenterYToCenterYOfSuperView]];
    
    return totalConstraints;
}

-(NSArray *)positionToCenterOfSuperviewWithYOffset:(float)offset {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //align center x
    [totalConstraints addObjectsFromArray:[self positionCenterXToCenterXOfSuperView]];
    //align y
    [totalConstraints addObjectsFromArray:[self positionCenterYToCenterYOfSuperViewWithOffSet:offset]];
    
    return totalConstraints;
}

-(NSArray *)positionAlignTrailingEdgeOfSuperView {
    return [self positionAlignTrailingEdgeOfSuperViewWithPadding:0];
}

-(NSArray *)positionAlignLeadingEdgeOfSuperView {
    return [self positionAlignLeadingEdgeOfSuperViewWithPadding:0];
}

-(NSArray *)positionAlignTopEdgeOfSuperView {
    return [self positionAlignTopEdgeOfSuperViewWithPadding:0];
}

-(NSArray *)positionAlignBottomEdgeOfSuperView {
    return [self positionAlignBottomEdgeOfSuperViewWithPadding:0];
}

-(NSArray *)positionAlignTopEdgeOfSuperViewWithPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //set horizontal constraints
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:kVerticalTopEdgeForSuperViewPadding
                                                                   options:0
                                                                   metrics:@{kPadding:[NSNumber numberWithFloat:padding]}
                                                                     views:@{kViewKey:self}];
    [totalConstraints addObjectsFromArray:constraints];
    
    return totalConstraints;
}

-(NSArray *)positionAlignBottomEdgeOfSuperViewWithPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //set horizontal constraints
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:kVerticalBottomEdgeForSuperViewPadding
                                                                   options:0
                                                                   metrics:@{kPadding:[NSNumber numberWithFloat:padding]}
                                                                     views:@{kViewKey:self}];
    [totalConstraints addObjectsFromArray:constraints];
    
    return totalConstraints;
}

-(NSArray *)positionAlignTrailingEdgeOfSuperViewWithPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //Align trailing edges with super view
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:kHorizontalTrailingEdgeForSuperViewPadding
                                                                   options:0
                                                                   metrics:@{kPadding:[NSNumber numberWithFloat:padding]}
                                                                     views:@{kViewKey:self}];
    [totalConstraints addObjectsFromArray:constraints];
    
    return totalConstraints;
}


-(NSArray *)positionAlignLeadingEdgeOfSuperViewWithPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //Alignt leading edges with super view
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:kHorizontalLeadingEdgeForSuperViewPadding
                                                                   options:0
                                                                   metrics:@{kPadding:[NSNumber numberWithFloat:padding]}
                                                                     views:@{kViewKey:self}];
    [totalConstraints addObjectsFromArray:constraints];
    
    return totalConstraints;
}

-(NSArray *)positionToFillSuperView {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    
    //align leading
    [totalConstraints addObjectsFromArray:[self positionAlignLeadingEdgeOfSuperView]];
    //align trailing
    [totalConstraints addObjectsFromArray:[self positionAlignTrailingEdgeOfSuperView]];
    //align top
    [totalConstraints addObjectsFromArray:[self positionAlignTopEdgeOfSuperView]];
    //align bottom
    [totalConstraints addObjectsFromArray:[self positionAlignBottomEdgeOfSuperView]];
    
    
    return totalConstraints;
}

-(NSArray *)positionToFillSuperViewWithPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    
    //align leading
    [totalConstraints addObjectsFromArray:[self positionAlignLeadingEdgeOfSuperViewWithPadding:padding]];
    //align trailing
    [totalConstraints addObjectsFromArray:[self positionAlignTrailingEdgeOfSuperViewWithPadding:padding]];
    //align top
    [totalConstraints addObjectsFromArray:[self positionAlignTopEdgeOfSuperViewWithPadding:padding]];
    //align bottom
    [totalConstraints addObjectsFromArray:[self positionAlignBottomEdgeOfSuperViewWithPadding:padding]];
    
    return totalConstraints;
}

-(NSArray *)positionToTopLeftCornerOfSuperviewWithOffset:(float)offSet {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //align leading
    [totalConstraints addObjectsFromArray:[self positionAlignLeadingEdgeOfSuperViewWithPadding:offSet]];
    //align top
    [totalConstraints addObjectsFromArray:[self positionAlignTopEdgeOfSuperViewWithPadding:offSet]];
    return totalConstraints;
}

-(NSArray *)positionToTopRightCornerOfSuperviewWithOffSet:(float)offSet {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //align trailing
    [totalConstraints addObjectsFromArray:[self positionAlignTrailingEdgeOfSuperViewWithPadding:offSet]];
    //align top
    [totalConstraints addObjectsFromArray:[self positionAlignTopEdgeOfSuperViewWithPadding:offSet]];
    
    return totalConstraints;
}

-(NSArray *)positionToBottomLeftCornerOfSuperviewWithOffSet:(float)offSet {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //align leading
    [totalConstraints addObjectsFromArray:[self positionAlignLeadingEdgeOfSuperViewWithPadding:offSet]];
    //align bottom
    [totalConstraints addObjectsFromArray:[self positionAlignBottomEdgeOfSuperViewWithPadding:offSet]];
    
    return totalConstraints;
}
-(NSArray *)positionToBottomRightCornerOfSuperviewWithOffSet:(float)offSet {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //align trailing
    [totalConstraints addObjectsFromArray:[self positionAlignTrailingEdgeOfSuperViewWithPadding:offSet]];
    //align bottom
    [totalConstraints addObjectsFromArray:[self positionAlignBottomEdgeOfSuperViewWithPadding:offSet]];
    
    return totalConstraints;
}

-(NSArray *)positionToTopLeftCornerOfSuperview {
    return [self positionToTopLeftCornerOfSuperviewWithOffset:0];
}

-(NSArray *)positionToTopRightCornerOfSuperview {
    return [self positionToTopRightCornerOfSuperviewWithOffSet:0];
}
-(NSArray *)positionToBottomLeftCornerOfSuperview {
    return [self positionToBottomLeftCornerOfSuperviewWithOffSet:0];
}

-(NSArray *)positionToBottomRightCornerOfSuperview {
    return [self positionToBottomRightCornerOfSuperviewWithOffSet:0];
}


#pragma mark Aligning with layout guides
-(NSArray *)positionAlignBottomGuide:(id)bottomGuide {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //set horizontal constraints
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:kVerticalToBottomGuide
                                                                   options:0
                                                                   metrics:nil
                                                                     views:@{kViewKey:self,
                                                                             kBottomGuideKey:bottomGuide}];
    [totalConstraints addObjectsFromArray:constraints];
    
    return totalConstraints;
}

-(NSArray *)positionAlignTopGuide:(id)topGuide {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //set horizontal constraints
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:kVerticalToTopGuide
                                                                   options:0
                                                                   metrics:nil
                                                                     views:@{kViewKey:self,
                                                                             kTopGuideKey:topGuide}];
    [totalConstraints addObjectsFromArray:constraints];
    
    return totalConstraints;
}

#pragma mark Aligning with another view
-(NSArray *)positionCenterXToCenterXForOtherView:(UIView *)otherView offSet:(float)offset {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //make center constraints X equal with offset with another view
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionCenterYToCenterYForOtherView:(UIView *)otherView offSet:(float)offset {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //make center Y constraints equal with offset with another view
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionAlignTopEdgesOfOtherView:(UIView *)otherView withPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //make top edges equal with padding with another view
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:padding];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionAlignTrailingEdgesOfOtherView:(UIView *)otherView withPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //make trailing edges equal with padding with another view
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:padding];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionAlignLeadingEdgesOfOtherView:(UIView *)otherView withPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //make leading edges equal with padding with another view
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0f
                                                                   constant:padding];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionAlignBottomEdgesOfOtherView:(UIView *)otherView withPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //make bottom edges equal with padding with another view
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:padding];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionToTrailOtherView:(UIView *)otherView withPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //make trailing edges equal to another view with padding
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0f
                                                                   constant:padding];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionToLeadOtherView:(UIView *)otherView withPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //Align the trailing and leading edges with padding
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:padding];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionOnTopOfOtherView:(UIView *)otherView withPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //Align bottom to top to another view to padding
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:padding];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionBelowOtherView:(UIView *)otherView withPadding:(float)padding {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //Align top to bottom of another view with padding
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:padding];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionToCenterOfOtherView:(UIView *)otherView {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //align center X
    [totalConstraints addObjectsFromArray:[self positionCenterXToCenterXForOtherView:otherView offSet:0]];
    //align center Y
    [totalConstraints addObjectsFromArray:[self positionCenterYToCenterYForOtherView:otherView offSet:0]];
    
    return totalConstraints;
}

-(NSArray *)sameWidthWithOtherView:(UIView *)otherView {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0
                                                                   constant:0.0];
    return @[constraint];
}

-(NSArray *)sameWidthWithOtherView:(UIView *)otherView withRatio:(float)ratio {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:ratio
                                                                   constant:0.0];
    return @[constraint];
}

-(NSArray *)sameHeightInWithOtherView:(UIView *)otherView {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:0.0];
    return @[constraint];
}

-(NSArray *)sameWidthAndHieghtWithOtherView:(UIView *)otherView {
    NSMutableArray *totalConstraints = [NSMutableArray array];

    //align top edges
    [totalConstraints addObjectsFromArray:[self sameWidthWithOtherView:otherView]];
    //align left edges
    [totalConstraints addObjectsFromArray:[self sameHeightInWithOtherView:otherView]];
    
    return totalConstraints;
}

#pragma mark obtaining existing constraints
-(NSLayoutConstraint *)widthConstraint {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth)
            return constraint;
    }
    return nil;
}

-(NSLayoutConstraint *)heightConstraint {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight)
            return constraint;
    }
    return nil;
}


#pragma mark deprecated
-(NSArray *)positionAlignTopToBottomOfOtherView:(UIView *)otherView {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:0];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}

-(NSArray *)positionAlignBottomToTopOfOtherView:(UIView *)otherView {
    NSMutableArray *totalConstraints = [NSMutableArray array];
    //set horizontal constraints
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:0];
    [totalConstraints addObject:constraint];
    
    return totalConstraints;
}


@end

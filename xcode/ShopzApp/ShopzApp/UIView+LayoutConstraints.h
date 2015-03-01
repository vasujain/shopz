//
//  UIView+LayoutConstraints.h
//  Autolayout
//
//  Created by Francisco Magdaleno on 4/7/14.
//  Copyright (c) 2014 pako. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutConstraints)

//adding size to views
/**
 * Adds a height constraint with a given constant. The constraints are added to the the view.
 * @author Francisco Magdaleno
 *
 * @param height Value in points for the height.
 */
-(void)positionHeight:(float)height;

/**
 * Adds a width constraint with a given constant. The constraints are added to the the view.
 * @author Francisco Magdaleno
 *
 * @param width Value in points for the width.
 */
-(void)positionWidth:(float)width;

/**
 * Adds a height constraint that matches the existing width constraint. The constraints are added to the the view.
 * @author Francisco Magdaleno
 *
 */
-(void)positionHeightSameAsWidth;

/**
 * Adds a width constraint that matches the existing height constraint. The constraints are added to the the view.
 * @author Francisco Magdaleno
 *
 */
-(void)positionWidthSameAsHeight;

/**
 * Creates a width and a height constraint with given constants. The constraints are added to the the view.
 * @author Francisco Magdaleno
 *
 * @param width Value in points for width.
 * @param height Value in points for height.
 */
-(void)positionWidth:(float)width height:(float)height;

//Aligning with super view
/**
 * Align the center X axis to the super view center X axis. The constraints are added to the the view.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionCenterXToCenterXOfSuperView;

/**
 * Align the center Y axis to the super view center Y axis. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionCenterYToCenterYOfSuperView;

/**
 * Align the center X axis to the super view center X axis with an offset. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param offset Value to move the axis. Positive moves it down.
 * @return An array of constraints.
 */
-(NSArray *)positionCenterXToCenterXOfSuperViewWithOffSet:(float)offset;

/**
 * Align the center Y axis to the super view center Y axis with an offset. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param offset Value to move the axis. Positive moves it down.
 * @return An array of constraints.
 */
-(NSArray *)positionCenterYToCenterYOfSuperViewWithOffSet:(float)offset;

/**
 * Position the view to the center with an X Offset. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param offset Value to move the axis. Positive moves it down.
 * @return An array of constraints.
 */
-(NSArray *)positionToCenterOfSuperviewWithXOffset:(float)offset;

/**
 * Position the view to the center with an Y Offset. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param offset Value to move the axis. Positive moves it right.
 * @return An array of constraints.
 */
-(NSArray *)positionToCenterOfSuperviewWithYOffset:(float)offset;

/**
 * Position the view at the exact center of the superview. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToCenterOfSuperview;

/**
 * Aligns the view to the trailing (left) edge of the super view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionAlignTrailingEdgeOfSuperView;

/**
 * Aligns the view to the leading (right) edge of the super view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionAlignLeadingEdgeOfSuperView;

/**
 * Aligns the view to the top edge of the super view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionAlignTopEdgeOfSuperView;

/**
 * Aligns the view to the bottom edge of the super view.The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionAlignBottomEdgeOfSuperView;

/**
 * Aligns the view with a bottom layout guide. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param bottomGuide Bottom layout guide.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignBottomGuide:(id)bottomGuide;

/**
 * Aligns the view with a top layout guide. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param bottomGuide Bottom layout guide.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignTopGuide:(id)topGuide;

/**
 * Aligns the view to the top left corner of the superview. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToTopLeftCornerOfSuperview;

/**
 * Aligns the view to the top right corner of the superview. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToTopRightCornerOfSuperview;

/**
 * Aligns the view to the bottom left corner of the superview. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToBottomLeftCornerOfSuperview;

/**
 * Aligns the view to the bottom right corner of the superview. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToBottomRightCornerOfSuperview;

/**
 * Aligns the view to the top edge of the super view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param padding Space between the two edges.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignTopEdgeOfSuperViewWithPadding:(float)padding;

/**
 * Aligns the view to the bottom edge of the super view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param padding Space between the two edges.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignBottomEdgeOfSuperViewWithPadding:(float)padding;

/**
 * Aligns the view to the trailing edge of the super view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param padding Space between the two edges.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignTrailingEdgeOfSuperViewWithPadding:(float)padding;

/**
 * Aligns the view to the leading edge of the super view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param padding Space between the two edges.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignLeadingEdgeOfSuperViewWithPadding:(float)padding;

/**
 * Aligns every edge of the view to the superview. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToFillSuperView;

/**
 * Aligns every edge of the view to the superview with a padding on each edge. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToFillSuperViewWithPadding:(float)padding;

/**
 * Aligns the view to the top left corner of the superview with a padding. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToTopLeftCornerOfSuperviewWithOffset:(float)offSet;

/**
 * Aligns the view to the top right corner of the superview with a padding. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToTopRightCornerOfSuperviewWithOffSet:(float)offSet;

/**
 * Aligns the view to the bottom left corner of the superview with a padding. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToBottomLeftCornerOfSuperviewWithOffSet:(float)offSet;

/**
 * Aligns the view to the bottom right corner of the superview with a padding. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @return An array of constraints.
 */
-(NSArray *)positionToBottomRightCornerOfSuperviewWithOffSet:(float)offSet;

//position alignmet with other views
/**
 * Align the center X axis to another view center X axis with an offset. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param offset Value to move the axis. Positive moves it right.
 * @return An array of constraints.
 */
-(NSArray *)positionCenterXToCenterXForOtherView:(UIView *)otherView offSet:(float)offset;

/**
 * Align the center Y axis to the super view center Y axis with an offset. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to align.
 * @param offset Value to move the axis. Positive moves it down.
 * @return An array of constraints.
 */
-(NSArray *)positionCenterYToCenterYForOtherView:(UIView *)otherView offSet:(float)offset;

/**
 * Aligns the view to the top edge with another view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to align.
 * @param offset Value to move the axis. Positive moves it right.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignTopEdgesOfOtherView:(UIView *)otherView withPadding:(float)padding;

/**
 * Aligns the view to the trailing edges of another view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 *
 * @param otherView View to align.
 * @param padding Space between the two views.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignTrailingEdgesOfOtherView:(UIView *)otherView withPadding:(float)padding;

/**
 * Aligns the view to the leading edges of another view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 *
 * @param otherView View to align.
 * @param padding Space between the two views.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignLeadingEdgesOfOtherView:(UIView *)otherView withPadding:(float)padding;

/**
 * Aligns the view to the bottom edges of another view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 *
 * @param otherView View to align.
 * @param padding Space between the two views.
 * @return An array of constraints.
 */
-(NSArray *)positionAlignBottomEdgesOfOtherView:(UIView *)otherView withPadding:(float)padding;

/**
 * Positions the view to trail (to the left) of another view with a padding space. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to align.
 * @param padding Space between the two views.
 * @return An array of constraints.
 */
-(NSArray *)positionToTrailOtherView:(UIView *)otherView withPadding:(float)padding;

/**
 * Positions the view to lead (to the right) of another view with a padding space. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to align.
 * @param padding Space between the two views.
 * @return An array of constraints.
 */
-(NSArray *)positionToLeadOtherView:(UIView *)otherView withPadding:(float)padding;

/**
 * Positions the view over another view with a padding space. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to align.
 * @param padding Space between the two views.
 * @return An array of constraints.
 */
-(NSArray *)positionOnTopOfOtherView:(UIView *)otherView withPadding:(float)padding;

/**
 * Positions the view below another view with a padding space. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to align.
 * @param padding Space between the two views.
 * @return An array of constraints.
 */
-(NSArray *)positionBelowOtherView:(UIView *)otherView withPadding:(float)padding;

///This is repeated in other methods
-(NSArray *)positionAlignBottomToTopOfOtherView:(UIView *)otherView __deprecated_msg("Use positionOnTopOfOtherView:withPadding: instead");

///This is repeated in other methods
-(NSArray *)positionAlignTopToBottomOfOtherView:(UIView *)otherView __deprecated_msg("Use positionBelowOtherView:withPadding: instead");

/**
 * Gets the width constraint of the view.
 * @author Francisco Magdaleno
 * @return The width constraint.
 */
-(NSLayoutConstraint *)widthConstraint;

/**
 * Gets the height constraint of the view.
 * @author Francisco Magdaleno
 * @return The height constraint.
 */
-(NSLayoutConstraint *)heightConstraint;

/**
 * Creates the constraint to set the view to the same width as another view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to match the width.
 * @return An array of constraints.
 */
-(NSArray *)sameWidthWithOtherView:(UIView *)otherView;

/**
 * Creates the constraint to set the view to the same height as another view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to match the height.
 * @return An array of constraints.
 */
-(NSArray *)sameHeightInWithOtherView:(UIView *)otherView;

/**
 * Creates the constraint to set the view to the same width and height as another view. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to match the height.
 * @return An array of constraints.
 */
-(NSArray *)sameWidthAndHieghtWithOtherView:(UIView *)otherView;

/**
 * Creates the constraint to set the view to the same width as another view with a multiplier ratio. The constraints must be added to the superview.
 * @author Francisco Magdaleno
 * @param otherView View to match the height.
 * @param ratio Multiplier ratio.
 * @return An array of constraints.
 */
-(NSArray *)sameWidthWithOtherView:(UIView *)otherView withRatio:(float)ratio;

@end

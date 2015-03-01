//
//  ProductDetailsTVC.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "ProductDetailsTVC.h"

//controller
#import "AppDelegate.h"
//classes
#import "ProductModel.h"
#import "CustomButtons.h"
#import "Review.h"
#import "UIView+LayoutConstraints.h"
//views
#import "ProductDetailHeaderView.h"

//cells
#import "ProductReviewCell.h"
#import "SearchManager.h"
#import "RecommendationCollectionModel.h"

@interface ProductDetailsTVC ()

///Table view header.
@property (nonatomic,strong) ProductDetailHeaderView *headerView;
///Table view datasource for reviews
@property (nonatomic,strong) NSArray *reviews;
///Prototype cell to calculate height of the cell
@property (nonatomic,strong) ProductReviewCell *prototypeCell;
///Buy button
@property (nonatomic,strong) UIButton *buyButton;
@end

@implementation ProductDetailsTVC


#define HEADER_HEIGHT 460

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backDownArrowButton];
    self.navigationItem.rightBarButtonItem = [CustomButtons imageButtonWithName:@"share"
                                                                  forController:self
                                                                       selector:@selector(sharePressed)];
    //register the cell
    NSString *identifier = NSStringFromClass([ProductReviewCell class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    [self createBuyButton];
    
}

-(void)queryRecommendations
{
    __weak ProductDetailsTVC* weakSelf = self;
    [SearchManager queryRecommendationsForProduct: [NSString stringWithFormat:@"%@",self.product.sku ]
                                          success:^(id responseObject) {
                                              
                                              RecommendationCollectionModel* searchResults = (RecommendationCollectionModel*) responseObject;
                                              NSLog(@"output : %@" , searchResults.toJSONString);
                                              
                                              [weakSelf createReviewsWithRecommendationCollection: searchResults];
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  
                                                  [weakSelf.tableView reloadData];
                                                  
                                              });
                                          } failure:^(NSError *error) {
                                              NSLog(@"error: %@", error);
                                          }];

    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self queryRecommendations];
//    [self.tableView reloadData];
//    [self createFakeReviews];
}

-(void)createBuyButton {
    //remove this contraint to detach the bottom of the table view to the bottom of the view and add another one.
    [self.view removeConstraint:self.bottomConstraint];
    [self.view addSubview:self.buyButton];
    [self.view addConstraints:[self.buyButton positionAlignBottomEdgeOfSuperView]];
    [self.view addConstraints:[self.buyButton positionAlignTrailingEdgeOfSuperView]];
    [self.view addConstraints:[self.buyButton positionAlignLeadingEdgeOfSuperView]];
    [self.view addConstraints:[self.buyButton positionBelowOtherView:self.tableView withPadding:0]];
    
    [self.buyButton positionHeight:50];
    
}

- (NSString*)dateToString:(NSDate*) date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM dd, yyyy"];
    return [format stringFromDate:date];
}

-(void)createFakeReviews {
    
    NSMutableArray *mutableReviews = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        Review *review = [Review reviewWithInfo:@{REVIEW_FRIEND_NAME_KEY:@"Paco",
                                                  REVIEW_CREATION_DATE_KEY:@"24/12/2015",
                                                  REVIEW_TEXT_KEY:@"I have five of these!"}];
        [mutableReviews addObject:review];
    }
    self.reviews = mutableReviews;
}


-(void)createReviewsWithRecommendationCollection:(RecommendationCollectionModel*) collection {
    
    NSArray* comments = collection.comment;
    NSMutableArray *mutableReviews = [NSMutableArray array];
    for (NSString* comment in collection.comment) {
        Review *review = [Review reviewWithInfo:@{REVIEW_FRIEND_NAME_KEY:@"Friend",
                                                  REVIEW_CREATION_DATE_KEY:[self dateToString: [NSDate date]],
                                                  REVIEW_TEXT_KEY:comment}];
        [mutableReviews addObject:review];

    }
    self.reviews = mutableReviews;
}

-(void)setReviews:(NSArray *)reviews {
    if (_reviews != reviews) {
        _reviews = reviews;
        [self.tableView reloadData];
    }
}

-(void)setProduct:(ProductModel *)product {
    if (_product != product) {
        _product = product;
        self.navigationItem.title = product.name ? product.name : @"Product";
        [self.tableView reloadData];
    }
}

-(UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_buyButton setBackgroundColor:BLUE_TINT_COLOR];
        [_buyButton.titleLabel setFont:[UIFont fontWithName:FONT_REGULAR size:20]];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyButton setTitle:@"Buy $35" forState:UIControlStateNormal];
        [_buyButton addTarget:self
                       action:@selector(buyButtonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButton;
}


- (IBAction)buyButtonPressed:(UIButton *)sender {
    
    [[UIApplication sharedApplication] openURL:self.product.url];
}


-(ProductReviewCell *)prototypeCell {
    if (!_prototypeCell) {
        _prototypeCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ProductReviewCell class])
                                                        owner:self
                                                      options:nil]lastObject];
    }
    return _prototypeCell;
}

-(ProductDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ProductDetailHeaderView class])
                                                    owner:self
                                                  options:nil]lastObject];

        [_headerView configureWithProduct:self.product];
    }
    return _headerView;
}

#pragma mark tableview datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    Review *review = self.reviews[indexPath.row];
    [self.prototypeCell configureCellWithReview:review];
    [self.prototypeCell setNeedsLayout];
    [self.prototypeCell layoutIfNeeded];
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEADER_HEIGHT;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reviews.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([ProductReviewCell class]);
    ProductReviewCell *cell = (ProductReviewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    Review *review = self.reviews[indexPath.row];
    [cell configureCellWithReview:review];
    return cell;
}

#pragma mark buttons methods
-(void)sharePressed {
    NSString *string = [NSString stringWithFormat:@"I want to buy %@ today! What do you think?",self.product.name];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                        initWithActivityItems:@[string,self]
                                                        applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES
                     completion:nil];

}

-(void)buyPressed {
    ///buy actions
}

@end

//
//  BrowseVC.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "BrowseVC.h"

//classes
#import "UIView+LayoutConstraints.h"
#import "PickerController.h"
#import "Product.h"
//controllers
#import "AppDelegate.h"
#import "ProductDetailsTVC.h"
//cells
#import "ProductCell.h"

#import "SearchManager.h"
#import "SearchResultsModel.h"
#import "MacysSearchResultModel.h"

@interface BrowseVC () <PickerControllerDelegate>

///Table view header view with the categories.
@property (nonatomic,strong) UIView *headerView;
///Table view datasource of products.
@property (nonatomic,strong) NSArray *products;
///Picker for categories
@property (nonatomic,strong) PickerController *pickerController;

//Search results
@property (nonatomic, strong) SearchResultsModel* searchResults;
@property (nonatomic, strong) MacysSearchResultModel* macyssearchResults;

//For Store
@property (nonatomic, strong) NSString* selectedStore;
@end

@implementation BrowseVC
#define HEADER_HEIGHT 60
#define CELL_HEIGHT 275
- (void)viewDidLoad {
    [super viewDidLoad];
    [self backArrownButton];
    //register cell to tableview
    NSString *identifier = NSStringFromClass([ProductCell class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    [self startFakeItems];

    //Send Real query to store
    self.searchResults = nil;
    self.selectedStore = @"macys";
    [self searchQueryToStore: self.selectedStore];
}

-(void)startFakeItems {
    NSMutableArray *mutableProducts = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        Product *product = [Product productWithInfo:@{PRODUCT_ID_KEY:@"fakeid",
                                                      PRODUCT_NAME_KEY:@"Shoes",
                                                      PRODUCT_IMAGE_URL_KEY:@"shoes",
                                                      PRODUCT_STORE_KEY:@"Macy's",
                                                      PRODUCT_PRICE_KEY:@"32"}];
        [mutableProducts addObject:product];
    }
    self.products = mutableProducts;
}

-(void)setProducts:(NSArray *)products {
    if (_products != products) {
        _products = products;
        [self.tableView reloadData];
    }
}

-(void)setCategory:(NSString *)category {
    if (_category != category) {
        _category = category;
        self.navigationItem.title = self.category;
    }
}

-(UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                              0,
                                                              CGRectGetWidth(self.tableView.frame),
                                                              HEADER_HEIGHT)];
        [_headerView setBackgroundColor:[UIColor whiteColor]];
        //add a button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setBackgroundColor:BLUE_TINT_COLOR];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:FONT_REGULAR size:20]];
        [button addTarget:self
                   action:@selector(headerPressed)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Switch categories" forState:UIControlStateNormal];
        button.layer.cornerRadius = 3.0f;
        button.clipsToBounds = YES;
        //add the button to the header
        [_headerView addSubview:button];
        [_headerView addConstraints:[button positionToFillSuperViewWithPadding:8]];
    }
    return _headerView;
}

#pragma mark table view datasource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return HEADER_HEIGHT;
    }
    return 0.001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.searchResults == nil)
    {
        return self.products.count;
    }
    else{
        NSLog(@"count : %lu",self.searchResults.products.count  );
        return self.searchResults.products.count ;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([ProductCell class]);
    ProductCell *cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier
                                              owner:self
                                            options:nil]lastObject];
    }

 
    if(self.searchResults != nil)
    {
        NSLog(@"indexpathrow: %lu", indexPath.row);
        ProductModel* product = [self.searchResults.products objectAtIndex:indexPath.row];
        
        if(product != nil)
        {
            [cell configureWithProductModel:product];
            
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Product *product = self.products[indexPath.row];
    [self showProductDetails:product];
}

#pragma mark button methods
-(void)headerPressed {
    [self showPickerController];
}

#pragma mark picker controller methods
-(PickerController *)pickerController {
    if (!_pickerController) {
        _pickerController = [PickerController createPickerControllerWithDelegate:self];
    }
    return _pickerController;
}

#pragma mark show views methods
-(void)showPickerController {
    //add it in the application delegate window so it's not covered by the tab bar
    [self.pickerController showPickerInView:[[UIApplication sharedApplication].delegate window]
                                   withInfo:@[@{PICKER_ID_KEY:@"first_key",
                                                PICKER_VALUE_KEY:@"First"},
                                              @{PICKER_ID_KEY:@"second_key",
                                                PICKER_VALUE_KEY:@"Second"},
                                              @{PICKER_ID_KEY:@"third_key",
                                                PICKER_VALUE_KEY:@"Third"}]
                                layoutGuide:nil];
   
}

-(void)showProductDetails:(Product *)product {
    ProductDetailsTVC *controller = [[ProductDetailsTVC alloc]initWithTableViewStyle:UITableViewStyleGrouped];
    [controller setProduct:product];
    UINavigationController *navcontroller = [[UINavigationController alloc]initWithRootViewController:controller];
    navcontroller.navigationBar.translucent = NO;
    [navcontroller.navigationBar setBarTintColor:[UIColor whiteColor]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:navcontroller animated:YES completion:nil];
    });

}

#pragma mark picker controller delegate methods
-(void)pickerController:(PickerController *)sender didSelectValue:(NSDictionary *)selectedValue {
    self.category = selectedValue[PICKER_VALUE_KEY];
    _pickerController = nil;
}

-(void)pickerControllerDidCancel:(PickerController *)sender {
    _pickerController = nil;
}


#pragma Search methods

-(void) searchQueryToStore: (NSString*)toStore
{
    
    [SearchManager searchForProduct:nil fromStore:toStore filter:nil success:^(id responseObject) {

        SearchResultsModel* searchResults = (SearchResultsModel*) responseObject;
        NSLog(@"ouput : %@" , searchResults.toJSONString);
        self.searchResults = searchResults;
        /*
        if([toStore isEqualToString:@"bestbuy"])
        {
            SearchResultsModel* searchResults = (SearchResultsModel*) responseObject;
            NSLog(@"ouput : %@" , searchResults.toJSONString);
            self.searchResults = searchResults;
        }else if([toStore isEqualToString:@"macys"]){
            MacysSearchResultModel* searchResults = (MacysSearchResultModel*) responseObject;
            NSLog(@"ouput : %@" , searchResults.toJSONString);
            self.macyssearchResults = searchResults;
            
        }
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
    
}


- (void) callReloadData
{
    if ([NSThread isMainThread]) {
        @synchronized (self.tableView) {
            [self.tableView reloadData];
        }
    } else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }
}


@end

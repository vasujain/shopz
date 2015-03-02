//
//  Liked.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "LikedVC.h"
#import "ProductCell.h"
#import "ProductModel.h"
#import "SearchResultsModel.h"
@interface LikedVC ()

@property (nonatomic,strong) SearchResultsModel *searchResults;
@end
@implementation LikedVC
#define CELL_HEIGHT 275
-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Reviewed";
    //register cell to tableview
    NSString *identifier = NSStringFromClass([ProductCell class]);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    [self createFakeData];
}

-(void)createFakeData {
    //get jobs info json
    NSString *jobsPath = [[NSBundle mainBundle] pathForResource:@"DummyProducts" ofType:@"json"];
    NSData *jobsData = [NSData dataWithContentsOfFile:jobsPath];
    NSDictionary *jobsInfo = [NSJSONSerialization JSONObjectWithData:jobsData
                                                        options:kNilOptions
                                                          error:nil];

    SearchResultsModel* results = [[SearchResultsModel alloc] initWithDictionary:jobsInfo error:nil];
    NSLog(@"response String %@ ", [results toJSONString]);
    self.searchResults = results;


}

-(void)setSearchResults:(SearchResultsModel *)searchResults {
    if (_searchResults != searchResults) {
        _searchResults = searchResults;
        [self.tableView reloadData];
    }
}

#pragma mark table view datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.products.count ;
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


@end

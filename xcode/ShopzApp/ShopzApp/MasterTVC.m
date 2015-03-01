//
//  MasterTVC.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "MasterTVC.h"
#import "UIView+LayoutConstraints.h"

@interface MasterTVC () 
@property (nonatomic) UITableViewStyle tableViewStyle;
@end

@implementation MasterTVC

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        self.tableViewStyle = style;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow
                                  animated:YES];

}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero
                                                 style:self.tableViewStyle];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor whiteColor]];
    }
    return _tableView;
}

-(void)createTableView {
    [self.view addSubview:self.tableView];
    [self.view addConstraints:[self.tableView positionAlignTopEdgeOfSuperView]];
    [self.view addConstraints:[self.tableView positionAlignLeadingEdgeOfSuperView]];
    [self.view addConstraints:[self.tableView positionAlignTrailingEdgeOfSuperView]];
    self.bottomConstraint = [[self.tableView positionAlignBottomEdgeOfSuperView]lastObject];
    [self.view addConstraint:self.bottomConstraint];
}

#pragma mark tableview datasource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

//to be overriden
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

//this must be overriden or will crash
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}



@end

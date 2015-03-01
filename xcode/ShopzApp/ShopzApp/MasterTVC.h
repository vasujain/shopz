//
//  MasterTVC.h
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "MasterVC.h"

@interface MasterTVC : MasterVC <UITableViewDataSource, UITableViewDelegate>
///Main table view
@property (nonatomic,strong) UITableView *tableView;
///Bottom tableview constraint so we can remover it later.
@property (nonatomic,strong) NSLayoutConstraint *bottomConstraint;

/**
 * Initialize with a certain type of table view style
 * @author Francisco Magdaleno
 * @param style Table view style.
 * @return a Master TVC instance
 */
- (instancetype)initWithTableViewStyle:(UITableViewStyle)style;


@end

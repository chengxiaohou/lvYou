//
//  StoreVC.m
//  lvYou
//
//  Created by 小熊 on 2018/12/10.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "StoreVC.h"

@interface StoreVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *datas;

@end

@implementation StoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:@"装备攻略" leftText:nil rightTitle:nil showBackImg:NO];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _datas = @[@{@"image":@"zb_1",@"name":@"背包o攻略"},@{@"image":@"zb_2",@"name":@"自驾野营"},@{@"image":@"zb_3",@"name":@"帐篷o攻略"}];
    [_tableView reloadData];
    
}



#pragma mark - ......::::::: UITableViewDataSource :::::::......

#pragma mark TV段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark TV行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    NSDictionary *dic = _datas[indexPath.row];
    cell.image1.image = [UIImage imageNamed:dic[@"image"]];
    cell.label1.text = dic[@"name"];
    return cell;
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [ShoppingVC showTheShoppingVC:indexPath.row + 1];
    
}



@end

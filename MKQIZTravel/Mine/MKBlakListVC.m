//
//  BlakListVC.m
//  lvYou
//
//  Created by 小熊 on 2018/12/16.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "MKBlakListVC.h"

@interface MKBlakListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet EETableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@end

@implementation MKBlakListVC
+ (void)showTheBlakListVC
{
    MKBlakListVC *black = [Worker MainSB:@"BlakListVC"];
    [Worker showVC:black];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.nav setTitle:@"黑名单" leftText:nil rightTitle:nil showBackImg:YES];
    self.nav.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:ThemeImageColor]];
    NSArray *da = [UDManager getMyBlackList];
    _datas = [[NSMutableArray alloc] initWithArray:da];
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
    return _datas.count;
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    NSDictionary *dic = _datas[indexPath.row];
    SetImageViewImageWithURL_C(cell.image1, dic[@"headImg"], IconHolderName);
    cell.label1.text = dic[@"userName"];
    cell.btn1.layer.cornerRadius = 5.0;
    [cell.btn1 addTarget:self action:@selector(onCancleTheBlakList:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn1.tag = indexPath.row;
    return cell;
}

- (void)onCancleTheBlakList:(UIButton *)btn
{
    if (_datas.count > 0) {
        [_datas removeObjectAtIndex:btn.tag];
       // [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshBlack" object:nil];
        [_tableView reloadData];
    }
    
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end

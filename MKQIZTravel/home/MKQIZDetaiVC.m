//
//  DetaiVC.m
//  lvYou
//
//  Created by 小熊 on 2018/11/19.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "MKQIZDetaiVC.h"

@interface MKQIZDetaiVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet EETableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *scBtn;

@end

@implementation MKQIZDetaiVC
+(void)showTheDetaiVC:(NSArray *)datas andTheName:(NSString *)name
{
    MKQIZDetaiVC *detail = [Worker MainSB:@"DetaiVC"];
    detail.datas = datas;
    detail.titleName = name;
    [Worker showVC:detail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:_titleName leftText:nil rightTitle:nil showBackImg:YES];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return self.datas.count;
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    
    NSDictionary *dic = _datas[indexPath.row];
    cell.image1.image = [UIImage imageNamed:dic[@"image"]];
    cell.label1.text = dic[@"content"];
    return cell;
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)pingJiaBtn:(UIButton *)sender {
    
    [MKQIZAdviceVC showTheAdviceVC:200];
}

#pragma mark 收藏
- (IBAction)shouCangBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [MBProgressHUD showMessag:@"收藏成功" toView:Window];
        [_scBtn setBackgroundImage:[UIImage imageNamed:@"order_star_evaluationed"] forState:UIControlStateNormal];
    }
    else{
       [MBProgressHUD showMessag:@"取消成功" toView:Window];
       [_scBtn setBackgroundImage:[UIImage imageNamed:@"order_star_evaluation"] forState:UIControlStateNormal];
    }
}
- (IBAction)juBaoBtn:(UIButton *)sender {
    [MBProgressHUD showMessag:@"感谢您的举报，我们会立马核实" toView:Window];
}

@end

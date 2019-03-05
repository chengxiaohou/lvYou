//
//  MineVC.m
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/2.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "MKMineVC.h"

@interface MKMineVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet EETableView *tableView;

@property (nonatomic,strong) NSArray *datas;
@end

@implementation MKMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 21)];
    footerView.backgroundColor = BGGreyColor;
    _tableView.tableFooterView = footerView;
    

    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self layoutTheData];
   // [self configMJRefresh];
    KUserAddNewNotiWithSelector(@selector(onRefrshInfo:));
 
}



#pragma mark 刷新个人信息
- (void)onRefrshInfo:(NSNotification *)note
{
    [self layoutTheData];
}

- (void)layoutTheData
{
    //普通用户
   
    _datas = @[
               @{@"image":@"mine_ic4",@"name":@"意见反馈"},
               @{@"image":@"mine_ic2",@"name":@"分享"},
               @{@"image":@"mine_ic5",@"name":@"设置"},
               @{@"image":@"mine_ic6",@"name":@"我的黑名单"},
               @{@"image":@"mine_ic6",@"name":@"客服咨询"},
               ];
    [_tableView reloadData];
    
}









#pragma mark 个人信息
- (IBAction)toPersonVC:(id)sender {
    if (!USER.isLogin) {
        [Worker gotoLoginIfNotLogin];
    }
    else
    {
     [MKPersonInfoVC showThePersonInfoVC];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ......::::::: UITableViewDataSource :::::::......

#pragma mark TV段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma mark TV行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
    return _datas.count;
    }
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.label5.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
        //cell.label1.text = [UDManager getUserName];
        cell.label2.text = USER.userName;
      
        cell.label6.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
      
        
        if (!USER.isLogin ) {
            cell.label1.hidden = YES;
            cell.label2.hidden = YES;
            cell.label3.hidden = YES;
            cell.label4.hidden = YES;
//            for (UIImageView *imageView in cell.starImg) {
//                imageView.hidden = YES;
//            }
   
            cell.btn2.hidden = NO;
            cell.image1.image = [UIImage imageNamed:IconHolderName];
            cell.label5.text = @"0";
            cell.label6.text = @"0";
            [cell.btn2 addTarget:self action:@selector(onLogon) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.label1.hidden = NO;
            cell.label2.hidden = NO;
            cell.label3.hidden = NO;
            cell.label4.hidden = NO;
          
          
            cell.btn2.hidden = YES;
            SetImageViewImageWithURL_C(cell.image1, USER.headImg, IconHolderName);
          
          
            
        }
        
     
        
     
        
        
        return cell;
    }
    else
    {
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        NSDictionary *dic = _datas[indexPath.row];
        [cell.btn1 setImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
        cell.label1.text = dic[@"name"];
        return cell;
    }
    
}


- (void)onLogon
{
    [Worker gotoLoginIfNotLogin];
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    if (indexPath.section > 0) {
        if (USER.isLogin) {
        NSInteger tag = indexPath.row;
        switch (tag) {
            case 0:
                
                    //意见反馈
                    [MKAdviceVC showTheAdviceVC:100];
                
                
              
                break;
            case 1:
                //分享有礼
                [self share:@"http://weixin.sdhui.net/commonMechanicAgree"];
          
//                    WebVC *web = [[WebVC alloc] init];
//                    web.hidesBottomBarWhenPushed = YES;
//                    web.url = @"http://weixin.sdhui.net/commonMechanicAgree";//[NSString stringWithFormat:@"weixin.sdhui.net/commonAgreementStore?id=%@",USER.ID];
//                    web.titleName = @"我的签约";
//                    [self.navigationController pushViewController:web animated:YES];
                
                break;
            case 2:
                //设置
                [MKSettingVC showTheSettingVC];
                break;
            case 3:
                //我的黑名单
                [MKBlakListVC showTheBlakListVC];
                break;
            case 4:
                //客服咨询
                [self dianHuanYuYue:@"07556677"];
                break;
            case 5:
                
                break;
            case 6:
                
                break;
                
            default:
                break;
            }
      // }
        }
        else{
            [Worker gotoLoginIfNotLogin];
        }
        
    }
}

#pragma mark 电话预约
- (void)dianHuanYuYue:(NSString *)phone
{
    NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
    [self.view addSubview:callWebview];
}

#pragma mark 分享
- (void)share:(NSString *)url
{
    //分享的标题
    NSString *textToShare = @"旅游攻略";
    //分享的图片
    UIImage *imageToShare = [UIImage imageNamed:@"mine_ic4"];
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:url];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}


@end

//
//  ZiXunVC.m
//  lvYou
//
//  Created by 小熊 on 2018/11/20.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "GLZiXunVC.h"

@interface GLZiXunVC ()<UITableViewDelegate,UITableViewDataSource,NavViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datas;
@end

@implementation GLZiXunVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:@"旅游动态" leftText:nil rightTitle:@"发布" showBackImg:NO];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.nav.delegate = self;
    [self getTheDatas];
    [self postTheDatas];
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refrshTheDatas:) name:@"refreshBlack" object:nil];
    
}
- (void)right
{
    [GLMyDongTaiVC showTheMyDongTaiVC];
}

- (void)postTheDatas
{
    
    [self get1_URL:@"https://open.qyer.com/app/api/fetch" parameters:nil success:^(NSDictionary *dic) {
        
    }];
}
- (void)getTheDatas
{
    
    NSArray  *da = @[
               @{@"title":@"波斯1397，伊朗2018，3100公里自驾纪行（中部经典五城，西线两伊边境，美索不达米亚平原深埋的古老文明）",@"titleImage":@"https://pic.qyer.com/album/user/2995/22/Q0BcRxgFY0w/index/300_200",@"url":@"https://m.qyer.com/bbs/thread-3065301-1.html?source=app&client_id=&track_user_id=&track_deviceid=&track_app_version=",@"headImg":@"https://pic.qyer.com/avatar/000/36/49/19/200?v=1433913285",@"userName":@"枯藤",@"date":@"2017-9-02",@"dianZan":@"12",@"comment":@"10"},
               @{@"title":@"穿过地球来看你 | 阿根廷的十日碎碎念",@"titleImage":@"https://pic.qyer.com/album/user/3058/47/QklQSh4AYUA/index/300_200",@"url":@"https://m.qyer.com/bbs/thread-3090925-1.html?source=app&client_id=&track_user_id=&track_deviceid=&track_app_version=",@"headImg":@"https://pic.qyer.com/avatar/005/52/40/11/200?v=1536196633",@"userName":@"刘行少侠",@"publish_time":@"",@"dianZan":@"37",@"comment":@"8"},
               @{@"title":@"又一个四年，这次我们找到一个环游中东的好借口！（2019亚洲杯观赛指南/如何定制国际赛事旅游计划）",@"titleImage":@"https://pic.qyer.com/album/user/3053/88/QklQQRIPZ0g/index/300_200",@"url":@"https://m.qyer.com/bbs/thread-3089493-1.html?source=app&client_id=&track_user_id=&track_deviceid=&track_app_version=",@"headImg":@"https://pic.qyer.com/avatar/006/75/56/29/200?v=1543953351",@"userName":@"磨人哒小栗砸",@"publish_time":@"2017-5-12",@"dianZan":@"63",@"comment":@"4"},
               @{@"title":@"文艺与自然|这里，有一份小众釜山待签收",@"titleImage":@"https://pic.qyer.com/album/user/3047/32/QklRRRkFY0o/index/300_200",@"url":@"https://m.qyer.com/bbs/thread-3086786-1.html?source=app&client_id=&track_user_id=&track_deviceid=&track_app_version=",@"headImg":@"https://pic.qyer.com/avatar/009/82/00/73/200?v=1514077263",@"userName":@"蝈蝈小姐530",@"publish_time":@"2018-1-2",@"dianZan":@"157",@"comment":@"5"},
               @{@"title":@"【闲摄东伦敦】带你走进伦敦东区，颠覆刻板印象中的“英·伦·风·格",@"titleImage":@"https://pic.qyer.com/album/user/3061/57/QklTQx8AZUA/index/300_200",@"url":@"https://m.qyer.com/bbs/thread-3065301-1.html?source=app&client_id=&track_user_id=&track_deviceid=&track_app_version=",@"headImg":@"https://pic.qyer.com/avatar/000/20/07/95/200?v=1534052075",@"userName":@"茱妮",@"publish_time":@"2018-02-01",@"dianZan":@"28",@"comment":@"10"},
               @{@"title":@"#我要成为精华作者#+2018年国庆意大利完美之旅（托斯卡纳+多洛米蒂+音乐会+滑翔伞+跑车+小众景点+奥特莱斯）",@"titleImage":@"https://pic.qyer.com/album/user/2988/22/Q0BdShgFY08/index/300_200",@"url":@"https://m.qyer.com/bbs/thread-3063063-1.html?source=app&client_id=&track_user_id=&track_deviceid=&track_app_version=",@"headImg":@"https://pic.qyer.com/avatar/001/04/85/06/200?v=1542689309",@"userName":@"咔蜜西",@"publish_time":@"2018-01-20",@"dianZan":@"150",@"comment":@"80"},
               @{@"title":@"【逆光英国】电影与摇滚乐中的大不列颠｜伦敦、苏格兰与利物浦的笔记＋Vlog",@"titleImage":@"https://pic.qyer.com/album/user/2990/93/Q0BcQhMEYUs/index/300_200",@"url":@"https://m.qyer.com/bbs/thread-3092846-1.html?source=app&client_id=&track_user_id=&track_deviceid=&track_app_version=",@"headImg":@"https://pic.qyer.com/avatar/009/10/94/99/200?v=1516673371",@"userName":@"逆光行纪",@"publish_time":@"2018-03-20",@"dianZan":@"23",@"comment":@"0"},
               @{@"title":@"【暴走女第八季】澳门+暹粒+甲米+曼谷4城混搭de穿越玩儿法！",@"titleImage":@"https://pic.qyer.com/album/user/3051/48/QklQQx4PY0k/index/300_200",@"url":@"https://m.qyer.com/bbs/thread-3087493-1.html?source=app&client_id=&track_user_id=&track_deviceid=&track_app_version= ",@"headImg":@"https://pic.qyer.com/avatar/003/69/56/57/200?v=1399532427",@"userName":@"钦蛋",@"publish_time":@"2018-02-03",@"dianZan":@"150",@"comment":@"80"},
               @{@"title":@"#我要成为精华作者#+2018年国庆意大利完美之旅（托斯卡纳+多洛米蒂+音乐会+滑翔伞+跑车+小众景点+奥特莱斯）",@"titleImage":@"https://pic.qyer.com/album/user/3058/42/QklQSh4FaU4/index/300_200",@"url":@"https://m.qyer.com/bbs/thread-3092126-1.html?source=app&client_id=&track_user_id=&track_deviceid=&track_app_version=",@"headImg":@"https://pic.qyer.com/avatar/005/44/95/36/200?v=1539409886",@"userName":@"飘来荡去宝宝酱",@"publish_time":@"2018-04-03",@"dianZan":@"42",@"comment":@"62"},
               
               ];
    
    _datas = [[NSMutableArray alloc] init];
    [_datas addObjectsFromArray:da];
    
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
    SetImageViewImageWithURL_C(cell.image1, dic[@"titleImage"], PlaceHolderName);
    SetImageViewImageWithURL_C(cell.image2, dic[@"headImg"], IconHolderName);
    cell.label1.text = dic[@"title"];
    cell.label2.text = dic[@"publish_time"];
    cell.label3.text = dic[@"userName"];
    
    [cell.btn1 setTitle:dic[@"comment"] forState:UIControlStateNormal];
    [cell.btn1 setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    [cell.btn2 setTitle:dic[@"dianZan"] forState:UIControlStateNormal];
    [cell.btn2 setImage:[UIImage imageNamed:@"dianzhan"] forState:UIControlStateNormal];
    [cell.btn3 addTarget:self action:@selector(juBaoBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn4.tag = indexPath.row;
    [cell.btn4 addTarget:self action:@selector(addBlackList:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_datas.count > 0) {
        NSDictionary *dic = _datas[indexPath.row];
        [GLZXDeatilVC showTheZXDeatilVC:dic[@"url"] andTheName:@"" andTheDiff:200 andTheDic:dic];
    }
}
- (void)juBaoBtn:(UIButton *)sender {
    
    [MBProgressHUD showMessag:@"感谢您的举报，我们审核人员将立马处理" toView:Window];
}

#pragma mark 加入黑名单
- (void)addBlackList:(UIButton *)sender {
    MJWeakSelf;
    [self showFunctionAlertWithTitle:nil message:@"加入黑名单后，您将收不到该用户的任何动态，确定将该用户加入黑名单吗？" functionName:@"确定" Handler:^{
        
        NSArray *arr = [UDManager getMyBlackList];
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in arr) {
            
            [list addObject:dic];
        }
        [list addObject:weakSelf.datas[sender.tag]];
        [UDManager postMyBlackLias:list];
        [weakSelf.datas removeObjectAtIndex:sender.tag];
        [weakSelf.tableView reloadData];
        
    }];
}

@end

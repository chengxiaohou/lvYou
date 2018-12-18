//
//  ShoppingVC.m
//  lvYou
//
//  Created by 小熊 on 2018/12/10.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "ShoppingVC.h"
#define CollectWID 170
@interface ShoppingVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) NSArray *MJDatas;
@end

@implementation ShoppingVC
+ (void)showTheShoppingVC:(NSInteger)diff
{
    ShoppingVC *shopping = [Worker MainSB:@"ShoppingVC"];
    shopping.diff = diff;
    [Worker showVC:shopping];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:@"商品展示" leftText:nil rightTitle:nil showBackImg:YES];
    if (!_flowLayout) {
        _flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    
    
    _collectionView.collectionViewLayout = _flowLayout;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.scrollEnabled = NO;
    [self getTheDatas];
}

- (void)getTheDatas
{
  
    if (_diff == 1) {
     
    _MJDatas = @[
         @{@"image":@"https://api2.lis99.com/upload/app_goods/6/b/b/6b8fafbd0ccee4d88ba0304b846c717b.jpg",@"des":@"Pacsafe 防盗超轻 双肩背包 15L Slingsafe LX450",@"sold":@"销量 20",@"price":@"￥639",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001057_d.html"},
        @{@"image":@"https://api2.lis99.com/upload/app_goods/7/8/f/78a54f3d0c66d4a1b66cc62c3140444f.jpg",@"des":@"Pacsafe 防盗超轻 双肩背包 15L Slingsafe LX450",@"sold":@"销量 10",@"price":@"￥639",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001179_d.html"},
         @{@"image":@"https://api2.lis99.com/upload/app_goods/4/6/c/4603d401ea0836eecd70b18f293f11fc.jpg",@"des":@"ARC'TERYX 始祖鸟 负重徒步登山背包 Altra 65",@"sold":@"销量 3",@"price":@"￥3096",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS0000123_d.html"},
         @{@"image":@"https://api2.lis99.com/upload/app_goods/4/f/3/1238_G_1521747426399.jpg",@"des":@"Pacsafe 超轻防盗 双肩背包 16L Slingsafe LX350",@"sold":@"销量 20",@"price":@"￥538",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001056_d.html"},
        ];
    
    }
    else if (_diff == 2){
    
    _MJDatas = @[
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/c/6/1/c6e3f5a45a0112a0adb53d8373fb63c1.jpg",@"des":@"ARC'TERYX 始祖鸟 轻量速干 短袖T恤 男 Cormac 15518",@"sold":@"销量 100",@"price":@"￥496",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS0000777_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/3/7/8/37aa0fa1c7fce84a470c44e26395a758.jpg",@"des":@"NITECORE奈特科尔 磁环调光 战术远射手电筒 SRT7GT",@"sold":@"销量 120",@"price":@"￥639",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001232_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/4/9/6/4963fd82ff1bc8140092ea563d4d0db6.jpg",@"des":@"NITECORE奈特科尔 便携USB充电 强光手电筒 1000流明 MH10",@"price":@"￥368",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001227_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/1/1/8/11b7d261f3a5aae943a30680fde45ee8.jpg",@"des":@"NITECORE奈特科尔 USB充电 金属钥匙扣 手电筒 TINI",@"sold":@"销量 30",@"price":@"￥179",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001223_d.html"},
                 
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/2/5/e/2554bc2651fe9ef11a5e6a52b63f44ee.jpg",@"des":@"ASICS亚瑟士 缓冲减震 跑步鞋 女 Gel-Nimbus 20 T850N",@"sold":@"销量 4",@"price":@"￥1088",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001543_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/5/8/9/587a6014e75892ad3f92325f7a5d9699.jpg",@"des":@"ASICS亚瑟士 稳定透气 跑步鞋 男 Gel-Kayano 24 T749N",@"sold":@"销量 8",@"price":@"￥179",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001539_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/5/6/f/929_G_1521078234003.jpg",@"des":@"ARC'TERYX 始祖鸟 透气耐磨 速干T恤 男 Ether 12529",@"sold":@"销量 18",@"price":@"￥449",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS0000775_d.html"},
                 ];
    
    }
    else if (_diff == 3){
    
    
    _MJDatas = @[
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/e/a/1/eac1b0a57aeb5771e44adf7693911de1.png",@"des":@"山力士 CC-MUSIC",@"sold":@"销量 30",@"price":@"￥246",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001254_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/3/a/4/3a7ac314fdad7a69e03e4a9e5dc1b984.jpg",@"des":@"吊床 单人/双人 pro",@"sold":@"销量 150",@"price":@"￥299",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS0000859_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/7/e/2/7e7a42cb1abf36aa5985e1fa0d5c7cf2.jpg",@"des":@"雪峰 户外悬挂式 营地灯",@"sold":@"销量 10",@"price":@"￥818",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS000048_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/f/8/e/f8088c3c000fc47d53084a90011874fe.jpg",@"des":@"山脉人形睡袋 200克纺丝绵 露营出差开车旅行",@"sold":@"销量 30",@"price":@"￥199",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS0000153_d.html"},
                 
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/f/c/3/fce190a44db67e607fa1b06456c2afe3.jpg",@"des":@"专业户外帐篷 4人 冷山4",@"sold":@"销量 144",@"price":@"￥710",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS0000222_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/3/d/9/3d65487881e452e57500ba27eb08d289.jpg",@"des":@"兄弟捷登 超轻便折叠桌 BRS-Z33",@"sold":@"销量 8",@"price":@"￥99",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS00001461_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/c/2/a/c2f13a368eadc1081c93324ecf03d36a.jpg",@"des":@"海豹睡袋 左开",@"sold":@"销量 18",@"price":@"￥296",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS0000133_d.html"},
                 @{@"image":@"https://api2.lis99.com/upload/app_goods/9/e/0/9ee3d471a847861d0213c16812d78880.jpg",@"des":@"牧高笛 水瓶自动充气垫",@"sold":@"销量 18",@"price":@"￥136",@"url":@"http://m.lis99.com/mall/goodsappv496/LIS0000211_d.html"},
                 ];
    }
    
    [_collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>
#pragma mark CV段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    NSInteger count = Width > ((CollectWID + 10) * 2) ? Width / (CollectWID + 10):2;
    NSInteger countSection = (_MJDatas.count  + count  - 1)/ count;
    
    return countSection;
    
}

#pragma mark CV行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    //    if (section  < [_MJDatas count]/ 2) {
    //        return 2;
    //    }
    //    else
    //    {
    //
    //        return [_MJDatas count] - (section * 2);
    //    }
    
    NSInteger count = Width > ((CollectWID + 10) * 2) ? Width / (CollectWID + 10):2;
    if (section  < [_MJDatas count]/ count) {
        return count;
    }
    else
    {
        
        return [_MJDatas count] - (section * count);
    }
    
    
    
}

#pragma mark ［配置CV单元格］
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 4;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = HexColor(0xe5e5e5).CGColor;
    
    
  
    NSDictionary *dic = _MJDatas[2*indexPath.section + indexPath.row];
    SetImageViewImageWithURL_C(cell.image1, dic[@"image"], PlaceHolderName);
    cell.label1.text = dic[@"des"];
    cell.label2.text = dic[@"sold"];
    cell.label3.text = dic[@"price"];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    cell.image1.userInteractionEnabled = YES;
    cell.image1.tag = 2*indexPath.section + indexPath.row;
    [cell.image1 addGestureRecognizer:tap];
    return cell;
}

- (void)onClick:(UIButton *)btn
{
    
}

- (void)onTap:(UITapGestureRecognizer *)tap
{
    NSDictionary *dic = _MJDatas[tap.view.tag];
    [ZXDeatilVC showTheZXDeatilVC:dic[@"url"] andTheName:@"" andTheDiff:100 andTheDic:dic];
}

#pragma mark --UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // CGFloat width = 170;
    
    
    CGFloat width = Width > ((CollectWID + 10) * 2) ? CollectWID:(Width - 30) / 2.0;
    
    
    NSInteger  height = width * 0.7 + 12 * 4 + 20 * 4 ;
    
    
    
    
    
    return CGSizeMake(width, height);
}




-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    // return UIEdgeInsetsMake(Width * 0.015 , Width * 0.01,Width * 0.015, Width * 0.01);
    
    
    NSInteger count = Width > ((CollectWID + 10) * 2) ? Width / (CollectWID + 10):2;
    CGFloat space =((Width - (count * CollectWID)) * 0.1) / ((count + 1) * 0.1);
    
    
    CGFloat spacewid = Width > ((CollectWID + 10) * 2) ? space:10;
    
    return UIEdgeInsetsMake(spacewid ,spacewid, 0, spacewid);
}


#pragma mark  热门产品跟新平上架点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //商品点击进入商品详情
    
    //        Goods *model =  _MJDatas[(indexPath.section * 1)+ indexPath.row+indexPath.section];
    //        if (self.collectionView1) {
    //            self.UICollectionViewClickBlock(model,(indexPath.section * 1)+ indexPath.row+indexPath.section);
    //        }
    
    
}

@end

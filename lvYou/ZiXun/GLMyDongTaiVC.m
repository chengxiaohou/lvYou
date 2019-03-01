//
//  MyDongTaiVC.m
//  ChengFengSuDa
//
//  Created by 小马网络 on 2016/12/21.
//  Copyright © 2016年 小马网络. All rights reserved.
//

#import "GLMyDongTaiVC.h"
#import "WHC_PhotoListCell.h"
#import "WHC_PictureListVC.h"
#import "WHC_CameraVC.h"
#import "CollectionViewCell.h"
#import "AppDelegate.h"


#define kWHC_CellName     (@"WHC_PhotoListCellName")
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface GLMyDongTaiVC ()<UITextViewDelegate,UIActionSheetDelegate,NavViewDelegate,
WHC_ChoicePictureVCDelegate,
WHC_CameraVCDelegate,
UIActionSheetDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collecionView;
@property (assign, nonatomic) NSInteger indexNum;//最大限度照片数量
@property (assign, nonatomic) NSInteger index;//当前索引
@property (nonatomic, strong) UIImage *image;//加号图片
@property (nonatomic, strong) NSMutableArray  *imageArr;//图片数组
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *tishiLb;

@property (strong, nonatomic) IBOutlet UIView *xieYiView;

@property (nonatomic,strong) UIView *balckView;
@property (weak, nonatomic) IBOutlet UIButton *xYbtn;
@property (weak, nonatomic) IBOutlet UITextView *xYTextView;

@end

@implementation GLMyDongTaiVC
{
    NSMutableString *_pics; //云返回回来的网址拼接
    NSInteger _num; //判断上传的个数
    BOOL _delteImg; //是否发送失败后修改了图片后重发
}

+ (void)showTheMyDongTaiVC
{
    GLMyDongTaiVC *dongTai = [Worker MainSB:@"MyDongTaiVC"];
    [Worker showVC:dongTai];
}
- (IBAction)selectedTheXieYiBtn:(UIButton *)sender {
    _xYbtn.selected = !_xYbtn.selected;
    if (_xYbtn.selected) {
        //显示密码
        [_xYbtn setImage:[UIImage imageNamed:@"order_ic_evaluationed"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        //隐藏密码
        [_xYbtn setImage:[UIImage imageNamed:@"order_ic_evaluation"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)agreeXieYIBtn:(UIButton *)sender {
    
    if (_xYbtn.selected) {
        
        _xieYiView.hidden = YES;
        _balckView.hidden = YES;
        [UDManager agreeTheXieYi:1];
    }
    else
    {
        [MBProgressHUD showMessag:@"请同意协议" toView:Window];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _xYbtn.selected = NO;
    _num = 0;
    _pics = [[NSMutableString alloc] init];
    self.nav.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"daohanglanPX"]];
    [self.nav setTitle:@"我的动态" leftText:@"" rightTitle:@"发表" showBackImg:NO];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    leftBtn.frame = CGRectMake(12, 30, 40, 30);
   // leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    [self.nav addSubview:leftBtn];
    
    
    
    self.nav.delegate = self;
    
    _collecionView.backgroundColor = [UIColor whiteColor];
   
    
    UIImage *image = [UIImage imageNamed:@"AddGroupMemberBtnHL"];
    self.image = image;

    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collecionView.collectionViewLayout = flowLayout;
    _collecionView.dataSource = self;
    _collecionView.delegate = self;
    
    _collecionView.showsVerticalScrollIndicator = NO;
    _collecionView.showsHorizontalScrollIndicator = NO;
    _collecionView.scrollEnabled = NO;
    
    _textView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDelteImage) name:@"delteTheImage" object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHide)];
    [self.nav addGestureRecognizer:tap];
    
    if ([UDManager agreeTheXieYi] == 0) {
       [self layoutTheXieYiView];
    }
    
}

- (void)layoutTheXieYiView
{
    _balckView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    _balckView.backgroundColor = [UIColor blackColor];
    _balckView.alpha = 0.7;
    [self.view addSubview:_balckView];
    
    _xYTextView.text = @"1.法律声明\n1.1、用户同意不发布违法、色情等不良信息，一旦发生，将承担法律责任。\n1.2、用户须具有法定的相应权利能力和行为能力的自然人、法人或其他组织，能够独立承担法律责任。您同意后，平台将认为您确认自己具备主体资格，能够独立承担法律责任。若因不具备主体资格，w而导致一切后果，将由您及您的监护人自行承担。\n1.3、用户自行诚信向发布正规信息，如果用户发布的信息不合法、不准确、有欺骗信，用户需要承担因此引起的相应责任及后果，并且本App保留终止用户使用本平台各项服务权利。\n1.4、用户在本站进行浏览等活动，设计用户真实信息时，本站将予以严格保密，除非得到用户的授权或者法律另外规定，本站不向外界披露用户隐私信息。\n1.5、用户不得将在本站注册获取的帐号借给他人使用，否则用户应承担由此产生的全部责任，并与实际使用人承担连带责任。\n2、用户信息的合理使用\n2.1、您同意以上相关责任约定，并同意本App平台通过邮件、短信电话等形式，向在本站注册的用户发送信息等告知信息的权利。\n2.2、您了解并同意，本APP有权应国家司法、行政等主管部门的要求，向其提供您在本App平台填写的相关信息和交易记录等必要信息。";
    _xieYiView.frame = CGRectMake((Width - (Width * 0.7)) / 2.0, (HEIGHT - Height * 0.7) / 2.0, Width * 0.7,Height * 0.7);
    [self.view addSubview:_xieYiView];
    
    
}

- (void)onBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)onHide
{
    [_textView resignFirstResponder];
}

#pragma mark 删除图片了
- (void)onDelteImage
{
    _delteImg = YES;
}

#pragma mark 发表
- (void)right
{

    [self.view endEditing:YES];
    //有文字的时候发送动态
    if (_textView.text.length == 0) {
        [MBProgressHUD showMessag:@"请输入内容" toView:Window];
        return;
    }
   
    UIImage *image = [self.imageArr lastObject];
    
    if (image == self.image) {
        
        [self.imageArr removeLastObject];
        
    }

   NSMutableArray *picArr = [[NSMutableArray alloc] initWithArray:self.imageArr];
    
    NSString *goodStr = nil;
     if (_textView.text.length != 0) {

        goodStr  = [_textView.text   stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
     }
    else
    {
        goodStr = @"";

    }
        //当有图片时
        if (picArr.count != 0) {
            
        
        
            //当有图片第一次发送时
        if (_pics.length == 0 || !_delteImg) {
            
        
       // [MBProgressHUD beginAnimateHUDAddedTo:self.view text:@"正在上传"];
        
            
            [self shangchuan:goodStr];
//        [OSSImageUploader asyncUploadImages:picArr complete:^(NSArray<NSString *> *names, UploadImageState state) {
//            
//            
//                
//            }];
        
      //===================================
        }
        //当传送失败时重新发表，这时不需要再往云里传数据了
        else if(_pics.length != 0 && _delteImg)
        {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            //当后台发送失败后重发直接，且不需要上传给云了
            
            
            
           
        }
        }
        else
        {
            //没图片时发送
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }
   // }
}

#pragma mark 上传到云
- (void)shangchuan:(NSString *)goodStr
{
   // MBProgressHUD *HUD = [MBProgressHUD beginAnimateHUDAddedTo:self.view text:nil detailText:@"正在上传"];
 
    
    
}


- (NSInteger)sendTheSecondTime

{
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    
    NSString *curTime = [NSString stringWithFormat:@"%lld",dTime];
    
    NSInteger timer = [curTime integerValue];
    
    
  
    return timer;
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ======== CollectionView 数据源=============

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (!self.imageArr.count) {
        
        [self.imageArr addObject:self.image];
        
        return 1;
    }
    
    return self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!self.imageArr.count) {
        cell.image = self.image;
    } else {
        cell.image = self.imageArr[indexPath.row];
        
      
    }
    
    return cell;
}

#pragma mark ========= CollectionView delegate==========

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *image = [self.imageArr lastObject];
    
    self.index = indexPath.row;
    
    if (self.imageArr.count == (self.index + 1) && image == self.image) {
        
        UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
        [as showInView:self.view];
        
    } else {
        
       
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (Width == 320) {
        return CGSizeMake(70, 70);
    }
    else
    {
    return CGSizeMake(85, 85);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (WIDTH == 320 || WIDTH == 414) { //4或者6+
        return UIEdgeInsetsMake(20, 15, 0, 15);
    } else if (WIDTH == 375) {
        return UIEdgeInsetsMake(20, 30, 0, 30);
    }
    return UIEdgeInsetsMake(20, 20, 0, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    if (WIDTH == 320 || WIDTH == 414) {//4或者6+
        return 15;
    } else if (WIDTH == 375) {
        return 27;
    }
    return 15;
}

#pragma mark ======= UIActionSheet Delegate =========

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    self.indexNum = 9;
    
    switch (buttonIndex) {
            
        case 0:{//从相册选择多张
            
            //加个全
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status)
             {
                 if (status == PHAuthorizationStatusAuthorized)
                 {
            WHC_PictureListVC  * vc = [WHC_PictureListVC new];
            vc.delegate = self;
            vc.maxChoiceImageNumberumber = self.indexNum - self.imageArr.count + 1;
            [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
                 }
                 else
                 {
                    //  [MBProgressHUD showMessag:@"无法访问，请在设置－隐私－照片开通权限" toView:Window];
                     dispatch_sync(dispatch_get_main_queue(), ^{
                     [self showFunctionAlertWithTitle:nil message:@"无法拍照，请在设置－隐私－照片开通权限" functionName:@"确定" Handler:^{
                         
                     }];
                     });
                 }
             }];

        }
            break;
            
        case 1: {
            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus ==AVAuthorizationStatusRestricted ||
                authStatus ==AVAuthorizationStatusDenied)
            {
                // 无权限 引导去开启
                
            //  [MBProgressHUD showMessag:@"无法访问，请在设置－隐私－相机开通权限" toView:Window];
              //  dispatch_sync(dispatch_get_main_queue(), ^{
                [self showFunctionAlertWithTitle:nil message:@"无法拍照，请在设置－隐私－相机开通权限" functionName:@"确认" Handler:^{
                    
                }];
              //  });
                
            }
            else 
            {
            
            WHC_CameraVC * vc = [WHC_CameraVC new];
            vc.delegate = self;
            [self presentViewController:vc animated:YES completion:nil];
            }
            
        }
            break;
    }
}

#pragma mark - WHC_ChoicePictureVCDelegate

- (void)WHCChoicePictureVC:(WHC_ChoicePictureVC *)choicePictureVC didSelectedPhotoArr:(NSArray *)photoArr{
    
    _delteImg = YES;
    if ([self.imageArr firstObject] == self.image) {
        
        self.imageArr = [photoArr mutableCopy];
      
    } else {
        
        for (UIImage *image in photoArr) {
            
            [self.imageArr insertObject:image atIndex:0];
        }
    }
    
    if (self.imageArr.count > self.indexNum) {
        
        [self.imageArr removeObject:self.image];
        
    }
    
    if (self.imageArr.count < self.indexNum && [self.imageArr lastObject] != self.image) {
        
        [self.imageArr addObject:self.image];
    }
  
    
    _viewHeight.constant = ((((_imageArr.count + 2) / 3.0 - 1)) *  85) + (20 * 4) + HEIGHT / 3.0;
    
    [self.collecionView reloadData];
    
}

#pragma mark - WHC_CameraVCDelegate
- (void)WHCCameraVC:(WHC_CameraVC *)cameraVC didSelectedPhoto:(UIImage *)photo {
    _delteImg = YES;
    [self.imageArr insertObject:photo atIndex:0];
    
    
    if (self.imageArr.count > self.indexNum) {
        
        [self.imageArr removeObject:self.image];
        
    }
    
   _viewHeight.constant = ((((_imageArr.count + 2) / 3.0 - 1)) *  85) + (20 * 4) + HEIGHT / 3.0;
    
    [self.collecionView reloadData];
    
}


#pragma  mark ==== 懒加载 ======

- (NSMutableArray *)imageArr {
    
    if (_imageArr == nil) {
        
        _imageArr = [NSMutableArray array];
    }
    
    return _imageArr;
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti:) name:@"byValue" object:nil];
}

- (void)noti:(NSNotification *)noti {
    
    NSDictionary *dict = noti.userInfo;
    
    self.imageArr = dict[@"array"];
    
    [self.collecionView reloadData];
    
}




#pragma mark
- (void)textViewDidChange:(UITextView *)textView
{
    if ([_textView.text length] == 0) {
        [_tishiLb setHidden:NO];
    }
    else{
        
        [_tishiLb setHidden:YES];
    }
}



@end

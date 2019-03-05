//
//  PersonInfoVC.m
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/5.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "MKPersonInfoVC.h"

@interface MKPersonInfoVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,NavViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *imgBtn; //头像
@property (weak, nonatomic) IBOutlet EEView *view1; //昵称


@property (weak, nonatomic) IBOutlet EEView *view2;//性别
@property (weak, nonatomic) IBOutlet UILabel *label2;//性别Lb

@property (weak, nonatomic) IBOutlet EEView *view3; //出生日期
@property (weak, nonatomic) IBOutlet UILabel *label3; //出生日期lb

@property (weak, nonatomic) IBOutlet EEView *view4;//实名认证
@property (weak, nonatomic) IBOutlet UILabel *label4; //实名认证lb
@property (weak, nonatomic) IBOutlet EEView *view5; //绑定手机
@property (weak, nonatomic) IBOutlet UILabel *label5; //绑定手机lb

@property (weak, nonatomic) IBOutlet EEView *view6; //登录密码
@property (weak, nonatomic) IBOutlet UILabel *label6; //登录密码lb

@property (weak, nonatomic) IBOutlet EEView *view7; //支付密码
@property (weak, nonatomic) IBOutlet UILabel *label7; //支付密码lb

@property (weak, nonatomic) IBOutlet UITextField *textF1;

@property (nonatomic,copy) NSString *pics;
@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (nonatomic,assign) NSInteger sex;
@end

@implementation MKPersonInfoVC
+ (void)showThePersonInfoVC
{
    MKPersonInfoVC *person = [Worker MainSB:@"PersonInfoVC"];
    [Worker showVC:person];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:@"个人信息" leftText:nil rightTitle:@"提交" showBackImg:YES];
    self.nav.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:ThemeImageColor]];
    self.nav.delegate = self;
    
    _textF1.borderStyle = UITextBorderStyleNone;
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    _imgBtn.layer.cornerRadius = 32.0;
    
    MJWeakSelf;
    [_view2 setClickEvent:^{
    //修改性别
    [weakSelf changeTheSex];
    }];
    
    [_view3 setClickEvent:^{
        [weakSelf configTheDatePicker];
    }];
    
    
    
    [_view4 setClickEvent:^{
       
    }];
    
    [_view5 setClickEvent:^{
       //绑定手机
       // [PhoneLogVC showThePhoneLogVC:300];
    }];
    
    [_view6 setClickEvent:^{
        //修改登录密码
         [MKForgetPassWordVC showTheForgetPassWordVC:200];
    }];
    

    _textF1.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAuth) name:@"auth" object:nil];
    [self getThePersonDatas];
  //  [self showTheAuthStatus];
}

- (void)showTheAuthStatus
{
    if ([USER.certificationStatus integerValue] == 0 || [USER.certificationStatus integerValue] == 3) {
        _label4.text = @"未实名认证";
    }else if ([USER.certificationStatus integerValue] == 1){
        _label4.text = @"正在审核中";
    }else{
        _label4.text = @"已实名认证";
    };

    
}
- (void)onAuth
{
    [self showTheAuthStatus];
}

#pragma mark 修改个人信息
-(void)right
{
//    if (_pics.length == 0)
//    {
//        [MBProgressHUD showMessag:@"请上传头像" toView:Window];
//        return;
//    }else
     if (_textF1.text.length == 0)
    {
        [MBProgressHUD showMessag:@"请填写昵称" toView:Window];
        return;
    }
    else if (_sex == 0)
    {
        [MBProgressHUD showMessag:@"请填写性别" toView:Window];
        return;
    }
    else if (_label3.text.length == 0)
    {
        [MBProgressHUD showMessag:@"请填写出生日期" toView:Window];
        return;
    }
    else
    {
    NSString *nickName = @"";
    if (_textF1.text.length > 0) {
        nickName = _textF1.text;
    }
    
    MJWeakSelf;
        NSString *telPhone = @"";
        if (USER.telPhone.length > 0) {
            telPhone = USER.telPhone;
        }
        NSString *phone = @"";
        if (USER.phone.length > 0) {
            phone  = USER.phone;
        }
        
    [self post1_URL:SYSURL@"api/user/edit_user" parameters:@{@"id":USER.ID,@"headImg":_pics,@"telPhone":telPhone,@"nickName":_textF1.text,@"sex":@(_sex),@"brithday":_label3.text,@"phone":phone} success:^(NSDictionary *dic) {
        
        [MBProgressHUD showMessag:@"修改个人信息成功" toView:Window];
        USER.nickName = weakSelf.textF1.text;
        USER.sex = [NSString stringWithFormat:@"%ld",(long)weakSelf.sex];
        USER.headImg = weakSelf.pics;
        KUserNewNotiWithUserInfo(nil);
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    }];
    }
}

#pragma mark 选择出生年月日
- (void)configTheDatePicker
{
    MJWeakSelf;
    
//    [YYDataPickerView showTheDatePickViewWithTitle:@"选择出生日期" andThemanager:nil MinDateStr:nil MaxDateStr:nil PickerMode:UIDatePickerModeDate andTheReceviedTimeFormatter:@"YYYY-MM-dd" ResultBlock:^(id result) {
//        NSString *string = result;
//        weakSelf.label3.text = string;
//
//    }];
    

}



#pragma mark 获取个人信息数据
- (void)getThePersonDatas
{
   

            if (USER.headImg.length > 0) {
                _pics = USER.headImg;
            }
            else{
                _pics = @"";
            }
            _sex = [USER.sex integerValue];
            
            SetButtonImageWithURL_C(_imgBtn, USER.headImg, PlaceHolderName);
            _textF1.text = USER.nickName;
            if ([USER.sex integerValue] == 0) {
             _label2.text = @"保密";
            }
            else if ([USER.sex integerValue] == 1){
             _label2.text = @"男";
            }
            else{
             _label2.text = @"女";
            }
            _label3.text =USER.brithday;
           // [self showTheAuthStatus];
            if (USER.phone.length > 9) {
                _label5.text = [USER.phone stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"***"];
            }
            else{
               _label5.text = USER.phone;
            }
            
            
    
        

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 修改头像
- (IBAction)changeTheHeardImage:(UIButton *)sender {
    
    MJWeakSelf;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.imagePicker.sourceType = UIImagePickerControllerCameraCaptureModeVideo;
        [self xiangJi];

    }];
    
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self xiangCe];
    }];
    
    
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark 上传到七牛
- (void)shangchuan:(NSArray *)imageArr
{
    
    [self getTheToken:imageArr];
}

- (void)getTheToken:(NSArray *)imageArr
{
    
}

#pragma mark 相机
- (void)xiangJi
{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        // 无权限 引导去开启
        
        [self showFunctionAlertWithTitle:nil message:@"无法拍照，请在设置－隐私－相机开通权限" functionName:@"确认" Handler:^{
            
        }];
        
    }
    else{
        
        if (_imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            [self presentViewController:_imagePicker animated:YES completion:nil];
        }
        else
        {
            
        }
        
    }
    
    
}

#pragma mark 相册
- (void)xiangCe
{
    MJWeakSelf;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status)
     {
         if (status == PHAuthorizationStatusAuthorized)
         {
             
             
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                 [self presentViewController:weakSelf.imagePicker animated:YES completion:nil];
             });
             
             
             
             
         }
         else
         {
             [self showFunctionAlertWithTitle:nil message:@"无法拍照，请在设置－隐私－照片开通权限" functionName:@"确定" Handler:^{
                 
             }];
         }
     }];
    
}

#pragma mark 进入裁剪框VC
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = image.size.height * (width/image.size.width);
   // USER.headImg =
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self presentViewController:_imagePicker animated:NO completion:nil];
}


#pragma mark 裁剪回调[上传]
- (void)cropImageDidFinishedWithImage:(UIImage *)image
{
    if (image != nil) {
        
        //_imgView.image = [UIImage imageWithData:_data];
        NSMutableArray *imageArr = [[NSMutableArray alloc] initWithObjects:image, nil];
        [self shangchuan:imageArr];
    }
}


#pragma mark 修改性别
- (void)changeTheSex
{
    MJWeakSelf;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.sex = 1;
        weakSelf.label2.text = @"男";
       
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //改用户数据
        weakSelf.sex = 2;
        weakSelf.label2.text = @"女";
        
    }];
    
    
 
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _textF1) {
        if (textField.text.length + string.length > 12) {
            return NO;
        }
        else{
            return YES;
        }
    }
    else{
        return YES;
    }
    
}


@end

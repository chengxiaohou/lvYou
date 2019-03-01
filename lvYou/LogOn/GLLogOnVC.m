//
//  LogOnVC.m
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/2.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "GLLogOnVC.h"

@interface GLLogOnVC ()<UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textF1; //账户
@property (weak, nonatomic) IBOutlet UITextField *textF2; //密码
@property (weak, nonatomic) IBOutlet UIButton *weiXinBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn1; //显示隐藏密码按钮
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation GLLogOnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _btn1.selected = NO;
    [self configTheView];
}

- (void)configTheView
{
    _weiXinBtn.layer.cornerRadius = (Width * 0.131) / 2.0;
    _textF1.borderStyle = UITextBorderStyleNone;
    _textF2.borderStyle = UITextBorderStyleNone;
    _textF1.delegate = self;
    _textF2.delegate = self;
    
    //
    [_registBtn setImage:[UIImage imageNamed:@"icon_jump"] forState:UIControlStateNormal];
    [_registBtn setTitle:@"去注册 " forState:UIControlStateNormal];
    [_registBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _registBtn.imageView.image.size.width, 0, _registBtn.imageView.image.size.width)];
    [_registBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _registBtn.titleLabel.bounds.size.width, 0, -_registBtn.titleLabel.bounds.size.width)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTheLogonName:) name:@"regist" object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHidden)];
    [self.view addGestureRecognizer:tap];
}
- (void)onHidden
{
    [self.view endEditing:YES];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)showTheLogonName:(NSNotification *)note
{
    _textF1.text = note.userInfo[@"phone"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 显示和隐藏密码
- (IBAction)showOrHiddenPassword:(UIButton *)sender {
 if ([[_textF2.text stringByReplacingOccurrencesOfString:@" " withString:@""] length] > 0) {
    _btn1.selected = !_btn1.selected;
    if (_btn1.selected) {
        
        [_btn1 setImage:[UIImage imageNamed:@"login_ic_invisible"] forState:UIControlStateNormal];
        _textF2.secureTextEntry = NO;
    }
    else
    {
        [_btn1 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
        _textF2.secureTextEntry = YES;
    }
   }
}



#pragma mark 注册
- (IBAction)ToRegist:(UIButton *)sender {
    [GLRegistVC showTheRegistVC];
}

#pragma mark 登录
- (IBAction)TologOn:(UIButton *)sender {
    
    [self.view endEditing:YES];
//    _textF1.text = @"test";
//    _textF2.text = @"qq123456";
    if (_textF1.text.length != 0 ) {


        if (_textF2.text.length < 1) {

            [MBProgressHUD showMessag:@"请输入您的密码" toView:Window];
            return;
        }
    
        
        
        [self loginRequest];
    }
    else
    {
        [MBProgressHUD showMessage:@"手机号格式不正确" toView:Window];
    }
}

#pragma mark 登录
- (void)loginRequest
{
    
    //[_textF2.text MD5]
  
    //d0dcbf0d12a6b1e7fbfa2ce5848f3eff
 //   MJWeakSelf;
//    [self post1_URL:SYSURL@"api/user/mechanicLogin"
//         parameters:@{@"userName":_textF1.text,@"pwd":[_textF2.text MD5]} success:^(NSDictionary *dic) {
    
//             NSDictionary *temp = dic[@"data"];
//             [USER mj_setKeyValues:temp];
    if ([_textF1.text isEqualToString:@"13049331809"]) {
   
        if ([_textF2.text isEqualToString:@"123456"]) {
         
             [USER setIsLogin:YES];
             USER.phone = _textF1.text;
             USER.nickName = @"喵小拖";
             USER.ID = @"1";
             USER.userName = @"喵小拖";
             USER.headImg = @"https://pic.qyer.com/avatar/009/10/94/99/200?v=1516673371";
             [UDManager setLoginName:_textF1.text password:_textF2.text andTheToken:USER.userToken andTheTag:0];
             KUserNewNotiWithUserInfo(nil);
             [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshOrder" object:@"0"];
             UITabBarController *vc = (UITabBarController *)Window.rootViewController;
             vc.selectedIndex = 0;// 定格到第1模块
             for (UINavigationController *navVC in vc.viewControllers)
             {
                 [navVC popToRootViewControllerAnimated:0];// 确保4个模块都显示主页
             }
             [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
           [MBProgressHUD showMessag:@"该账号密码不正确" toView:Window];
        }
    }
    else{
        [MBProgressHUD showMessag:@"该账号未注册" toView:Window];
    }
             
             
//         }elseAction:^(NSDictionary *dic) {
//
//             //  [MBProgressHUD showError:dic[@"msg"] toView:Window];
//         } failure:^(NSError *error) {
//
//
//         }];
}

#pragma mark 忘记密码
- (IBAction)ToForgetPassWord:(UIButton *)sender {
    
    [GLForgetPassWordVC showTheForgetPassWordVC:100];
}

#pragma mark 验证码登录
- (IBAction)toLogonUserCode:(UIButton *)sender {
    //[PhoneLogVC showThePhoneLogVC:100];
}

#pragma mark 微信登录
- (IBAction)ToWeiXinLogOn:(UIButton *)sender {
}

#pragma mark textFildDeleget
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    MJWeakSelf;
    CGFloat height = textField.y + textField.height * 3;
    if (height  > Height - 325) {
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.view.frame = CGRectMake(0, -fabs(height - (Height - 325)), Width, Height);
        }];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    MJWeakSelf;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.view.frame = CGRectMake(0, 0, Width, Height );
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _textF2) {
       
        if (textField.text.length == 1 && string.length == 0) {
            
            _btn1.selected = NO;
            [_btn1 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
            _textF2.secureTextEntry = YES;
        }
    }
    
    return YES;
}

@end

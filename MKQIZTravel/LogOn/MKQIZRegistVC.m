//
//  RegistVC.m
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/2.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "MKQIZRegistVC.h"

@interface MKQIZRegistVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textF1; //手机号

@property (weak, nonatomic) IBOutlet UITextField *textF2; //验证码
@property (weak, nonatomic) IBOutlet UITextField *textF3; //输入用户名
@property (weak, nonatomic) IBOutlet UITextField *textF4; //输入密码
@property (weak, nonatomic) IBOutlet UITextField *textF5; //确认密码
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIButton *btn3; //统一协议按钮

@property (weak, nonatomic) IBOutlet UILabel *xYLb;


@end

@implementation MKQIZRegistVC

+(void)showTheRegistVC
{
    MKQIZRegistVC *regist = [Worker MainSB:@"RegistVC"];
    [Worker showVC:regist];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
  
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCodeBtn:) name:NOTI_SMSCountDown object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 刷新验证码按钮
- (void)refreshCodeBtn:(NSNotification *)info
{
    
    if ([CD SMS_CD] != 0)
    {
        [_codeBtn setTitle:[NSString stringWithFormat:@"已发送(%lds)",(long)CD.SMS_CD] forState:UIControlStateNormal];
    }
    else
    {
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
}
- (IBAction)onBack:(UIButton *)sender {
    [CD stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTheView];
    
    _xYLb.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick)];
    [_xYLb addGestureRecognizer:tap];
}
- (void)onClick
{
   // [WebVC showWithUrl:@"http://weixin.sdhui.net/commonAgree" andTheTitle:@"注册协议" andTheDiff:100];
}

- (void)configTheView
{
    _btn1.selected = NO;
    _btn2.selected = NO;
    _btn3.selected = NO;
    _textF5.borderStyle = UITextBorderStyleNone;
    _textF4.borderStyle = UITextBorderStyleNone;
    _textF3.borderStyle = UITextBorderStyleNone;
    _textF2.borderStyle = UITextBorderStyleNone;
    _textF1.borderStyle = UITextBorderStyleNone;
    _textF1.delegate = self;
    _textF2.delegate = self;
    _textF3.delegate = self;
    _textF4.delegate = self;
    _textF5.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHidden)];
    [self.view addGestureRecognizer:tap];
}
- (void)onHidden
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 发送验证码
- (IBAction)sendTheCode:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (_textF1.text.length != 0)
    {
        
            
            if (CD.SMS_CD == 0) {
                [CD startCountDown];
                //[self requstTheCode];
            }
            else
            {
               // ErrorCodeCD;
            }
        
    }
    else
    {
        [MBProgressHUD showError:@"输入的号码不能为空" toView:self.view];
    }
}
#pragma mark 注册号码查重 + 验证码请求
- (void)requstTheCode
{
    NSString *url = SYSURL@"api/sms/sendMsgCode";
    NSDictionary *parameters = @{@"phone":_textF1.text,@"type":@"2"};
    
    
    [self post2_URL:url
         parameters:parameters  success:^(NSDictionary *dic) {
             
             // 验证码
           //  [CD startCountDown];
             
             
             
         } elseAction:^(NSDictionary *dic) {
             
           //  [MBProgressHUD showError:dic[@"msg"] toView:Window];
         } failure:^(NSError *error) {
             
           
         }];;
    
}



#pragma mark 显示密码
- (IBAction)ToShowThePassword:(UIButton *)sender {
   if ([[_textF4.text stringByReplacingOccurrencesOfString:@" " withString:@""] length] > 0) {
    _btn1.selected = !_btn1.selected;
    if (_btn1.selected) {
        //显示密码
        [_btn1 setImage:[UIImage imageNamed:@"login_ic_invisible"] forState:UIControlStateNormal];
        _textF4.secureTextEntry = NO;
        
    }
    else
    {
        //隐藏密码
        [_btn1 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
        _textF4.secureTextEntry = YES;
    }
   }
    
}



#pragma mark 去显示确认密码
- (IBAction)ReToShowThePassword:(UIButton *)sender {
    if ([[_textF5.text stringByReplacingOccurrencesOfString:@" " withString:@""] length] > 0) {
    _btn2.selected = !_btn2.selected;
    if (_btn2.selected) {
        //显示密码
        [_btn2 setImage:[UIImage imageNamed:@"login_ic_invisible"] forState:UIControlStateNormal];
        _textF5.secureTextEntry = NO;
        
    }
    else
    {
        //隐藏密码
        [_btn2 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
        _textF5.secureTextEntry = YES;
    }
    }
}

#pragma mark 注册
- (IBAction)ToRegist:(UIButton *)sender {
    
    [self.view endEditing:YES];
   
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    NSString *str1 = [_textF2.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *str2 = [_textF3.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *str3 = [_textF4.text stringByReplacingOccurrencesOfString:@" " withString:@""];
  
    if ([_textF1.text stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0 || _textF1.text.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号码" toView:Window];
        return;
    }
    else if (str1.length == 0)
    {
        [MBProgressHUD showError:@"请输入验证码" toView:Window];
        return;
    }
    else if (str2.length == 0 ) {
        
        [MBProgressHUD showError:@"请输入用户名" toView:Window];
        return;
    }
    else if (str3.length == 0 ) {
        
        [MBProgressHUD showError:@"请输入您的密码" toView:Window];
        return;
    }
    
    else if (![_textF4.text isEqualToString:_textF5.text])
    {
        [MBProgressHUD showError:@"两次输入密码不一致" toView:Window];
        return;
    }
    else if (_textF4.text.length < 6)
    {
        [MBProgressHUD showError:@"密码不得少于6位" toView:Window];
        return;
    }
    else if (!_btn3.selected)
    {
        [MBProgressHUD showError:@"请勾选注册协议" toView:Window];
        return;
    }
    else
    {
        [self theNextStep];
        
    }
}

#pragma mark 注册
- (void)theNextStep
{
   
}

#pragma mark 同意协议
- (IBAction)ToReadTheAgreement:(UIButton *)sender {
    
    _btn3.selected = !_btn3.selected;
    if (_btn3.selected) {
        //以阅读
        [_btn3 setBackgroundImage:[UIImage imageNamed:@"login_ic_agree"] forState:UIControlStateNormal];
  
    }
    else
    {
        
        [_btn3 setBackgroundImage:[UIImage imageNamed:@"login_ic_unagree"] forState:UIControlStateNormal];
     
    }
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


#pragma mark 限制名字字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _textF3) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (_textF3.text.length >= 10) {
            _textF3.text = [textField.text substringToIndex:10];
            return NO;
        }
    }
    
    if (textField == _textF4) {
        
        if (textField.text.length == 1 && string.length == 0) {
            
            _btn1.selected = NO;
            [_btn1 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
            _textF4.secureTextEntry = YES;
        }
    }
    else if (textField == _textF5) {
        
        if (textField.text.length == 1 && string.length == 0) {
            
            _btn2.selected = NO;
            [_btn2 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
            _textF5.secureTextEntry = YES;
        }
    }
    return YES;
}



@end

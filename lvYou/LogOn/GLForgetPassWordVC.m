//
//  ForgetPassWordVC.m
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/2.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "GLForgetPassWordVC.h"

@interface GLForgetPassWordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *texF1;//手机号
@property (weak, nonatomic) IBOutlet UITextField *textF2; //验证码
@property (weak, nonatomic) IBOutlet UITextField *textF3;//请输入密码
@property (weak, nonatomic) IBOutlet UITextField *textF4; //请再次确认密码
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn1; //输入密码显示隐藏密码按钮
@property (weak, nonatomic) IBOutlet UIButton *btn2;//再次输入密码显示隐藏密码按钮
@property (weak, nonatomic) IBOutlet UILabel *titleName;

@end

@implementation GLForgetPassWordVC
+(void)showTheForgetPassWordVC:(NSInteger)diff
{
    GLForgetPassWordVC *forget = [Worker MainSB:@"ForgetPassWordVC"];
    forget.diff = diff;
    [Worker showVC:forget];
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

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configTheView];
}

- (void)configTheView
{
    _btn1.selected = NO;
    _btn2.selected = NO;
    _textF4.borderStyle = UITextBorderStyleNone;
    _textF3.borderStyle = UITextBorderStyleNone;
    _textF2.borderStyle = UITextBorderStyleNone;
    _texF1.borderStyle = UITextBorderStyleNone;
    
    _texF1.delegate = self;
    _textF2.delegate = self;
    _textF3.delegate = self;
    _textF4.delegate = self;
    if (_diff == 200) {
        _titleName.text = @"修改密码";
    }
    else{
       _titleName.text = @"忘记密码";
    }
   
}
- (IBAction)onBack:(UIButton *)sender {
    [CD stop];
    if (_diff == 200) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
    [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 查看密码
- (IBAction)checkThePassWord:(UIButton *)sender {
    if ([[_textF3.text stringByReplacingOccurrencesOfString:@" " withString:@""] length] > 0) {
    
    _btn1.selected = !_btn1.selected;
    if (_btn1.selected) {
        //显示密码
        [_btn1 setImage:[UIImage imageNamed:@"login_ic_invisible"] forState:UIControlStateNormal];
        _textF3.secureTextEntry = NO;
        
    }
    else
    {
        //隐藏密码
        [_btn1 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
        _textF3.secureTextEntry = YES;
    }
    }
}


#pragma mark 查看再次确认密码
- (IBAction)reCheckThePassWord:(UIButton *)sender {
    if ([[_textF4.text stringByReplacingOccurrencesOfString:@" " withString:@""] length] > 0) {
    _btn2.selected = !_btn2.selected;
    if (_btn2.selected) {
        //显示密码
        [_btn2 setImage:[UIImage imageNamed:@"login_ic_invisible"] forState:UIControlStateNormal];
        _textF4.secureTextEntry = NO;
        
    }
    else
    {
        //隐藏密码
        [_btn2 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
        _textF4.secureTextEntry = YES;
    }
    }
}



#pragma mark 获取验证码
- (IBAction)getTheCode:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (_texF1.text.length != 0)
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
    NSDictionary *parameters = @{@"phone":_texF1.text,@"type":@"3"};

    [self post2_URL:url
         parameters:parameters  success:^(NSDictionary *dic) {
             
          
             
             
             
         } elseAction:^(NSDictionary *dic) {
             
             //  [MBProgressHUD showError:dic[@"msg"] toView:Window];
         } failure:^(NSError *error) {
             
             
         }];
    
}

#pragma mark 修改密码
- (IBAction)ToChagePassWord:(UIButton *)sender {
    
    [self.view endEditing:YES];

    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    NSString *str1 = [_textF2.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *str2 = [_textF3.text stringByReplacingOccurrencesOfString:@" " withString:@""];
  
    
    if ([_texF1.text stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        [MBProgressHUD showError:@"请输入正确的手机号码" toView:Window];
        return;
    }
    else if (str1.length == 0)
    {
        [MBProgressHUD showError:@"请输入验证码" toView:Window];
        return;
    }
    else if (str2.length == 0 ) {
        
        [MBProgressHUD showError:@"请输入密码" toView:Window];
        return;
    }
    
    else if (![_textF3.text isEqualToString:_textF4.text])
    {
        [MBProgressHUD showError:@"两次输入密码不一致" toView:Window];
        return;
    }
    else if (_textF3.text.length < 6)
    {
        [MBProgressHUD showError:@"密码不得少于6位" toView:Window];
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
    MJWeakSelf;
    [self post1_URL:SYSURL@"api/user/forgetPassword" parameters:@{@"password":_textF3.text,@"phone":_texF1.text,@"code":_textF2.text} success:^(NSDictionary *dic)
     {
         [MBProgressHUD showMessag:@"修改密码成功" toView:Window];
         if (weakSelf.diff == 200) {
            // [weakSelf.navigationController popViewControllerAnimated:YES];
             USER.isLogin = NO;
             [UDManager cleanTheLoginData];
             [Worker gotoLoginIfNotLogin];
         }
         else{
             [weakSelf dismissViewControllerAnimated:YES completion:nil];
         }
         
     }elseAction:^(NSDictionary *dic) {
         if ([dic[@"msg"] length] > 0) {
             [MBProgressHUD showError:dic[@"msg"] toView:Window];
         }
         
     } failure:^(NSError *error) {
         
     }];
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
    if (textField == _textF3) {
        
        if (textField.text.length == 1 && string.length == 0) {
            
            _btn1.selected = NO;
            [_btn1 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
            _textF3.secureTextEntry = YES;
        }
    }
    else if (textField == _textF4) {
        
        if (textField.text.length == 1 && string.length == 0) {
            
            _btn2.selected = NO;
            [_btn2 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
            _textF4.secureTextEntry = YES;
        }
    }
    
    return YES;
}

@end

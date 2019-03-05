//
//  ChangePasswordVC.m
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/5.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "MKChangePasswordVC.h"

@interface MKChangePasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *textF1; //原始密码
@property (weak, nonatomic) IBOutlet UITextField *textF2; //新密码
@property (weak, nonatomic) IBOutlet UITextField *textF3;//确认新密码
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end

@implementation MKChangePasswordVC
+(void)showTheChangePasswordVC
{
    MKChangePasswordVC *chageVC = [Worker MainSB:@"ChangePasswordVC"];
    [Worker showVC:chageVC];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.nav setTitle:@"修改密码" leftText:nil rightTitle:nil showBackImg:YES];
    self.nav.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:ThemeImageColor]];
}
- (IBAction)showThePassword:(UIButton *)sender {
    if ([[_textF2.text stringByReplacingOccurrencesOfString:@" " withString:@""] length] > 0) {
        _btn1.selected = !_btn1.selected;
        if (_btn1.selected) {
            //显示密码
            [_btn1 setImage:[UIImage imageNamed:@"login_ic_invisible"] forState:UIControlStateNormal];
            _textF2.secureTextEntry = NO;
            
        }
        else
        {
            //隐藏密码
            [_btn1 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
            _textF2.secureTextEntry = YES;
        }
    }
}

- (IBAction)showTheRePassword:(UIButton *)sender {
    if ([[_textF3.text stringByReplacingOccurrencesOfString:@" " withString:@""] length] > 0) {
        _btn2.selected = !_btn2.selected;
        if (_btn2.selected) {
            //显示密码
            [_btn2 setImage:[UIImage imageNamed:@"login_ic_invisible"] forState:UIControlStateNormal];
            _textF3.secureTextEntry = NO;
            
        }
        else
        {
            //隐藏密码
            [_btn2 setImage:[UIImage imageNamed:@"login_ic_visible"] forState:UIControlStateNormal];
            _textF3.secureTextEntry = YES;
        }
    }
}


#pragma mark 确认修改
- (IBAction)changeThePassword:(UIButton *)sender {
    
    if ([self OccurrencesOfString:_textF1.text].length == 0) {
        [MBProgressHUD showError:@"请输入原始密码" toView:Window];
        return;
    }
    else if ([self OccurrencesOfString:_textF2.text].length == 0) {
        [MBProgressHUD showError:@"请输入新密码" toView:Window];
        return;
    }
    else if (![_textF2.text isEqualToString:_textF3.text])
    {
        [MBProgressHUD showError:@"两次输入密码不一致" toView:Window];
        return;
    }
    else if (_textF2.text.length < 6)
    {
        [MBProgressHUD showError:@"密码不得少于6位" toView:Window];
        return;
    }
    else
    {
        [self theNextStep];
    }
    
    
}
#pragma mark 修改密码
- (void)theNextStep
{
    [self post1_URL:SYSURL@"api/user/register" parameters:@{@"userName":_textF3.text,@"phone":_textF1.text,@"user_type":@(0),@"smsCode":_textF2.text} success:^(NSDictionary *dic)
     {
         [MBProgressHUD showMessag:@"注册成功" toView:Window];
         [self dismissViewControllerAnimated:YES completion:nil];
         
     }elseAction:^(NSDictionary *dic) {
         if ([dic[@"msg"] length] > 0) {
             [MBProgressHUD showError:dic[@"msg"] toView:Window];
         }
     } failure:^(NSError *error) {
         
     }];
}

- (NSString *)OccurrencesOfString:(NSString *)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end

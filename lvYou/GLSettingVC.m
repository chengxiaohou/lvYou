//
//  SettingVC.m
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/5.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "GLSettingVC.h"

@interface GLSettingVC ()
@property (weak, nonatomic) IBOutlet EEView *cleanView; //清除缓存
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLB;
@property (weak, nonatomic) IBOutlet EEView *helpView; //帮助中心
@property (weak, nonatomic) IBOutlet EEView *aboutView; //关于我们

@end

@implementation GLSettingVC
+(void)showTheSettingVC
{
    GLSettingVC *set = [Worker MainSB:@"SettingVC"];
    [Worker showVC:set];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
}

#pragma mark 配置UI
- (void)setupUI
{
    MJWeakSelf
    // 缓存相关
    __block CGFloat size = [[SDImageCache sharedImageCache] getSize] / 1000000.0;
    _cacheSizeLB.text = [NSString stringWithFormat:@"%.1fMB", size];
    [_cleanView setClickEvent:^{
        
        //========================== Alert ==========================
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"您确定要清理缓存吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"清理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          //  [UD setObject:nil forKey:@"address"];
            [[SDImageCache sharedImageCache] clearMemory];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
            size = [[SDImageCache sharedImageCache] getSize] / 1000000.0;
            weakSelf.cacheSizeLB.text = [NSString stringWithFormat:@"%.1fMB", size];
        }]];
        
        [weakSelf presentViewController:ac animated:YES completion:nil];
        //========================== === ==========================
        
    }];
    
    // 关于我们
    [_aboutView setClickEvent:^{
      //  [AboutVC showTheAboutVC:@"关于我们" andTheDiff:100];
    }];
    
    // 帮助中心
    [_helpView setClickEvent:^{
       // [AboutVC showTheAboutVC:@"帮助中心" andTheDiff:200];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBack:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 退出登录
- (IBAction)Exit:(UIButton *)sender {
    
    [self showFunctionAlertWithTitle:nil message:@"确认退出吗？" functionName:@"确定" Handler:^{
        [USER cleanUserDataAndLogout];
        USER.isLogin = NO;
        [UDManager cleanTheLoginData];
        KUserNewNotiWithUserInfo(nil);
        [GLSettingVC gotoVCIfLogin:self];
        
        
    }];
}


@end

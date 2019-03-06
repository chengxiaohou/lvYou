//
//  OrderDetailVC.m
//  lvYou
//
//  Created by 小熊 on 2018/12/11.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "MKQIZOrderDetailVC.h"

@interface MKQIZOrderDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *textF1;
@property (weak, nonatomic) IBOutlet UITextField *textF2;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@end

@implementation MKQIZOrderDetailVC
+ (void)showTheOrderDetailVC:(NSDictionary *)parmter;
{
    MKQIZOrderDetailVC *order = [Worker MainSB:@"OrderDetailVC"];
    order.parmter = parmter;
    [Worker showVC:order];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:@"订单详情" leftText:nil rightTitle:nil showBackImg:YES];
    
    SetImageViewImageWithURL_C(_image1, _parmter[@"image"], PlaceHolderName);
    _label1.text = _parmter[@"des"];
    _label2.text = _parmter[@"price"];
    _label3.text = @"x1";
    
    _textF1.borderStyle = UITextBorderStyleNone;
    _textF2.borderStyle = UITextBorderStyleNone;
    _label4.text = [NSString stringWithFormat:@"预付总价格:%@",_parmter[@"price"]];
}

#pragma mark 确认
- (IBAction)toSure:(UIButton *)sender {
    
    if (_textF1.text.length == 0) {
        [MBProgressHUD showMessag:@"请填写联系人" toView:Window];
    }
    else if (_textF2.text.length == 0){
        [MBProgressHUD showMessag:@"请填写联系h方式" toView:Window];
    }
    else if (_textView.text.length == 0){
        [MBProgressHUD showMessag:@"请填写详细地址" toView:Window];
    }
    else{
        [MBProgressHUD showMessag:@"提交成功" toView:Window];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end

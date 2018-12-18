//
//  ZXDeatilVC.m
//  lvYou
//
//  Created by 小熊 on 2018/12/10.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "ZXDeatilVC.h"

@interface ZXDeatilVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@end

@implementation ZXDeatilVC
+ (void)showTheZXDeatilVC:(NSString *)url andTheName:(NSString *)name andTheDiff:(NSInteger)diff andTheDic:(NSDictionary *)dic
{
    ZXDeatilVC *detail = [Worker MainSB:@"ZXDeatilVC"];
    detail.url = url;
    detail.titleName = name;
    detail.diff = diff;
    detail.parmter = dic;
    [Worker showVC:detail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:@"" leftText:nil rightTitle:@"举报" showBackImg:YES];
   
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    _bottomViewHeight.constant = 0;
    _buyBtn.hidden = YES;
    if (_diff == 100) {
        _bottomViewHeight.constant = 50;
        _buyBtn.hidden = NO;
    }
    self.nav.delegate =self;
}
- (void)right
{
    [MBProgressHUD showMessag:@"感谢您的举报，我们审核人员将立马处理" toView:Window];
}
- (IBAction)shouCangBtn:(UIButton *)sender {
    
    
}

- (IBAction)juBaoBtn:(UIButton *)sender {
    [MBProgressHUD showMessag:@"感谢您的举报，我们会立马核实" toView:Window];

}
- (IBAction)onCommentBtn:(UIButton *)sender {
    [AdviceVC showTheAdviceVC:200];
}

#pragma mark 立即购买
- (IBAction)onBuy:(UIButton *)sender {
   
    [OrderDetailVC showTheOrderDetailVC:_parmter];
}


@end

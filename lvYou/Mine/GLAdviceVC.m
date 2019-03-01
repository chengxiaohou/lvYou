//
//  AdviceVC.m
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/6.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "GLAdviceVC.h"


#import "AppDelegate.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface GLAdviceVC ()<UITextViewDelegate,UIActionSheetDelegate>


@property (weak, nonatomic) IBOutlet UITextField *textF1;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *tishiLb;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;


@end

@implementation GLAdviceVC
{
    NSMutableString *_pics; //云返回回来的网址拼接

}

+(void)showTheAdviceVC:(NSInteger)diff
{
    GLAdviceVC *advice = [Worker MainSB:@"AdviceVC"];
    advice.diff = diff;
    [Worker showVC:advice];
}

- (IBAction)onBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    _pics = [[NSMutableString alloc] init];
 
    self.nav.hidden = YES;
    _textView.delegate = self;

    if (_diff == 200) {
        _titleName.text = @"我的评价";
        _tishiLb.text = @"请描述您的评价";
    }
    else{
        _titleName.text = @"投诉建议";
        _tishiLb.text = @"请详细描述您的问题，我们将不断改进....";
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHide)];
    [self.nav addGestureRecognizer:tap];
    
    [self configTheView];
}

- (void)configTheView
{
    _textF1.borderStyle = UITextBorderStyleNone;
   
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)onHide
{
    [_textView resignFirstResponder];
}


#pragma mark 发表

- (IBAction)tiJiao:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (_textView.text.length == 0) {
        if (_diff == 200) {
            [MBProgressHUD showMessag:@"请填写评论" toView:Window];
        }
        else{
        [MBProgressHUD showMessag:@"请填写意见反馈" toView:Window];
        }
        return;
    }
    else if (_textF1.text.length != 11)
    {
        [MBProgressHUD showMessag:@"请输入正确的手机号码" toView:Window];
        return;
    }
    else
    {
       
      
        [self postThePic:@{@"userId":@"1",@"describe":_textView.text,@"phone":_textF1.text}];
        
        
        
        
        
    }
}

- (void)postThePic:(NSDictionary *)parmter
{
    
       if (_diff == 200) {
           [MBProgressHUD showMessag:@"提交成功,等待审核成功后，我们将进行发布" toView:Window];
       }
       else{
        [MBProgressHUD showMessag:@"提交成功" toView:Window];
       }
        [self.navigationController popViewControllerAnimated:YES];
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)juBaoBtn:(UIButton *)sender {
    [MBProgressHUD showMessag:@"感谢您的举报，我们会立马核实" toView:Window];
}


@end

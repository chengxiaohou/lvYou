//
//  AdviceVC.h
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/6.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKAdviceVC : BaseVC
@property (nonatomic,assign) NSInteger diff;//100 建议  200 评价
+(void)showTheAdviceVC:(NSInteger)diff;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;

@end

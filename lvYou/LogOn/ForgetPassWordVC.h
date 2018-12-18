//
//  ForgetPassWordVC.h
//  shuiDianHui
//
//  Created by 小熊 on 2018/7/2.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
@interface ForgetPassWordVC : BaseVC
@property (nonatomic,assign) NSInteger diff;
+(void)showTheForgetPassWordVC:(NSInteger)diff; //100 登录进去的忘记密码  200修改密码
@end

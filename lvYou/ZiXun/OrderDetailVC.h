//
//  OrderDetailVC.h
//  lvYou
//
//  Created by 小熊 on 2018/12/11.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailVC : BaseVC
@property (nonatomic,strong) NSDictionary *parmter;
+ (void)showTheOrderDetailVC:(NSDictionary *)parmter;
@end

NS_ASSUME_NONNULL_END

//
//  ShoppingVC.h
//  lvYou
//
//  Created by 小熊 on 2018/12/10.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingVC : BaseVC
@property (nonatomic,assign) NSInteger diff;
+ (void)showTheShoppingVC:(NSInteger)diff;
@end

NS_ASSUME_NONNULL_END

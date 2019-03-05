//
//  DetaiVC.h
//  lvYou
//
//  Created by 小熊 on 2018/11/19.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKQIZDetaiVC : BaseVC
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) NSString *titleName;
+(void)showTheDetaiVC:(NSArray *)datas andTheName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

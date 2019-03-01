//
//  ZXDeatilVC.h
//  lvYou
//
//  Created by 小熊 on 2018/12/10.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GLZXDeatilVC : BaseVC
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *titleName;
@property (nonatomic,assign) NSInteger diff;//100是商品加载
@property (nonatomic,strong) NSDictionary *parmter;
+ (void)showTheZXDeatilVC:(NSString *)url andTheName:(NSString *)name andTheDiff:(NSInteger)diff andTheDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END

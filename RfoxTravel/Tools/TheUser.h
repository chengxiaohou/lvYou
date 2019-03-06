//
//  TheUser.h
//  QuanQiuBang
//
//  Created by 橙晓侯 on 16/1/6.
//  Copyright © 2016年 小马网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObj.h"

@interface TheUser : BaseObj

/** 登录状态 */
@property (nonatomic, assign) BOOL isLogin; //
/** ID (uid) */
@property (nonatomic,strong) NSString *ID;//
/*真实名字*/
@property (nonatomic, strong) NSString *realName;
/*红包使用状态*/
@property (nonatomic, assign) BOOL useStatus;//
/*余额*/
@property (nonatomic, strong) NSString *money;//
/*公司名*/
@property (nonatomic, strong) NSString *company;
/*是否是门店*/
@property (nonatomic, strong) NSString *beStores; //已成为门店
/*头像*/
@property (nonatomic, strong) NSString *headImg;
/*性别  0女 1男*/
@property (nonatomic, strong) NSString *sex;//
/*券余额*/
@property (nonatomic, assign) double hbMoney;

/*券名*/
@property (nonatomic, strong) NSString *hbName;
/*微信是否绑定*/
@property (nonatomic, assign) BOOL wxIsExit;//

/*邮箱*/
@property (nonatomic, strong) NSString *email;
/*手机号码*/
@property (nonatomic, strong) NSString *phone;//
/*用户状态 0可用 1不可用*/
@property (nonatomic, strong) NSString *userStatus;//
/*电话号码*/
@property (nonatomic, strong) NSString *telPhone;
/*用户类型 0用户  1商家  2技工*/
@property (nonatomic, strong) NSString *userType;//
/*昵称*/
@property (nonatomic, strong) NSString *nickName;
/*用户名*/
@property (nonatomic, strong) NSString *userName;//
/*是否实名*/
@property (nonatomic, strong) NSString *beCertification; //
@property (nonatomic, strong) NSString *certificationStatus;
@property (nonatomic, strong) NSString *brithday;
@property (nonatomic,strong) NSString *userToken;
@property (nonatomic,strong) NSString *loginPassword;
@property (nonatomic,strong) NSString *storesStatus;
@property (nonatomic, strong) NSString *profit;


@property (nonatomic, strong) NSString *skillStatus; //技能认证状态 0或null未认证 其他值为认证ID
@property (nonatomic, strong) NSString *skillImg; //技能图片
@property (nonatomic, strong) NSString *uid;//技工编号
@property (nonatomic, strong) NSString *skillName; //技能名称

@property (nonatomic, strong) NSString *userMechanic; //技工认证 0或null未认证 其他值技能ID
@property (nonatomic, strong) NSString *userScore; //评分星级

//========================== 以下方法是给单例USER用的，其余用户不要调用这些方法 ==========================

+ (TheUser *)user;
/** 退出并清空账号缓存 */
- (void)cleanTheLoginDataAndLogout;
//- (void)cleanUserDataAndLogout __attribute__((deprecated("Use cleanTheLoginDataAndLogout instead.「方法名表述有歧义」")));
/** 退出登录 不清空账号密码 */
- (void)logout;
/** 清空全部属性 */
- (void)cleanUserData;
/** 从缓存加载用户数据 */
- (BOOL)loadUserDataFromCache;
/** 缓存用户属性 */
- (void)cacheUserData;
/** 获取缓存的用户对象 */
- (TheUser *)getCacheUser;
/** 清空缓存的用户数据 */
- (void)cleanUserCacheData;
/** 是否置顶 */
//- (BOOL)isTop;

- (void)cleanUserDataAndLogout;
@end

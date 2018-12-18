//
//  TheUser.m
//  QuanQiuBang
//
//  Created by 橙晓侯 on 16/1/6.
//  Copyright © 2016年 小马网络. All rights reserved.
//

#import "UDManager.h"
#define UD [NSUserDefaults standardUserDefaults]

@implementation UDManager


+ (void)setLoginName:(NSString *)name password:(NSString *)password andTheToken:(NSString *)token andTheTag:(NSInteger)diff
{
    if (name) {
        [UD setObject:name forKey:@"name"];// name是手机号
    }
    if (password) {
        [UD setObject:password forKey:@"password"];
    }
    if (token) {
        [UD setValue:token forKey:@"token"];
    }
    
    [UD setInteger:diff forKey:@"tag"];
    
    [UD synchronize];
}


+ (void)setLoginPassword:(NSString *)password
{
    if (password)
    {
        [UD setObject:password forKey:@"password"];
    }
}

+ (void)cleanUserData
{
    [UD setObject:nil forKey:@"name"];// name是手机号
    [UD setObject:nil forKey:@"password"];
    [UD synchronize];
}

+ (void)cleanTheLoginData
{
    [UD setObject:nil forKey:@"name"];// name是手机号
    [UD setObject:nil forKey:@"password"];
    [UD synchronize];
}

+ (NSInteger)getTheDiff
{
    return [UD integerForKey:@"tag"];
}
+ (NSString *)getTheToken
{
    return [UD valueForKey:@"token"];
}
+ (NSString *)getUserName
{
    NSString * name = [UD objectForKey:@"name"];
    return name;
}

+ (NSString *)getUserPassword
{
    NSString * password = [UD objectForKey:@"password"];
    return password;
}

#pragma mark 第一次运行 （UUID保存）
+ (void)didFirstLaunch
{
    [UD setBool:YES forKey:@"isSecondLunch"];
    [self setUDID:[[NSUUID UUID] UUIDString]];
}

+ (BOOL)isSecondLaunch
{
    return [UD boolForKey:@"isSecondLunch"];
}

+ (void)setUDID:(NSString *)UDID
{
    [UD setValue:UDID forKey:@"UDID"];
}

+ (NSString *)getUDID
{
    return [UD valueForKey:@"UDID"];
}

+ (BOOL)GetLogin
{
    return [UD boolForKey:@"isLogin"];
}


+ (void)postMyBlackLias:(NSArray *)arr
{
    [UD setObject:arr forKey:@"blakList"];
    [UD synchronize];
}
+ (NSArray *)getMyBlackList
{
    return [UD valueForKey:@"blakList"];
}
+ (void)agreeTheXieYi:(NSInteger)tag
{
    [UD setObject:@(tag) forKey:@"xieYI"];
    [UD synchronize];
}
+ (NSInteger)agreeTheXieYi{
    return [[UD valueForKey:@"xieYI"] integerValue];
}

@end

//
//  AppDelegate.m
//  lvYou
//
//  Created by 小熊 on 2018/11/19.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    USER.isLogin = NO;
 
    if ([[UDManager getUserName] length] != 0) {
        [USER setIsLogin:YES];
        USER.phone = [UDManager getUserName];
        USER.nickName = @"喵小拖";
        USER.ID = @"1";
        USER.userName = @"喵小拖";
        USER.headImg = @"https://pic.qyer.com/avatar/009/10/94/99/200?v=1516673371";
        KUserNewNotiWithUserInfo(nil);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshOrder" object:@"0"];
        [MBProgressHUD showMessag:[NSString stringWithFormat:@"欢迎回来%@",USER.nickName] toView:Window];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

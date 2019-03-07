//### WS@H Project:YunWonHouse ###

//
//  UIImage+name.m
//  YunWonHouse
//
//  Created by GaoAng on 15/5/23.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "UIImage+name.h"
#import <objc/runtime.h>

@implementation UIImage(name)

static NSDictionary *imageNameReplaceDic;

static inline void af_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)load {
    [super load];
    af_swizzleSelector(self, @selector(imageNamed:), @selector(swizzling_imageNamed:));
}

+ (UIImage *)swizzling_imageNamed:(NSString *)name
{
    NSString *value = [imageNameReplaceDic valueForKey:name];
    UIImage *image = nil;
    NSString *realName = nil;
    
    if (value.length > 0)
    {
        realName = value;
    }
    else
    {
        realName = name;
    }
    // 优先查找改名的图
    image = [self swizzling_imageNamed:[NSString stringWithFormat:@"MMKK_%@",realName]];
    
    // 未找到图片，可能是少数不用改名的图
    if (image == nil)
        image = [self swizzling_imageNamed:realName];
    return image;
}

@end



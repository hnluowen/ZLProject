//
//  LLAppversionTool.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "LLAppversionTool.h"

@implementation LLAppversionTool

// 获取保存的上一个版本信息
+ (NSString *)dc_GetLastOneAppVersion {
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"AppVersion"];
}

// 保存新版本信息（偏好设置）
+ (void)dc_SaveNewAppVersion:(NSString *)version {
    
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"AppVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

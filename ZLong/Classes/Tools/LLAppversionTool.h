//
//  LLAppversionTool.h
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLAppversionTool : NSObject

/**
 *  获取之前保存的版本
 *
 *  @return NSString类型的AppVersion
 */
+ (NSString *)dc_GetLastOneAppVersion;
/**
 *  保存新版本
 */
+ (void)dc_SaveNewAppVersion:(NSString *)version;


@end

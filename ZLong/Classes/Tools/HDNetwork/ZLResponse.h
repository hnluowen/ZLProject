//
//  ZLResponse.h
//  ZLNetwork
//
//  Created by David on 2018/8/13.
//  Copyright © 2018年 Abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZLStatusCode) {
    ZLStatusCodeSuccess = 0000,  // 成功
};


@interface ZLResponse : NSObject

@property (nonatomic, assign) ZLStatusCode s;      //服务器状态码
@property (nonatomic, strong) NSString   *msg;   //返回信息
@property (nonatomic, assign) BOOL success;   //是否处理成功
@property (nonatomic, strong) id list;   //符合条件的信息

@end

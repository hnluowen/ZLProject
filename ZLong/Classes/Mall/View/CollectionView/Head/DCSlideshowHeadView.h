//
//  DCSlideshowHeadView.h
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLImgStatic.h"

typedef void(^ jumpClickBlock)(NSString *jumpURL);
@interface DCSlideshowHeadView : UICollectionReusableView
/* 轮播图数组 */
@property (copy , nonatomic)NSArray *imageGroupArray;
@property (copy , nonatomic)ZLImgStatic *sigleImage;

//点击图片跳转
@property (nonatomic, copy) jumpClickBlock jumpClick;

@end

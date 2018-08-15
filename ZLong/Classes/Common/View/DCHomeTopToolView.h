//
//  DCHomeTopToolView.h
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCHomeTopToolView : UIView
/** 右边Item + 点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
/** 右边第二个Item点击 人 */
@property (nonatomic, copy) dispatch_block_t rightRItemClickBlock;

/** 搜索按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t searchButtonClickBlock;

@end

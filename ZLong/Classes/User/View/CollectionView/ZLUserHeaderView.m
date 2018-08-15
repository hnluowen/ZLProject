//
//  ZLUserHeaderView.m
//  ZLong
//
//  Created by 刘星 on 2018/8/12.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLUserHeaderView.h"
@interface ZLUserHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *headBgView;

@end

@implementation ZLUserHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headBgView.layer.cornerRadius = 6.0f;
}

@end

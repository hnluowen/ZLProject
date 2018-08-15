//
//  ZLCouponCell.m
//  ZLong
//
//  Created by 刘星 on 2018/8/12.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLCouponCell.h"

@interface ZLCouponCell ()

@property (weak, nonatomic) IBOutlet UIImageView *couponBg;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ZLCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end

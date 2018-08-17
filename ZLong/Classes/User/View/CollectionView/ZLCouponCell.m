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

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 0) {
        _bigTitleLabel.text = @"虾券";
        _statusLabel.text = @"已消费";
        _couponBg.image = [UIImage imageNamed:@"p_4"];

    } else if (type == 1) {
        _bigTitleLabel.text = @"生虾";
        _statusLabel.text = @"已消费";

        _couponBg.image = [UIImage imageNamed:@"p_4"];

    } else if (type == 2) {
        _bigTitleLabel.text = @"生虾";
        _statusLabel.text = @"已体现";
        _couponBg.image = [UIImage imageNamed:@"p_3"];
        
    }
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",[self.showNum floatValue]];

}

@end

//
//  ZLUserHeaderView.m
//  ZLong
//
//  Created by 刘星 on 2018/8/12.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLUserHeaderView.h"
#import <UIImageView+WebCache.h>
#import "UIButton+Badge.h"
@interface ZLUserHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *headBgView;

@end

@implementation ZLUserHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headBgView.layer.cornerRadius = 6.0f;
}

- (void)setHeadUser:(ZLUserHome *)headUser {
    if (!headUser) {
        return;
    }
    _headUser = headUser;
    _isVipLabel.text = headUser.vip?@"中龙VIP":@"普通会员";
    _nickLabel.text = headUser.userInfo.nick;
    _loginNameLabel.text = headUser.userInfo.loginname;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:headUser.userInfo.headurl] placeholderImage:nil];
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2.0;
    _headImageView.layer.masksToBounds = YES;
<<<<<<< HEAD
//    [self setUpBaseBageButtons:@[_shopCarButton,_orderButton,_collectionButton,_carBagButton]];
//
//    _shopCarButton.badgeValue = headUser.cardNum;
//    _orderButton.badgeValue = headUser.orderNum;
//    _collectionButton.badgeValue = headUser.favoriteNum;
//    _carBagButton.badgeValue = headUser.couponsNum;
    
}

- (void)setUpBaseBageButtons:(NSArray *)btnArray {
    for (UIButton *button in btnArray) {
        button.badgeBGColor = [UIColor dc_colorWithHexString:@"#f23023"];
        button.badgeTextColor = [UIColor dc_colorWithHexString:@"#f23023"];
//        button.shouldAnimateBadge = YES;
        button.shouldHideBadgeAtZero = YES;
        button.badgeOriginY = -9;
    }
=======
    
    _carBageBtn.hidden = [headUser.cardNum integerValue] > 0 ? NO : YES;
    _orderBageBtn.hidden = [headUser.orderNum integerValue] > 0 ? NO : YES;
    _scBageBtn.hidden = [headUser.favoriteNum integerValue] > 0 ? NO : YES;
    _bagBageBtn.hidden = [headUser.couponsNum integerValue] > 0 ? NO : YES;

    [_carBageBtn setTitle:[NSString stringWithFormat:@"%@",headUser.cardNum] forState: UIControlStateNormal];
    [_orderBageBtn setTitle:[NSString stringWithFormat:@"%@",headUser.orderNum] forState: UIControlStateNormal];
    [_scBageBtn setTitle:[NSString stringWithFormat:@"%@",headUser.favoriteNum] forState: UIControlStateNormal];
    [_bagBageBtn setTitle:[NSString stringWithFormat:@"%@",headUser.couponsNum] forState: UIControlStateNormal];

>>>>>>> f86c8d9105cbb91a9d7f4feb0053899a0e851fa8
}


- (IBAction)clickEdit:(UIButton *)sender {
}
- (IBAction)clickUpVip:(id)sender {
}
- (IBAction)clickUpParter:(id)sender {
}

- (IBAction)clickGoShopCar:(UIButton *)sender {
}

- (IBAction)clickCollection:(UIButton *)sender {
}
- (IBAction)clickCarBag:(UIButton *)sender {
}
- (IBAction)clickOrder:(UIButton *)sender {
}


@end

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
    _shopCarButton.badgeValue = headUser.cardNum;
    _orderButton.badgeValue = headUser.orderNum;
    _collectionButton.badgeValue = headUser.favoriteNum;
    _carBagButton.badgeValue = headUser.couponsNum;
    
    [self setUpBaseBageButtons:@[_shopCarButton,_orderButton,_collectionButton,_carBagButton]];
}

- (void)setUpBaseBageButtons:(NSArray *)btnArray {
    for (UIButton *button in btnArray) {
        button.badgeBGColor = [UIColor clearColor];
        button.shouldHideBadgeAtZero = YES;
        button.badgeTextColor = [UIColor dc_colorWithHexString:@"#f23023"];
        button.badgeOriginY = -9;
//        button.badgeFont = [UIFont systemFontOfSize:9];
    }
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

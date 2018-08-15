//
//  DCTimeShopCell.m
//  ZLong
//
//  Created by 刘星 on 2018/8/5.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "DCTimeShopCell.h"
#import <UIImageView+WebCache.h>

@implementation DCTimeShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(ZLCommodity *)data {
    if (!data) {
        return;
    }
    _data = data;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL_IMG,_data.imgUrl]] placeholderImage:nil];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f+%.2f",[_data.price floatValue],[_data.lqPrice floatValue]];
}

@end

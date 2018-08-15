//
//  DCGoodsPlusCellCollectionViewCell.m
//  ZLong
//
//  Created by 刘星 on 2018/8/5.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "DCGoodsPlusCell.h"
#import <UIImageView+WebCache.h>
#import "ZLCommodity.h"

@interface DCGoodsPlusCell()


@end

@implementation DCGoodsPlusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataArray:(NSArray *)dataArray {
    if (!dataArray) return;
    _dataArray = dataArray;
    NSString *imageName = @"lxzq";
    if (_sortNum == 1) {
        imageName = @"xp";
    } else if (_sortNum == 2) {
        imageName = @"xx";
    } else {
        imageName = @"tt";
    }
    _markImage.image = [UIImage imageNamed:imageName];
    ZLCommodity *data = [_dataArray objectAtIndex:0];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL_IMG,data.imgUrl]] placeholderImage:nil];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f+%.2f",[data.price floatValue],[data.lqPrice floatValue]];
    
    ZLCommodity *data2 = [_dataArray objectAtIndex:1];
    [_imgView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL_IMG,data2.imgUrl]] placeholderImage:nil];
    _price2Label.text = [NSString stringWithFormat:@"%.2f+%.2f",[data2.price floatValue],[data2.lqPrice floatValue]];

    NSLog(@"111:%@  222:%@",data.imgUrl,data2.imgUrl);
    
}





@end

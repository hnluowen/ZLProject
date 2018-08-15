//
//  DCTimeShopCell.h
//  ZLong
//
//  Created by 刘星 on 2018/8/5.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLCommodity.h"
@interface DCTimeShopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong,nonatomic) ZLCommodity *data;
@end

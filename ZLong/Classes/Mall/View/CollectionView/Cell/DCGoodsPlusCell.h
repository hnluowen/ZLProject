//
//  DCGoodsPlusCellCollectionViewCell.h
//  ZLong
//
//  Created by 刘星 on 2018/8/5.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCGoodsPlusCell : UICollectionViewCell
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,assign) NSInteger sortNum;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *markImage;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UILabel *price2Label;

@end

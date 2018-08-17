//
//  ZLUserHeaderView.h
//  ZLong
//
//  Created by 刘星 on 2018/8/12.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLUserHome.h"
@interface ZLUserHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *isVipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (nonatomic,strong) ZLUserHome *headUser;

@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopCarButton;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *carBagButton;
@property (weak, nonatomic) IBOutlet UIButton *carBageBtn;
@property (weak, nonatomic) IBOutlet UIButton *orderBageBtn;
@property (weak, nonatomic) IBOutlet UIButton *scBageBtn;
@property (weak, nonatomic) IBOutlet UIButton *bagBageBtn;

@end

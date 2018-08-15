//
//  DCMsgFootView.h
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLListNews.h"
@interface DCMsgFootView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel2;
@property (strong,nonatomic) NSArray *listNews;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel2;
@end

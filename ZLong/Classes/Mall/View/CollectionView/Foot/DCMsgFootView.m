//
//  DCMsgFootView.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "DCMsgFootView.h"

@implementation DCMsgFootView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setListNews:(NSArray *)listNews {
    if (!listNews) {
        return;
    }
    _listNews = listNews;
    ZLListNews *news = listNews[0];
    _msgLabel.text = [NSString stringWithFormat:@"%@",news.title];
    _timeLabel.text = [NSString stringWithFormat:@"%@",news.creatDate];
    ZLListNews *news2 = listNews[1];
    _msgLabel2.text = [NSString stringWithFormat:@"%@",news2.title];
    _timeLabel2.text = [NSString stringWithFormat:@"%@",news2.creatDate];

}

@end

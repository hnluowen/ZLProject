//
//  ZLBonusCarHeaderView.m
//  ZLong
//
//  Created by 刘星 on 2018/8/12.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLBonusCarHeaderView.h"
#import "XLCardSwitch.h"

@interface ZLBonusCarHeaderView() <XLCardSwitchDelegate>
@property (nonatomic,strong) XLCardSwitch *cardSwitch;
@end

@implementation ZLBonusCarHeaderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    NSMutableArray *items = [NSMutableArray new];
    XLCardItem *item1 = [[XLCardItem alloc] init];
    item1.title = @"虾苗库存";
    item1.imageName = @"h_1";
    [items addObject:item1];
    XLCardItem *item2 = [[XLCardItem alloc] init];
    item2.title = @"生虾库存";
    item2.imageName = @"h_2";
    [items addObject:item2];
    XLCardItem *item3 = [[XLCardItem alloc] init];
    item3.title = @"虾劵余额";
    item3.imageName = @"h_3";
    [items addObject:item3];


    //设置卡片浏览器
    _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 427-64)];
    _cardSwitch.items = items;
    _cardSwitch.delegate = self;
    //分页切换
    _cardSwitch.pagingEnabled = false;
    //设置初始位置，默认为0
    _cardSwitch.selectedIndex = 1;
    [self addSubview:_cardSwitch];

}

#pragma mark -
#pragma mark CardSwitchDelegate

- (void)XLCardSwitchDidSelectedAt:(NSInteger)index {
    NSLog(@"选中了：%zd",index);
    
    //更新背景图
}


@end

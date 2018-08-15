//
//  DCTopLineFootView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCTopLineFootView.h"

// Controllers

// Models

// Views
#import "DCTitleRolling.h"
// Vendors

// Categories
#import <UIImageView+WebCache.h>
// Others

@interface DCTopLineFootView ()<UIScrollViewDelegate,CDDRollingDelegate>

/* 滚动 */
@property (strong , nonatomic)DCTitleRolling *numericalScrollView;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;

@end

@implementation DCTopLineFootView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        [self setUpBase];
        
    }
    return self;
}

- (void)setUpUI
{
    

    //初始化
    _numericalScrollView = [[DCTitleRolling alloc] initWithFrame:CGRectMake(0, 0, self.dc_width, 68) WithTitleData:^(CDDRollingGroupStyle *rollingGroupStyle, NSString *__autoreleasing *leftImage, NSArray *__autoreleasing *rolTitles, NSArray *__autoreleasing *rolTags, NSArray *__autoreleasing *rightImages, NSString *__autoreleasing *rightbuttonTitle, NSInteger *interval, float *rollingTime, NSInteger *titleFont, UIColor *__autoreleasing *titleColor, BOOL *isShowTagBorder) {
        
        *rollingTime = 0.25;
        *rolTags = @[@"冬季健康日",@"新手上路",@"年终内购会",@"GitHub星星走一波"];
        *rolTitles = @[@"先领券在购物，一元抢？",@"2000元热门手机推荐",@"好奇么？点进去哈",@"这套家具比房子还贵"];
        *leftImage = @"shouye_img_toutiao";
        *interval = 6.0;
        *titleFont = 14;
        *isShowTagBorder = YES;
        *titleColor = [UIColor darkGrayColor];
    }];
    
    _numericalScrollView.moreClickBlock = ^{
        NSLog(@"mall----more");
    };
    
    [_numericalScrollView dc_beginRolling];
    _numericalScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_numericalScrollView];
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = DCBGColor;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.dc_height - 8, ScreenW, 8);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)setUpBase
{
    self.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - Setter Getter Methods

#pragma mark - 滚动条点击事件

- (void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%zd头条滚动条",index);
}

@end

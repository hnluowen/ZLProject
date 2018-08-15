//
//  DCSlideshowHeadView.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "DCSlideshowHeadView.h"

// Controllers

// Models
#import "ZLImgStatic.h"
// Views

// Vendors
#import <SDCycleScrollView.h>
#import <UIImageView+WebCache.h>

// Categories

// Others

@interface DCSlideshowHeadView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;

/* 底部广告宣传图片 */
@property (strong , nonatomic)UIImageView *bottomAdImageView;

@end

@implementation DCSlideshowHeadView

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
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, 220) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    [self addSubview:_cycleScrollView];
    
    //bottom AD image
    _bottomAdImageView = [[UIImageView alloc] init];
    _bottomAdImageView.contentMode = UIViewContentModeScaleAspectFill   ;
    [self addSubview:_bottomAdImageView];

    
}

- (void)setSigleImage:(ZLImgStatic *)sigleImage {
    if (!sigleImage) {
        return;
    }
    _sigleImage = sigleImage;
    
    [_bottomAdImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL_IMG,_sigleImage.imgUrl]]];

}

- (void)setImageGroupArray:(NSArray *)imageGroupArray
{
    _imageGroupArray = imageGroupArray;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"default_160"];
    if (imageGroupArray.count == 0) return;
    NSMutableArray *imageURLArray = [NSMutableArray arrayWithCapacity:100];
    for (ZLImgStatic *imgStatic in _imageGroupArray) {
        [imageURLArray addObject:[NSString stringWithFormat:@"%@%@",BASEURL_IMG,imgStatic.imgUrl]];
    }
    _cycleScrollView.imageURLStringsGroup = imageURLArray;
    
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ZLImgStatic *imgStatic = _imageGroupArray[index];
    !_jumpClick?:_jumpClick(imgStatic.commodityUrl);
    
    NSLog(@"点击了%@轮播图",imgStatic.commodityUrl);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    WEAKSELF
    [_bottomAdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(weakSelf.cycleScrollView.mas_bottom);
        make.width.mas_equalTo(self);
        [make.bottom.mas_equalTo(self)setOffset:-10];
    }];

    
}

#pragma mark - Setter Getter Methods


@end

//
//  DCHomeTopToolView.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "DCHomeTopToolView.h"
@interface DCHomeTopToolView ()

/* 右边Item */
@property (strong , nonatomic)UIButton *rightItemButton;
/* 右边第二个Item */
@property (strong , nonatomic)UIButton *rightRItemButton;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
/* 通知 */
@property (weak ,nonatomic) id dcObserve;
@end

@implementation DCHomeTopToolView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        [self acceptanceNote];
    }
    return self;
}

- (void)setUpUI
{
    _rightItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
//        button.backgroundColor = [UIColor blueColor];
        button;
    });
    
    _rightRItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"friends list"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightRButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
//        button.backgroundColor = [UIColor grayColor];

        button;
    });
    [self addSubview:_rightItemButton];
    [self addSubview:_rightRItemButton];
    
    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    [self.layer addSublayer:layer];
    
    _topSearchView = [[UIView alloc] init];
//    _topSearchView.backgroundColor = [UIColor redColor];

    _topSearchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    _topSearchView.layer.cornerRadius = 5;
    [_topSearchView.layer masksToBounds];
    [self addSubview:_topSearchView];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"请输入您要搜索的商品" forState:0];
    [_searchButton setTitleColor:[UIColor whiteColor] forState:0];
    _searchButton.titleLabel.font = PFR12Font;
    [_searchButton setImage:[UIImage imageNamed:@"search"] forState:0];
    [_searchButton setImage:[UIImage imageNamed:@"search"] forState:1];

    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //-----
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, _searchButton.titleLabel.frame.size.width+10, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_topSearchView addSubview:_searchButton];
    
    
}

#pragma mark - 接受通知
- (void)acceptanceNote
{
    //滚动到详情
    WEAKSELF
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:@"SHOWTOPTOOLVIEW" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        weakSelf.backgroundColor = [UIColor whiteColor];
        weakSelf.topSearchView.backgroundColor = RGB(240, 240, 240);
//        [weakSelf.rightItemButton setImage:[UIImage imageNamed:@"shouye_icon_sort_gray"] forState:0];
//        [weakSelf.rightRItemButton setImage:[UIImage imageNamed:@"icon_gouwuche_title_gray"] forState:0];
    }];
    
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:@"HIDETOPTOOLVIEW" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.backgroundColor = [UIColor clearColor];
        weakSelf.topSearchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//        [weakSelf.rightItemButton setImage:[UIImage imageNamed:@"shouye_icon_sort_white"] forState:0];
//        [weakSelf.rightRItemButton setImage:[UIImage imageNamed:@"icon_gouwuche_title_white"] forState:0];
    }];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    WEAKSELF
    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@34);
        make.width.equalTo(@34);
    }];
    
    [_rightRItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.rightItemButton.mas_centerY);
        make.right.equalTo(weakSelf.rightItemButton.mas_left).offset(-5);
        make.height.equalTo(@34);
        make.width.equalTo(@34);
    }];
    
    [_topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.mas_left)setOffset:10];
        [make.right.mas_equalTo(weakSelf.rightRItemButton.mas_left)setOffset:-20];
        make.height.mas_equalTo(@(32));
        make.centerY.equalTo(weakSelf.rightItemButton.mas_centerY);

    }];
    
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.topSearchView);
        make.top.mas_equalTo(weakSelf.topSearchView);
        make.height.mas_equalTo(weakSelf.topSearchView);
        [make.right.mas_equalTo(weakSelf.topSearchView)setOffset:-2*2];

    }];
    
}

#pragma mark - 消失
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
}
#pragma 自定义右边导航Item点击
- (void)rightButtonItemClick {
    !_rightItemClickBlock ? : _rightItemClickBlock();
}

#pragma 自定义左边导航Item点击

#pragma mark - 自定义右边第二个导航Item点击
- (void)rightRButtonItemClick
{
    !_rightRItemClickBlock ? : _rightRItemClickBlock();
}

#pragma mark - 搜索按钮点击
- (void)searchButtonClick
{
    !_searchButtonClickBlock ? : _searchButtonClickBlock();
}





@end

//
//  DCGoodsGridCell.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "DCGoodsGridCell.h"

// Controllers

// Models
#import "DCGridItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories
#import "UIView+DCRolling.h"
#import "UIColor+DCColorChange.h"
// Others

@interface DCGoodsGridCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *gridImageView;
/* gridLabel */
@property (strong , nonatomic)UILabel *gridLabel;
/* tagLabel */
@property (strong , nonatomic)UILabel *tagLabel;

@end

@implementation DCGoodsGridCell

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
    _gridImageView = [[UIImageView alloc] init];
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR12Font;
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    _gridLabel.textColor = [UIColor dc_colorWithHexString:@"#333333"];
    [self addSubview:_gridLabel];
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:8];
    _tagLabel.backgroundColor = [UIColor clearColor];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tagLabel];
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self)setOffset:10];
        if (iphone5) {
            make.size.mas_equalTo(CGSizeMake(26, 26));
        }else{
            make.size.mas_equalTo(CGSizeMake(26, 26));
        }
        make.centerX.mas_equalTo(self);
    }];
    WEAKSELF
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(weakSelf.gridImageView.mas_bottom)setOffset:5];
    }];
    
    
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.gridImageView.mas_centerX);
        make.top.mas_equalTo(weakSelf.gridImageView);
        make.size.mas_equalTo(CGSizeMake(35, 15));
    }];
    
}

#pragma mark - Setter Getter Methods
- (void)setGridItem:(DCGridItem *)gridItem
{
    _gridItem = gridItem;
    
    
    _gridLabel.text = gridItem.gridTitle;
    _tagLabel.text = gridItem.gridTag;
    
    _tagLabel.hidden = (gridItem.gridTag.length == 0) ? YES : NO;
    _tagLabel.textColor = [UIColor dc_colorWithHexString:gridItem.gridColor];
    [DCSpeedy dc_chageControlCircularWith:_tagLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:_tagLabel.textColor canMasksToBounds:YES];
    
    if (_gridItem.iconImage.length == 0) return;
    if ([[_gridItem.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        
        [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        _gridImageView.image = [UIImage imageNamed:_gridItem.iconImage];
    }
}

@end

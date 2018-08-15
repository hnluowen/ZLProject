//
//  ZLBonusViewController.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLBonusViewController.h"
#import "ZLBonusCarHeaderView.h"
#import "ZLBonusItemViewCell.h"
@interface ZLBonusViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@end

static NSString *const ZLBonusCarHeaderViewID = @"ZLBonusCarHeaderView";

@implementation ZLBonusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];

}

#pragma mark - initialize
- (void)setUpBase
{
    self.title = @"红利";
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor dc_colorWithHexString:@"#f5f5f5"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 64, ScreenW, ScreenH - 49-64);
        _collectionView.showsVerticalScrollIndicator = NO;
        
        //注册 CELL
        [_collectionView registerNib:[UINib nibWithNibName:@"ZLBonusItemViewCell" bundle:nil] forCellWithReuseIdentifier:@"ZLBonusItemViewCell"];
        //注册 Header
        [_collectionView registerClass:[ZLBonusCarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZLBonusCarHeaderViewID];

        //注册 Footer
        
        
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
//    } else if (section == 1) {
//        return 1;
//    } else if (section == 2) {
//        return 1;
//    }
    
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//8
        ZLBonusItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLBonusItemViewCell" forIndexPath:indexPath];
        gridcell = cell;
        
    } else if (indexPath.section == 1) {
    } else if (indexPath.section == 2) {
        
    }
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            ZLBonusCarHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZLBonusCarHeaderViewID forIndexPath:indexPath];
//            header.backgroundColor = [UIColor redColor];
            reusableview = header;
        }
        
    }
    if (kind == UICollectionElementKindSectionFooter) {
    }
    
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenW , 127);
    }
    return CGSizeZero;
}



#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(ScreenW, 427-64); //图片滚动的宽高
    } 
    return CGSizeZero;
}

#pragma mark - in间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1 ) {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return UIEdgeInsetsZero;
}

#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0 ) {
        return 10.0f;
    }
    return 0;
}



@end

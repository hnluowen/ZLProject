//
//  ZLUserViewController.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLUserViewController.h"
#import "ZLUserHeaderView.h"
#import "DCHomeRefreshGifHeader.h"
#import "DCGoodsGridCell.h"
#import "ZLCouponCell.h"
#import "DCGridItem.h"
#import "ZLUserHome.h"
@interface ZLUserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 8图标属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;

@property (strong , nonatomic)ZLUserHome *userHome;

@end

static NSString *const ZLUserHeaderViewID = @"ZLUserHeaderView";
static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
static NSString *const ZLCouponCellID = @"ZLCouponCell";

@implementation ZLUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    [self setUpGoodsData];
    [self setUpGIFRrfresh];
}

#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    self.collectionView.mj_header = [DCHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
    [self.collectionView.mj_header beginRefreshing];

}


#pragma mark - 刷新
- (void)setUpRecData
{
    WEAKSELF
    [DCSpeedy dc_callFeedback]; //触动
    
    [ZLNetwork POSTWithURL:API_UserCenter parameters:nil callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
        [weakSelf.collectionView.mj_header endRefreshing];
        
        if (!responseObject.success && !responseObject) {
            //数据请求失败
            return ;
        }
        
        if (responseObject.s == ZLStatusCodeSuccess) {
            weakSelf.userHome = [ZLUserHome mj_objectWithKeyValues:responseObject.list];
            [weakSelf.collectionView reloadData];
        }

           
        
    }];
    
}


#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 49);
        _collectionView.showsVerticalScrollIndicator = NO;
        
        //注册 CELL
        [_collectionView registerClass:[DCGoodsGridCell class] forCellWithReuseIdentifier:DCGoodsGridCellID];
        [_collectionView registerNib:[UINib nibWithNibName:@"ZLCouponCell" bundle:nil] forCellWithReuseIdentifier:ZLCouponCellID];
        //注册 Header
        [_collectionView registerNib:[UINib nibWithNibName:@"ZLUserHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZLUserHeaderViewID];

        //注册 Footer
        
        
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
    
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = [UIColor dc_colorWithHexString:@"#f5f5f5"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

#pragma mark - 加载数据
#pragma mark - 加载数据
- (void)setUpGoodsData
{
    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"PersonsGrid.plist"];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //8属性
        return _gridItem.count;
    } else if (section == 1) {
        return 3;
    }
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//8
        DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];

        gridcell = cell;
        
    } else if (indexPath.section == 1) {
        ZLCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZLCouponCellID forIndexPath:indexPath];
        gridcell = cell;
    }

    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            ZLUserHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZLUserHeaderViewID forIndexPath:indexPath];
            headerView.headUser = self.userHome;
            reusableview = headerView;
        }
        
    }
    if (kind == UICollectionElementKindSectionFooter) {
    }
    
    return reusableview;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if (section == 1 ) {
        return 10.0f;
    }
    return 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1 ) {
        return 10.0f;
    }
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1 ) {
        return UIEdgeInsetsMake(9, 9, 9, 9);
    }
    return UIEdgeInsetsZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10
        
        NSLog(@"点击了10个属性第%zd",indexPath.row);
    }
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//9宫格组
        return CGSizeMake((ScreenW)/4.0 , 70);
    } else if (indexPath.section == 1) {
        NSLog(@"--++++  %f %f",ScreenW,(ScreenW-40)/3.0);
        return CGSizeMake((ScreenW-40)/3.0, 113);
    }
    return CGSizeZero;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(ScreenW, 317); //图片滚动的宽高
    } else if (section == 2) {
        return CGSizeMake(ScreenW, 35);
    }
    return CGSizeZero;
}


@end

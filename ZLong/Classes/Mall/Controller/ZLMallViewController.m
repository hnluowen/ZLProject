//
//  ZLMallViewController.m
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLMallViewController.h"
#import "ZLLoginViewController.h"
#import "ZLRegisterViewController.h"
#import "ZLAppendViewController.h"
#import "DCGridItem.h"
#import "DCRecommendItem.h"
#import "DCHomeTopToolView.h"

#import "DCGoodsGridCell.h"
#import "DCGoodsPlusCell.h"
#import "DCTimeShopCell.h"
#import "DCLifeShopCell.h"

#import "DCSlideshowHeadView.h"
#import "DCTimeShopHeadView.h"
#import "DCLifeHeadView.h"

#import "DCTopLineFootView.h"
#import "DCMsgFootView.h"
#import "DCOverFootView.h"
#import "DCHomeRefreshGifHeader.h"

#import "ZLHomeModel.h"
#import "ZLListNews.h"
@interface ZLMallViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 8图标属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *youLikeItem;

@property (strong , nonatomic)NSArray<DCGridItem *> *lifeItem;

/* 顶部工具View */
@property (nonatomic, strong) DCHomeTopToolView *topToolView;

@property (nonatomic, strong) NSArray *commodityArray;
@property (nonatomic, strong) NSArray *lunPicArray;
@property (nonatomic, strong) ZLImgStatic *singleImage;
@property (nonatomic, strong) NSArray *hotArray;
@property (nonatomic, strong) NSArray *listNewsArray;
@property (nonatomic, strong) NSArray *hotComArray;

@end

static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
static NSString *const DCGoodsPlusCellID = @"DCGoodsPlusCellID";
static NSString *const DCTimeShopCellID = @"DCTimeShopCell";
static NSString *const DCLifeShopCellID = @"DCLifeShopCell";

static NSString *const DCOverFootViewID = @"DCOverFootView";
static NSString *const DCMsgFootViewID = @"DCMsgFootViewID";
static NSString *const DCTopLineFootViewID = @"DCTopLineFootView";

static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
static NSString *const DCTimeShopHeadViewID = @"DCTimeShopHeadView";
static NSString *const DCLifeHeadViewID = @"DCLifeHeadView";


@implementation ZLMallViewController

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
        [_collectionView registerNib:[UINib nibWithNibName:@"DCGoodsPlusCell" bundle:nil] forCellWithReuseIdentifier:DCGoodsPlusCellID];
        [_collectionView registerNib:[UINib nibWithNibName:@"DCTimeShopCell" bundle:nil] forCellWithReuseIdentifier:DCTimeShopCellID];
        [_collectionView registerNib:[UINib nibWithNibName:@"DCLifeShopCell" bundle:nil] forCellWithReuseIdentifier:DCLifeShopCellID];

        //注册 Header
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerNib:[UINib nibWithNibName:@"DCTimeShopHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCTimeShopHeadViewID];
        [_collectionView registerNib:[UINib nibWithNibName:@"DCLifeHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCLifeHeadViewID];

        //注册 Footer
        [_collectionView registerClass:[DCOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID];
        [_collectionView registerNib:[UINib nibWithNibName:@"DCMsgFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCMsgFootViewID];
        [_collectionView registerClass:[DCTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID];



        [self.view addSubview:_collectionView];
    }
    return _collectionView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    [self setUpGoodsData];

    [self setUpNavTopView];
    
    [self setUpGIFRrfresh];

}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

#pragma mark - 加载数据
- (void)setUpGoodsData
{
    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    _lifeItem = [DCGridItem mj_objectArrayWithFilename:@"LifeItem.plist"];
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
    
    [ZLNetwork POSTWithURL:API_HOME parameters:nil callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
        [weakSelf.collectionView.mj_header endRefreshing];

        ZLHomeModel *homeData = [ZLHomeModel mj_objectWithKeyValues:responseObject.list];
        weakSelf.commodityArray = @[homeData.lqCommoditys,homeData.xinCommoditys,homeData.zlCommoditys,homeData.ttCommoditys];
        weakSelf.lunPicArray = homeData.carouselList;
        weakSelf.singleImage = homeData.ImgStatic;
        weakSelf.hotArray = homeData.hotCommoditys;
        weakSelf.listNewsArray = homeData.listNewS;
        [weakSelf.collectionView reloadData];
    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
//    });
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[DCHomeTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
//    _topToolView.backgroundColor = [UIColor yellowColor];
    WEAKSELF
    _topToolView.rightItemClickBlock = ^{
        NSLog(@"点击了首页分类");
        ZLLoginViewController *dcLoginVc = [[ZLLoginViewController alloc] init];
        [weakSelf.navigationController presentViewController:dcLoginVc animated:YES completion:nil];
    };
    _topToolView.rightRItemClickBlock = ^{
        NSLog(@"点击了首页购物车");
//        TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.233.com"]];
//        [weakSelf.navigationController pushViewController:webViewController animated:YES];
        ZLAppendViewController *appendVC = [[ZLAppendViewController alloc] init];
        [weakSelf.navigationController pushViewController:appendVC animated:YES];
    };
    _topToolView.searchButtonClickBlock = ^{
        NSLog(@"点击了首页搜索");
    };
    [self.view addSubview:_topToolView];
    
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //8属性
        return _gridItem.count;
    } else if (section == 1) { //4商品模块
        return 4;
    } else if (section == 2) {
        return 3;
    } else if (section == 3) {
        return 4;
    }

    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//8
        DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        
        if (indexPath.row > 3) {
            cell.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];

        } else {
            cell.backgroundColor = [UIColor whiteColor];
        }
        gridcell = cell;
        
    } else if (indexPath.section == 1) {
        DCGoodsPlusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsPlusCellID forIndexPath:indexPath];
        if (_commodityArray) {
            cell.dataArray = [_commodityArray objectAtIndex:indexPath.row];
        }
        cell.sortNum = indexPath.row;
        gridcell = cell;
    } else if (indexPath.section == 2) {
        DCTimeShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCTimeShopCellID forIndexPath:indexPath];
        cell.data = [self.hotArray objectAtIndex:indexPath.row];
        gridcell = cell;

    } else if (indexPath.section == 3) {
        DCLifeShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCLifeShopCellID forIndexPath:indexPath];
        DCGridItem *item = [_lifeItem objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:item.iconImage];
        gridcell = cell;

    }
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            DCSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
            headerView.sigleImage = self.singleImage;
            headerView.imageGroupArray = self.lunPicArray;
            WEAKSELF
            [headerView setJumpClick:^(NSString *jumpURL) {
                TOWebViewController *web = [[TOWebViewController alloc] initWithURLString:jumpURL];
                [weakSelf.navigationController pushViewController:web animated:YES];
            }];
            reusableview = headerView;
        } else if (indexPath.section == 2) {
            DCTimeShopHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCTimeShopHeadViewID forIndexPath:indexPath];
            
            reusableview = headerView;

        } else if (indexPath.section == 3) {
            DCLifeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCLifeHeadViewID forIndexPath:indexPath];
            reusableview = headerView;

        }
        
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
//
            DCMsgFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCMsgFootViewID forIndexPath:indexPath];
            footView.listNews = self.listNewsArray;
            reusableview = footView;
        } else if (indexPath.section == 3) {
            DCOverFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID forIndexPath:indexPath];
            
            reusableview = footView;

        }
    }
    
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//9宫格组
        return CGSizeMake((ScreenW)/4.0 , 70);
    } else if (indexPath.section == 1) {
        return CGSizeMake(ScreenW/2.0, 140);
    } else if (indexPath.section == 2) {
        return CGSizeMake((ScreenW-40)/3, 137);
    } else if (indexPath.section == 3) {
        return CGSizeMake((ScreenW-30)/2, 90);
    }
    return CGSizeZero;
}



#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(ScreenW, 332); //图片滚动的宽高
    } else if (section == 2) {
        return CGSizeMake(ScreenW, 35);
    } else if (section == 3) {
        return CGSizeMake(ScreenW, 35);
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenW, 68);
    } else if (section == 3) {
        return CGSizeMake(ScreenW, 20);
    }
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if (section == 3 ) {
        return 10.0f;
    }
    return 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 3 ) {
        return 10.0f;
    }
    return 0;
}

#pragma mark - in间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 3 ) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10
        
        NSLog(@"点击了10个属性第%zd",indexPath.row);
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > 44) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SHOWTOPTOOLVIEW" object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HIDETOPTOOLVIEW" object:nil];
    }

}


@end

//
//  ZLHomeModel.h
//  ZLong
//
//  Created by David on 2018/8/14.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLImgStatic.h"
@interface ZLHomeModel : NSObject
@property (nonatomic,strong) NSArray *listNewS; //消息通知集合,封装消息实体类(news)
@property (nonatomic,strong) NSArray *zlCommoditys; //中龙心选商品集合,封装商品实体类 (commodity)
@property (nonatomic,strong) NSArray *lqCommoditys; //虾券专区商品集合,封装商品实体类
@property (nonatomic,strong) NSArray *xinCommoditys; //新品首发商品集合,封装商品实体类
@property (nonatomic,strong) NSArray *ttCommoditys; //天天特惠商品集合,封装商品实体类
@property (nonatomic,strong) NSArray *hotCommoditys; //限时疯抢商品集合,封装商品实体类
@property (nonatomic,strong) ZLImgStatic *ImgStatic; //静态广告图
@property (nonatomic,strong) NSArray *carouselList; //动态广告图实体类集合

@property (nonatomic,strong) NSString *ImgUrl;
@end

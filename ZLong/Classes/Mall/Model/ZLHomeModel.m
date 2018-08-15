//
//  ZLHomeModel.m
//  ZLong
//
//  Created by David on 2018/8/14.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLHomeModel.h"

@implementation ZLHomeModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"listNewS" : @"ZLListNews",
             @"zlCommoditys" : @"ZLCommodity",
             @"lqCommoditys" : @"ZLCommodity",
             @"xinCommoditys" : @"ZLCommodity",
             @"ttCommoditys" : @"ZLCommodity",
             @"hotCommoditys" : @"ZLCommodity",
             @"carouselList" : @"ZLImgStatic"
             
             };
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"xinCommoditys" : @"newCommoditys"
             };
}
@end

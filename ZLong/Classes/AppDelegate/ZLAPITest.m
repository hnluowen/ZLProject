//
//  ZLAPITest.m
//  ZLong
//
//  Created by David on 2018/8/14.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLAPITest.h"

@implementation ZLAPITest
+ (void)testAPILogin {
    NSDictionary *params = @{
                             @"phone":@"17671728582",
                             @"password":@"123456"
                             };
//    NSMutableString *cookieString = [[NSMutableString alloc] init];
//    [cookieString appendFormat:@"a=%@;", @"0929c73d-f244-41ba-a3ff-c89398f441c4"];

//    [ZLNetwork setHeadr:@{@"Cookie":cookieString}];
    [ZLNetwork POSTWithURL:API_LOGIN parameters:params callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
        if (!responseObject.success) {
            return ;
        } //失败
        
        if (responseObject.s == ZLStatusCodeSuccess) {
//            NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
//            for (NSHTTPCookie * cookie in cookies){
//                NSLog(@"cookie %@",cookie);
//            }
        } else {
        }
    }];

}

+(void)testAPIUser {
    NSDictionary *params = @{
                             @"phone":@"17671728582",
                             @"password":@"123456"
                             };
    [ZLNetwork POSTWithURL:API_LOGIN parameters:params callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
        if (!responseObject.success) {
            return ;
        } //失败
        
        if (responseObject.s == ZLStatusCodeSuccess) {
            
            [ZLNetwork POSTWithURL:API_UserCenter parameters:nil callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
                
            }];

        } else {
        }
    }];


}

+ (void)testAPIBonus {

    NSDictionary *params = @{
                             @"phone":@"17671728582",
                             @"password":@"123456"
                             };
    [ZLNetwork POSTWithURL:API_LOGIN parameters:params callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
        if (!responseObject.success) {
            return ;
        } //失败
        
        if (responseObject.s == ZLStatusCodeSuccess) {
            
            [ZLNetwork POSTWithURL:API_BONUS parameters:nil callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
                
            }];
            
        } else {
        }
    }];

}

+ (void)testAPIHome {
    [ZLNetwork POSTWithURL:@"api/home/home" parameters:nil callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
        
    }];

    
}

+(void)testAPINearby {
    [ZLNetwork POSTWithURL:@"api/near/goNear" parameters:nil callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
        
    }];
}

+(void)testAPIMobileLogin {
    
}
@end

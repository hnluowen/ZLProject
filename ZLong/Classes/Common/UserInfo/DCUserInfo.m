//
//  DCUserInfo.m
//  CDDMall
//
//  Created by apple on 2017/6/19.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCUserInfo.h"

@implementation DCUserInfo

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"uid" : @"id"
             };
}

+ (void)saveLoginCookie {
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    [DCObjManager dc_saveUserData:@"1" forKey:@"isLogin"]; //1代表登录
    [DCObjManager dc_saveUserData:cookiesData forKey:@"Cookie"]; //cookie 持久化

}

+ (void)readLoginCookie {
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"]];
    NSHTTPCookieStorage * cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie * cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}

+ (void)clearLoginCookie {
    NSHTTPCookieStorage *manager = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieStorage = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookieStorage) {
        [manager deleteCookie:cookie];
    }
    [DCObjManager dc_removeUserDataForkey:@"Cookie"];
    [DCObjManager dc_removeUserDataForkey:@"isLogin"];

}
@end

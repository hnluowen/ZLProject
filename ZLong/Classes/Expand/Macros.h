//
//  Macros.h
//  ZLong
//
//  Created by 刘星 on 2018/8/4.
//  Copyright © 2018年 4vit. All rights reserved.
//


#ifndef Macros_h
#define Macros_h

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;


/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"
/*****************  屏幕适配  ******************/
#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

//全局背景色
#define DCBGColor RGB(255,255,255)

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"


#define TITLES @[@"发起聊天", @"添加好友", @"扫一扫"]
#define ICONS  @[@"mshop_message_gray",@"mshop_message_gray",@"mshop_message_gray"]


#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR9Font [UIFont fontWithName:PFR size:9];
#define PFR8Font [UIFont fontWithName:PFR size:8];

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define KEYWINDOW  [UIApplication sharedApplication].keyWindow

#define UserInfoData [DCUserInfo findAll].lastObject


//判断设备是否为iphoneX
#define DCIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define DefaultImg @"default.png"

/*****************  蒲公英更新  ******************/
//版本控制
#define VERSION_HTTPS_SERVER @"http://www.pgyer.com/apiv1/app/getAppKeyByShortcut"
//版本更新内容
#define VERSION_HTTPS_INFO @"http://www.pgyer.com/apiv1/app/view"
//蒲公英应用api_Key
#define VERSION_API_KEY @"e08ad9d9e8fb4dee72c44cb486be09c0"
//蒲公英应用User_Key
#define VERSION_User_Key @"eb79e5278779732ec8634c0c21d304ed"
//蒲公英应用页面地址后缀
#define VERSION_Shortcut @"Mall"
//蒲公英应用itms-services下载
#define VERSION_Itms_Services @"itms-services://?action=download-manifest&url=https%3A%2F%2Fwww.pgyer.com%2Fapiv1%2Fapp%2Fplist%3FaId%3Db15ba9b695d00c14e1361c24c1869a17%26_api_key%3De08ad9d9e8fb4dee72c44cb486be09c0"
//获取当前版本号
#define BUNDLE_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
//获取当前版本的biuld
#define BIULD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取当前设备的UDID
#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#endif /* Macros_h */

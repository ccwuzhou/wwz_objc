//
//  WWZSystem.h
//  WZCategoryTool
//
//  Created by wwz on 16/4/19.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWZSystem : NSObject

#pragma mark - 系统

+ (BOOL)wwz_isIOS6Later;
+ (BOOL)wwz_isIOS7Later;
+ (BOOL)wwz_isIOS8Later;
+ (BOOL)wwz_isIOS9Later;

#pragma mark - 型号
// 320x480 320x568 375x667 414x736
+ (BOOL)wwz_isIPhone35Inch;
+ (BOOL)wwz_isIPhone4Inch;
+ (BOOL)wwz_isIPhone47Inch;
+ (BOOL)wwz_isIPhone55Inch;
+ (BOOL)wwz_isIPhone4InchEarly;

#pragma mark - 设备信息
/**
 *  iOS 版本
 */
+ (NSString *)wwz_systemVersion;
/**
 *  设备：如 iPhone 5s (A1453/A1533)
 */
+ (NSString *)wwz_platform;

/**
 *  系统uuid, 重装应用后会改变
 */
+ (NSString *)wwz_UUID;

+ (NSString *)wwz_systemInfo;

/**
 *  是否越狱
 */
+ (BOOL)wwz_isJailBroken;

+ (BOOL)wwz_isPhone;

+ (BOOL)wwz_isPad;

/**
 *  设备唯一标识，通过钥匙串储存，重装应用不变，恢复出厂设置可能丢失(未测试)
 */
+ (NSString *)wwz_deviceChainUUID;

#pragma mark - App信息

/**
 *  app 版本
 */
+ (NSString *)wwz_appVersion;

/**
 *  app BundleIdentifier
 */
+ (NSString *)wwz_appIdentifier;

#pragma mark - wifi网络信息
/**
 *  wifi网络信息
 *
 *  @return @{@"SSID":@"", @"BSSID":@""}
 */
+ (NSDictionary *)wwz_fetchNetInfo;
@end

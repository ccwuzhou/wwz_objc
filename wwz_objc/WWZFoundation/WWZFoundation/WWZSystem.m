//
//  WWZSystem.m
//  WZCategoryTool
//
//  Created by wwz on 16/4/19.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZSystem.h"
#import <UIKit/UIKit.h>
#include <sys/sysctl.h>
#import "WWZKeychain.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation WWZSystem

#pragma mark - 系统

+ (BOOL)wwz_isIOS6Later
{
    return ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending );
}

+ (BOOL)wwz_isIOS7Later
{
    return ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending );
}

+ (BOOL)wwz_isIOS8Later
{
    return ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending );
}

+ (BOOL)wwz_isIOS9Later
{
    return ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending );
}

#pragma mark - 型号

+ (BOOL)wwz_isIPhone35Inch
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)wwz_isIPhone4Inch
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)wwz_isIPhone47Inch
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)wwz_isIPhone55Inch
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)wwz_isIPhone4InchEarly
{
    return [self wwz_isIPhone35Inch] || [self wwz_isIPhone4Inch];
}

#pragma mark - Device Info

+ (NSString *)wwz_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)wwz_platform
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s";
    return @"";
}

+ (NSString *)wwz_deviceModel
{
    return [[UIDevice currentDevice] model];
}

+ (NSString *)wwz_UUID
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)wwz_systemInfo
{
    return [NSString stringWithFormat:@"%@,%@,%@",[self wwz_deviceModel],[self wwz_systemVersion],[self wwz_UUID]];
}

static const char * __jb_app = NULL;
+ (BOOL)wwz_isJailBroken
{
    static const char * __jb_apps[] =
    {
        "/Application/Cydia.app",
        "/Application/limera1n.app",
        "/Application/greenpois0n.app",
        "/Application/blackra1n.app",
        "/Application/blacksn0w.app",
        "/Application/redsn0w.app",
        NULL
    };
    
    __jb_app = NULL;
    
    for ( int i = 0; __jb_apps[i]; ++i )
    {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:__jb_apps[i]]] )
        {
            __jb_app = __jb_apps[i];
            return YES;
        }
    }
    
    if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] )
    {
        return YES;
    }
    
    if ( 0 == system("ls") )
    {
        return YES;
    }
    
    return YES;
    
}

+ (BOOL)wwz_isPhone
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

+ (BOOL)wwz_isPad
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (NSString *)wwz_deviceChainUUID
{
    return [WWZKeychain wwz_deviceChainUUID];
}

#pragma mark - App Info

+ (NSString *)wwz_appVersion
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    if (0 == version.length ) version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersion"];
    
    return version;
}

+ (NSString *)wwz_appIdentifier
{
    NSString *identifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    return identifier;
}


#pragma mark - wifi网络信息
/**
 *  wifi网络信息
 *
 *  @return @{@"SSID":@"", @"BSSID":@""}
 */
+ (NSDictionary *)wwz_fetchNetInfo{
    
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
    NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
    
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
        NSLog(@"%s: %@ => %@", __func__, interfaceName, SSIDInfo);
        
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
}
@end

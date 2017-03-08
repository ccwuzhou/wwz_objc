//
//  WWZLanguageTool.h
//  BCSmart
//
//  Created by wwz on 16/11/16.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EN_VALUE @"en" // 英文
#define zh_Hans_VALUE @"zh-Hans"  // 简体中文
#define zh_Hant_VALUE @"zh-Hant"  // 繁体中文

@interface WWZLanguageTool : NSObject


+ (instancetype)sharedLanguageTool;


@property (nonatomic, copy, readonly) NSString *currentLanguageValue;

- (BOOL)isChineseSimplified;

/**
 *  返回Localizable中指定的key的值
 *
 *  @param key   key
 *
 *  @return 返回Localizable中指定的key的值
 */
- (NSString *)localizedStringForKey:(NSString *)key;

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
- (NSString *)localizedStringForKey:(NSString *)key inTable:(NSString *)table;

@end

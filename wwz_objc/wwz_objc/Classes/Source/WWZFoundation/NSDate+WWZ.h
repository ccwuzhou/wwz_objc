//
//  NSDate+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WWZ)

/**
 *  当前NSDateComponents，年、月、日、时、分、秒
 */
+ (NSDateComponents *)wwz_dateComponents;

/**
 *  NSDate 转 NSDateComponents
 */
+ (NSDateComponents *)wwz_dateComponentsFromDate:(NSDate *)date;

/**
 *  今天 yyyy.MM.dd
 */
+ (NSString *)wwz_today;

/**
 *  明天 yyyy.MM.dd
 */
+ (NSString *)wwz_tomorrow;

/**
 *  当前时间
 *
 *  @param dateFormat 格式（yyyy.MM.dd HH:mm ss.SSS）
 */
+ (NSString *)wwz_currentDateWithDateFormat:(NSString *)dateFormat;

/**
 *  时间戳：秒
 */
+ (NSString *)wwz_timeStamp;

/**
 *  时间间隔
 *
 *  @param secs         与当前时间间隔秒数
 *  @param dateFormat   dateFormat
 *
 *  @return NSString
 */
+ (NSString *)wwz_dateAfterTimeInterval:(NSTimeInterval)secs dateFormat:(NSString *)dateFormat;

/**
 *  将时间字符串转为NSDate
 *
 *  @param dateString 时间字符串 @"yyyy-MM-dd HH:mm", @"yyyy/MM/dd HH:mm:ss"
 *  @param format     字符串时间格式
 *
 *  @return date
 */
+ (NSDate *)wwz_dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

/**
 *  NSDate 转 NSString
 *
 *  @param date date
 *  @param format   时间格式
 *
 *  @return NSString
 */
+ (NSString*)wwz_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 *  int 转 时间string
 */
+ (NSString *)wwz_stringDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;

/**
 *  时间戳 转 NSData
 */
+ (NSDate *)wwz_dateWithTimestamp:(NSString *)timestamp;

/**
 *  润年
 */
+ (BOOL)wwz_isLeapYear;

/**
 *  是否为今天
 */
- (BOOL)wwz_isToday;
/**
 *  是否为昨天
 */
- (BOOL)wwz_isYesterday;
/**
 *  是否为今年
 */
- (BOOL)wwz_isThisYear;

@end

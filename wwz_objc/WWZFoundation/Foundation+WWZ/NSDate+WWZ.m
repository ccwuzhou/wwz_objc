//
//  NSDate+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "NSDate+WWZ.h"
#import <UIKit/UIDevice.h>

@implementation NSDate (WWZ)

+ (NSDateComponents *)wwz_dateComponents{
    
    return [self wwz_dateComponentsFromDate:[NSDate date]];
}

/**
 *  NSDate 转 NSDateComponents
 */
+ (NSDateComponents *)wwz_dateComponentsFromDate:(NSDate *)date{
    
    NSUInteger unitFlags = 0;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    }else{
        unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    }
    
    NSDateComponents *dateComponent = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    
    return dateComponent;
}

+ (NSString *)wwz_today{
    
    return [self wwz_currentDateWithDateFormat:@"yyyy.MM.dd"];
}

+ (NSString *)wwz_tomorrow{
    
    return [self wwz_dateAfterTimeInterval:24*3600 dateFormat:@"yyyy.MM.dd"];
}

+ (NSString *)wwz_timeStamp{
    
    return [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
}

+ (NSString *)wwz_currentDateWithDateFormat:(NSString *)dateFormat{
    
    return [self wwz_stringFromDate:[NSDate date] dateFormat:dateFormat];
}

+ (NSString *)wwz_dateAfterTimeInterval:(NSTimeInterval)secs dateFormat:(NSString *)dateFormat{
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:secs];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    fmt.dateFormat = dateFormat;
    
    return [fmt stringFromDate:date];
}
/**
 *  将时间字符串转为NSDate
 *
 *  @param dateString 时间字符串 @"yyyy-MM-dd HH:mm", @"yyyy/MM/dd HH:mm:ss"
 *  @param format     字符串时间格式
 *
 *  @return date
 */
+ (NSDate *)wwz_dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:dateFormat];
    
    return [formatter dateFromString:dateString];
}

/**
 *  NSDate 转 NSString
 *
 *  @param date date
 *  @param dateFormat   时间格式
 *
 *  @return NSString
 */
+ (NSString*)wwz_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:dateFormat];
    
    return [formatter stringFromDate:date];
}


/**
 *  int 转 时间string
 */
+ (NSString *)wwz_stringDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute{
    
    NSString *monStr = [NSString stringWithFormat:@"%02ld",(long)month];
    
    NSString *dayStr = [NSString stringWithFormat:@"%02ld",(long)day];
    
    NSString *hourStr = [NSString stringWithFormat:@"%02ld",(long)hour];
    
    NSString *minStr = [NSString stringWithFormat:@"%02ld",(long)minute];
    
    return [NSString stringWithFormat:@"%ld-%@-%@ %@:%@",(long)year,monStr,dayStr,hourStr,minStr];
}


/**
 *  时间戳 转 NSData
 */
+ (NSDate *)wwz_dateWithTimestamp:(NSString *)timestamp{
    
    return [NSDate dateWithTimeIntervalSince1970:timestamp.intValue];
}

/**
 *  润年
 */
+ (BOOL)wwz_isLeapYear{
    
    NSInteger year = [self wwz_dateComponents].year;
    
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}


/**
 *  是否为今天
 */
- (BOOL)wwz_isToday{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)wwz_isYesterday{
    
    NSDateComponents *cmps = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self toDate:[NSDate date] options:0];
    
    return cmps.day == -1;
}

/**
 *  是否为今年
 */
- (BOOL)wwz_isThisYear{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}


@end

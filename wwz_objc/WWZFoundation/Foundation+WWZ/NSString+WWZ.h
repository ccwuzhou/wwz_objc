//
//  NSString+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSString (WZJson)

/**
 *  json字符串格式化
 */
- (NSString *)wwz_jsonFormat;

@end

@interface NSString (PinYin)
/**
 *  得到文本首字的大写字母
 */
+ (NSString *)wwz_firstUpperLetterWithString:(NSString *)title;

/**
 *  首字是否为汉字
 */
+ (BOOL)wwz_isChinesecharacterWithString:(NSString *)string;
/**
 *  包含数字和字母
 */
+ (BOOL)wwz_isContainNumberAndCharacterWithString:(NSString *)string;
/**
 *  计算汉字的个数
 */
+ (NSInteger)wwz_chineseCountOfString:(NSString *)string;
/**
 *  计算非汉字的个数
 */
+ (NSInteger)wwz_characterCountOfString:(NSString *)string;
@end


@interface NSString (Handle)

/**
 *  NSDocumentDirectory 中文件路径
 */
+ (NSString *)wwz_filePathWithFileName:(NSString *)fileName;

/**
 *  MD5加密
 */
- (NSString *)wwz_md5String;

/**
 *  指定长度字符串（从后面截取）
 *
 *  @param length 截取长度
 *
 *  @return 指定长度字符串，不足前面补0
 */
- (NSString *)wwz_fixedStringWithLength:(NSUInteger)length;

/**
 *  字符串截取中间
 *
 *  @param range range
 *
 *  @return 截取后字符串，越界返回nil
 */
- (NSString *)wwz_substringWithRange:(NSRange)range;

/**
 *  拆分字符串
 *
 *  @param string 拆分字符
 *
 *  @return 拆分后的数组，不含拆分字符返回@[self]
 */
- (NSArray *)wwz_componentsSeparatedByString:(NSString *)string;

/**
 *  十六进制字符串每两位相加
 */
- (NSString *)wwz_stringByAddPerTwoNumber;

#pragma mark - 进制转换

/**
 *  十进制 ==> 十六进制
 */
- (NSString *)wwz_sixteenthTypeString;

/**
 *  十六进制 ==> 十进制数
 */
- (long)wwz_tenTypeValue;

/**
 *  格式化为16进制2位字符串
 *
 *  @param number 10进制int
 *
 *  @return 16进制
 */
+ (NSString *)wwz_formatSisteenCmdWithDecimalNumber:(long)number;

@end


@interface NSString (Conversion)

#pragma mark - 进制转换

/**
 *  十六进制 ==> 十进制数
 *
 *  @param sixteenString 十六进制
 *
 *  @return 十进制数
 */
+ (unsigned long)wwz_decimalNumberFromSixteenString:(NSString *)sixteenString;

/**
 *  十进制 ==> 十六进制
 *
 *  @param decimalString 十进制
 *
 *  @return 十六进制
 */
+ (NSString *)wwz_sixteenStringFromDecimalString:(NSString *)decimalString;

/**
 *  十进制 ==> 二进制
 *
 *  @param decimalString 十进制
 *
 *  @return 二进制
 */
+ (NSString *)wwz_binaryStringFromDecimalString:(NSString *)decimalString;

/**
 *  二进制 ==> 十进制
 *
 *  @param binaryString 二进制
 *
 *  @return 十进制
 */
+ (NSString *)wwz_decimalStringFromBinaryString:(NSString *)binaryString;

/**
 *  十六进制 ==> 二进制
 *
 *  @param sixteenString 十六进制
 *
 *  @return 二进制
 */
+ (NSString *)wwz_binaryStringFromSixteenString:(NSString *)sixteenString;

/**
 *  二进制 ==> 十六进制
 *
 *  @param binaryString 二进制
 *
 *  @return 十六进制
 */
+ (NSString *)wwz_sixteenStringFromBinaryString:(NSString *)binaryString;


#pragma mark - Hex
/**
 *  十六进制字符串 ==> 普通字符串
 *
 *  @param hexString 十六进制字符串
 *
 *  @return 普通字符串
 */
+ (NSString *)wwz_normalStringFromHexString:(NSString *)hexString;

/**
 *  普通字符串 ==> 十六进制字符串
 *
 *  @param normalString 普通字符串
 *
 *  @return 十六进制字符串
 */
+ (NSString *)wwz_hexStringFromNormalString:(NSString *)normalString;

/**
 *  NSData ==> 十六进制的字符串
 *
 *  @param data NSData
 *
 *  @return 十六进制的字符串
 */
+ (NSString *)wwz_hexStringFromData:(NSData *)data;

/**
 *  十六进制的字符串 ==> Byte 数组 ==> NSData
 *
 *  @return NSData
 */
+ (NSData *)wwz_byteDataFromHexString:(NSString *)hexString;

@end

@interface NSString (WZCode)

/**
 *  url编码
 */
- (NSString *)wwz_urlEncode;
/**
 *  url解码
 */
- (NSString *)wwz_urlDecode;
/**
 *  unicode转码成中文
 */
- (NSString *)wwz_utf8StringByReplaceUnicode;

@end


@interface NSString (WZSize)

/**
 *  sting width
 *
 *  @param font     font
 *  @param maxHeight maxHeight
 *
 *  @return sting width
 */
- (CGFloat)wwz_stringWidthWithFont:(UIFont*)font maxHeight:(CGFloat)maxHeight;

/**
 *  sting height
 *
 *  @param font     font
 *  @param maxWidth maxWidth
 *
 *  @return sting height
 */
- (CGFloat)wwz_stringHeightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/**
 *  string size
 *
 *  @param font    font
 *  @param maxSize maxSize
 *
 *  @return fit size
 */
- (CGSize)wwz_stringSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end

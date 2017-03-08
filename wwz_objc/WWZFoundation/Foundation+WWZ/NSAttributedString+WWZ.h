//
//  NSAttributedString+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (WWZ)
/**
 *  NSMutableAttributedString
 *
 *  @param string      文本
 *  @param font        字体
 *  @param color       文本颜色
 *  @param alignment   对齐方式
 *  @param lineSpacing 行间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_attributeStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing;

/**
 *  单纯改变一句话中的某些字的颜色
 *
 *  @param color    需要改变成的颜色
 *  @param totalStr 总的字符串
 *  @param subArray 需要改变颜色的文字数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_changeCorlorWithColor:(UIColor *)color totalString:(NSString *)totalString subStringArray:(NSArray *)subStringArray;

/**
 *  单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
 *
 *  @param totalString 需要更改的字符串
 *  @param space       字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_changeSpaceWithTotalString:(NSString *)totalString textSpace:(CGFloat)textSpace;

/**
 *  单纯改变段落的行间距
 *
 *  @param totalString 需要更改的字符串
 *  @param lineSpace   行间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_changeLineSpaceWithTotalString:(NSString *)totalString lineSpace:(CGFloat)lineSpace;

/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_changeLineAndTextSpaceWithTotalString:(NSString *)totalString lineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;

/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_changeTextFont:(UIFont *)font color:(UIColor *)color totalString:(NSString *)totalString subStringArray:(NSArray *)subArray;
@end

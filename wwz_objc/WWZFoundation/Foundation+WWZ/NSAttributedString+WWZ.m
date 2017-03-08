//
//  NSAttributedString+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "NSAttributedString+WWZ.h"
#import <CoreText/CoreText.h>
@implementation NSAttributedString (WWZ)
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
+ (NSMutableAttributedString *)wwz_attributeStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing{
    
    if (!string||string.length == 0) {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = [string rangeOfString:string];
    //设置字体颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    //    style.headIndent = 30;//缩进
    //    style.tailIndent = 30;
    
    style.firstLineHeadIndent = 0;
    
    style.alignment = alignment;
    
    style.lineSpacing = lineSpacing;//行距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:range];
    
    return attributedString;
}

- (CGRect)getStringRectWithString:(NSString *)string font:(UIFont*)font maxWidth:(CGFloat)maxWidth{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange allRange = [string rangeOfString:string];
    [attrStr addAttribute:NSFontAttributeName
                    value:font
                    range:allRange];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:allRange];
    
    NSRange destRange = [string rangeOfString:@""];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:destRange];
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                        options:options
                                        context:nil];
    
    
    return rect;
    
    
}

#pragma mark - 富文本操作

/**
 *  单纯改变一句话中的某些字的颜色
 *
 *  @param color    需要改变成的颜色
 *  @param totalStr 总的字符串
 *  @param subArray 需要改变颜色的文字数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_changeCorlorWithColor:(UIColor *)color totalString:(NSString *)totalString subStringArray:(NSArray *)subStringArray {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    for (NSString *rangeStr in subStringArray) {
        
        NSMutableArray *array = [self wwz_getRangeArrayWithTotalString:totalString subString:rangeStr];
        
        for (NSNumber *rangeNum in array) {
            
            NSRange range = [rangeNum rangeValue];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
    
    return attributedStr;
}

/**
 *  单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
 *
 *  @param totalString 需要更改的字符串
 *  @param space       字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_changeSpaceWithTotalString:(NSString *)totalString textSpace:(CGFloat)textSpace {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    long number = textSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    
    return attributedStr;
}

/**
 *  单纯改变段落的行间距
 *
 *  @param totalString 需要更改的字符串
 *  @param lineSpace   行间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_changeLineSpaceWithTotalString:(NSString *)totalString lineSpace:(CGFloat)lineSpace {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    
    return attributedStr;
}

/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_changeLineAndTextSpaceWithTotalString:(NSString *)totalString lineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    
    long number = textSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    
    return attributedStr;
}

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
+ (NSMutableAttributedString *)wwz_changeTextFont:(UIFont *)font color:(UIColor *)color totalString:(NSString *)totalString subStringArray:(NSArray *)subArray {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    for (NSString *rangeStr in subArray) {
        
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    
    return attributedStr;
}

/**
 *  为某些文字改为链接形式
 *
 *  @param totalString 总的字符串
 *  @param subArray    需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)wwz_addLinkWithTotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    for (NSString *rangeStr in subArray) {
        
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSLinkAttributeName value:totalString range:range];
    }
    
    return attributedStr;
}
#pragma mark - 获取某个子字符串在某个总字符串中位置数组
/**
 *  获取某个字符串中子字符串的位置数组 @[NSRange]
 *
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *
 *  @return 位置数组
 */
+ (NSMutableArray *)wwz_getRangeArrayWithTotalString:(NSString *)totalString subString:(NSString *)subString {
    
    NSMutableArray *mRanges = [NSMutableArray array];
    
    if (!subString || subString.length == 0) {
        return nil;
    }
    
    NSRange range = [totalString rangeOfString:subString];
    
    if (range.length == 0 || range.location == NSNotFound) {
        return nil;
    }
    
    [mRanges addObject:[NSNumber valueWithRange:range]];
    
    while (1) {
        
        range.location += range.length;
        range.length = totalString.length - range.location;
        
        range = [totalString rangeOfString:subString options:NSCaseInsensitiveSearch range:range];
        
        if (range.length == 0) {
            
            break;
        }
        [mRanges addObject:[NSNumber valueWithRange:range]];
    }
    
    return mRanges;
}

@end

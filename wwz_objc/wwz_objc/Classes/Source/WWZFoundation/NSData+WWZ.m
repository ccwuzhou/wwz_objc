//
//  NSData+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "NSData+WWZ.h"

@implementation NSData (WWZ)

/**
 *  \r\n
 */
+ (NSData *)CRLFData
{
    return [NSData dataWithBytes:"\x0D\x0A" length:2];
}
/**
 *  \r
 */
+ (NSData *)CRData
{
    return [NSData dataWithBytes:"\x0D" length:1];
}
/**
 *  \n
 */
+ (NSData *)LFData
{
    return [NSData dataWithBytes:"\x0A" length:1];
}
/**
 *  空字符
 */
+ (NSData *)ZeroData
{
    return [NSData dataWithBytes:"" length:1];
}

@end

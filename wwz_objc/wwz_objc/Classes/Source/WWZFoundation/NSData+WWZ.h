//
//  NSData+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (WWZ)
/**
 *  \r\n
 */
+ (NSData *)CRLFData;
/**
 *  \r
 */
+ (NSData *)CRData;
/**
 *  \n
 */
+ (NSData *)LFData;
/**
 *  空
 */
+ (NSData *)ZeroData;

@end

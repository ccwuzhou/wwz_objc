//
//  NSObject+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WWZ)

/**
 *  当前对象不为空
 */
- (BOOL)wwz_isNotEmpty;

@end

@interface NSArray (WWZ)
/**
 *  取值
 */
- (id)wwz_objectAtSafeIndex:(NSInteger)index;

/**
 *  NSArray 快速求总和
 */
- (float)wwz_array_sum;

/**
 *  NSArray 快速求平均值
 */
- (float)wwz_array_avg;

/**
 *  NSArray 快速求最小值
 */
- (float)wwz_array_min;

/**
 *  NSArray 快速求最大值
 */
- (float)wwz_array_max;
@end

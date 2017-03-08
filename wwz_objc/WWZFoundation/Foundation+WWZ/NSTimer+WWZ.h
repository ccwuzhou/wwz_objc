//
//  NSTimer+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WWZ)

+ (NSTimer *)wwz_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

@end

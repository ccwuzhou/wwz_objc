//
//  NSTimer+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "NSTimer+WWZ.h"

@implementation NSTimer (WWZ)

+ (NSTimer *)wwz_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block{
    
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(wwz_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)wwz_blockInvoke:(NSTimer *)timer{
    
    void (^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

@end

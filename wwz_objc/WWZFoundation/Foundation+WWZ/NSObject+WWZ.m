//
//  NSObject+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "NSObject+WWZ.h"
#import <objc/runtime.h>
@implementation NSObject (WWZ)

- (BOOL)wwz_isNotEmpty{
    
    if ([self isKindOfClass:[NSNull class]]){
        
        return NO;
        
    }else if ([self isKindOfClass:[NSString class]]){
        
        return [(NSString *)self length] != 0;
        
    }else if ([self isKindOfClass:[NSData class]]){
        
        return [(NSData *)self length] != 0;
        
    }else if ([self isKindOfClass:[NSArray class]]){
        
        return [(NSArray *)self count] != 0;
        
    }else if ([self isKindOfClass:[NSDictionary class]]){
        
        return [(NSDictionary *)self count] != 0;
        
    }else if ([self isKindOfClass:[NSSet class]]){
        
        return [(NSSet *)self count] != 0;
    }
    
    return YES;
}
//- (NSArray *)filterPropertys{
//
//    NSMutableArray *props = [NSMutableArray array];
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//    for (i = 0; i<outCount; i++){
//
//        objc_property_t property = properties[i];
//        const char *char_f = property_getName(property);
//        NSString *propertyName = [NSString stringWithUTF8String:char_f];
//        [props addObject:propertyName];
//    }
//    free(properties);
//    return props;
//}

/*
 id autoDictionaryGetter(id self, SEL _cmd){
 
 WZObject *typedSelf = (WZObject *)self;
 NSString *key = NSStringFromSelector(_cmd);
 
 return [typedSelf.backingStore objectForKey:key];
 }
 
 void autoDictionarySetter(id self, SEL _cmd, id value){
 
 WZObject *typedSelf = (WZObject *)self;
 
 NSString *selectorString = NSStringFromSelector(_cmd);
 NSMutableString *key = [selectorString mutableCopy];
 
 [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];
 
 [key deleteCharactersInRange:NSMakeRange(0, 3)];
 
 NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
 [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
 
 if (value) {
 [typedSelf.backingStore setObject:value forKey:key];
 }else{
 
 [typedSelf.backingStore removeObjectForKey:key];
 }
 
 }
 //+ (BOOL)resolveClassMethod:(SEL)sel{
 //
 //
 //
 //}
 + (BOOL)resolveInstanceMethod:(SEL)sel{
 
 NSString *selectorString = NSStringFromSelector(sel);
 if ([selectorString hasPrefix:@"set"]) {
 class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
 }else{
 
 class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
 }
 
 return YES;
 }
 */

@end


@implementation NSArray (WWZ)

- (id)wwz_objectAtSafeIndex:(NSInteger)index
{
    if (index >(self.count-1) || index < 0)
    {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

/**
 *  NSArray 快速求总和
 */
- (float)wwz_array_sum{
    
    return [[self valueForKeyPath:@"@sum.floatValue"] floatValue];
}
/**
 *  NSArray 快速求平均值
 */
- (float)wwz_array_avg{
    
    
    return [[self valueForKeyPath:@"@avg.floatValue"] floatValue];
}
/**
 *  NSArray 快速求最小值
 */
- (float)wwz_array_min{
    
    return [[self valueForKeyPath:@"@min.floatValue"] floatValue];
}
/**
 *  NSArray 快速求最大值
 */
- (float)wwz_array_max{
    
    return [[self valueForKeyPath:@"@max.floatValue"] floatValue];
}
@end

//
//  WWZCaptureTool.h
//  WZCategoryTool
//
//  Created by wwz on 16/6/12.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class WWZCaptureTool;

@protocol WZCaptureToolDelegate <NSObject>

/**
 *  二维码扫描成功回调
 */
- (void)captureTool:(WWZCaptureTool *)captureTool captureStringValue:(NSString *)captureStringValue;

@end

@interface WWZCaptureTool : NSObject

@property (nonatomic, weak) id <WZCaptureToolDelegate> delegate;

/**
 *  手电简开关状态
 */
@property (nonatomic, assign) BOOL isTorchModeOn;

/**
 *  显示视频预览层（必须添加）
 *
 *  @param layer superlayer
 */
- (void)showPreviewLayerInLayer:(CALayer *)layer;

/**
 *  开始扫描
 */
- (void)startRunning;

/**
 *  停止扫描
 */
- (void)stopRunning;

@end

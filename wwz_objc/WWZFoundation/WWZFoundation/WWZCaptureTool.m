//
//  WWZCaptureTool.m
//  WZCategoryTool
//
//  Created by wwz on 16/6/12.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZCaptureTool.h"

@interface WWZCaptureTool ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, strong) AVCaptureDeviceInput *captureInput;

@property (nonatomic, strong) AVCaptureMetadataOutput *captureOutput;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation WWZCaptureTool

/**
 *  显示视频预览层
 *
 *  @param layer super layer
 */
- (void)showPreviewLayerInLayer:(CALayer *)layer{
    
    self.previewLayer.frame = layer.bounds;
    
    [layer insertSublayer:self.previewLayer atIndex:0];
}

/**
 *  开始扫描
 */
- (void)startRunning{
    
    [self.captureSession startRunning];
}
/**
 *  停止扫描
 */
- (void)stopRunning{
    
    [self.captureSession stopRunning];
}
/**
 *  手电简
 */
- (void)setIsTorchModeOn:(BOOL)isTorchModeOn{
    _isTorchModeOn = isTorchModeOn;
    if (_isTorchModeOn) {
        [self setTorchMode:AVCaptureTorchModeOn];
    }else{
        [self setTorchMode:AVCaptureTorchModeOff];
    }
}
/**
 *  设置手电简开关
 */
- (void)setTorchMode:(AVCaptureTorchMode )torchMode{
    
    AVCaptureDevice *captureDevice= [_captureInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        if ([captureDevice isTorchModeSupported:torchMode]) {
            [captureDevice setTorchMode:torchMode];
        }
        [captureDevice unlockForConfiguration];
    }else{
        NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

/**
 *  扫描成功调用
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if ([metadataObjects count] == 0) return;
    
    [_captureSession stopRunning];
    
    AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
    
    // 二维码字符串
    NSString *stringValue = metadataObject.stringValue;
    
    if (!stringValue) return;

    if ([self.delegate respondsToSelector:@selector(captureTool:captureStringValue:)]) {
        [self.delegate captureTool:self captureStringValue:stringValue];
    }
    
}
#pragma mark - 摄像头相关设置
/**
 *  初始化会话
 */
- (AVCaptureSession *)captureSession{
    
    if (!_captureSession) {
        
        _captureSession = [[AVCaptureSession alloc] init];
        
        [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
        //将设备输入添加到会话中
        if ([_captureSession canAddInput:self.captureInput]){
            
            [_captureSession addInput:self.captureInput];
        }
        //将设备输出添加到会话中
        if ([_captureSession canAddOutput:self.captureOutput]){
            
            [_captureSession addOutput:self.captureOutput];
        }
        // 条码类型 AVMetadataObjectTypeQRCode
        _captureOutput.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    }
    return _captureSession;
}
/**
 *  设备输入对象,用于获得输入数据
 */
- (AVCaptureDeviceInput *)captureInput{
    
    if (!_captureInput) {
        
        //获得输入设备
        AVCaptureDevice *captureDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
        if (!captureDevice) {
            NSLog(@"取得后置摄像头时出现问题.");
            return nil;
        }
        
        NSError *error=nil;
        //根据输入设备初始化设备输入对象，
        _captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        if (error) {
            NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
            return nil;
        }
        
    }
    return _captureInput;
}
/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}
/**
 *  设备输出对象,用于获得输出数据
 */
- (AVCaptureMetadataOutput *)captureOutput{
    
    if (!_captureOutput) {
        
        _captureOutput = [[AVCaptureMetadataOutput alloc] init];
        //    _captureDeviceoutput.rectOfInterest = CGRectMake(previewX, previewY, previewWH, previewWH);
        [_captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
    }
    return _captureOutput;
}
/**
 *  视频预览层,用于实时展示摄像头状态
 */
- (AVCaptureVideoPreviewLayer *)previewLayer{
    
    if (!_previewLayer) {
        
        _previewLayer =[AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//填充模式
    }
    return _previewLayer;
}

@end

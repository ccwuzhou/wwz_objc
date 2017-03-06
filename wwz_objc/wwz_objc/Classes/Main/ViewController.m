//
//  ViewController.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "ViewController.h"
#import "WWZSocket.h"
@interface ViewController ()<WWZTCPSocketDelegate>

@property (nonatomic, strong) WWZTCPSocketClient *tcpSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tcpSocket = [[WWZTCPSocketClient alloc] initWithDelegate:self endKey:nil];
    
    [_tcpSocket connectToHost:@"120.76.246.20" onPort:24411];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
}

/**
 *  socket连接成功回调
 */
- (void)tcpSocket:(WWZTCPSocketClient *)tcpSocket didConnectToHost:(NSString *)host port:(uint16_t)port{

}

/**
 *  socket连接失败回调
 */
- (void)tcpSocket:(WWZTCPSocketClient *)tcpSocket didDisconnectWithError:(NSError *)error{

}

/**
 *  socket收到数据回调
 */
- (void)tcpSocket:(WWZTCPSocketClient *)tcpSocket didReadResult:(id)result{

}
@end

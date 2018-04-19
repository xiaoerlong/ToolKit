//
//  TRScanViewController.m
//  ToolKit
//
//  Created by Tronsis－mac on 2018/4/18.
//  Copyright © 2018年 Kim－pc. All rights reserved.
//

#import "TRScanViewController.h"

#import "SGQRCode.h"

#import "NSObject+TRAuthorization.h"

@interface TRScanViewController () <SGQRCodeScanManagerDelegate>
@property (nonatomic, strong) SGQRCodeScanManager *scanManager;
@property (nonatomic, strong) SGQRCodeScanningView *scanView;
@end

@implementation TRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"RQCode";
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scanView];
    [self captureAuthWithCompletionHandler:^(BOOL granted) {
        if (granted) {
            [self startRQCodeScan];
        } else {
            [self alertPrompt];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanView addTimer];
    if (self.scanManager != nil) {
        [self.scanManager startRunning];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.scanView removeTimer];
    [self.scanManager stopRunning];
}

- (void)dealloc {
    [self.scanView removeTimer];
    [self.scanView removeFromSuperview];
    self.scanView = nil;
}

#pragma mark -
#pragma mark Private
- (void)startRQCodeScan {
    self.scanManager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    [self.scanManager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    self.scanManager.delegate = self;
}

- (void)alertPrompt {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请在iPhone的设置“设置-隐私-相机”选项中，允许微信访问你的相机" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark -
#pragma mark SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    if (metadataObjects.count) {
        [self.scanManager stopRunning];
    }
    NSLog(@"metadataObjects:%@", metadataObjects);
}

#pragma mark -
#pragma mark Getter
- (SGQRCodeScanningView *)scanView {
    if (!_scanView) {
        _scanView = [[SGQRCodeScanningView alloc] initWithFrame:self.view.bounds];
        _scanView.scanningImageName = @"home_scanLine";
        _scanView.scanningAnimationStyle = ScanningAnimationStyleDefault;
        _scanView.cornerColor = [UIColor redColor];
    }
    return _scanView;
}


@end

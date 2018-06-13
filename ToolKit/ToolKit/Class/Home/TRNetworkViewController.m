//
//  TRNetworkViewController.m
//  ToolKit
//
//  Created by Tronsis－mac on 2018/4/20.
//  Copyright © 2018年 Kim－pc. All rights reserved.
//

#import "TRNetworkViewController.h"

#import "TRHomeNetwork.h"

@interface TRNetworkViewController () <NSURLSessionTaskDelegate>
@property (nonatomic, strong) UIProgressView *uploadProgressView;
@end

@implementation TRNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.uploadProgressView];
    
    [self download];
//    [self backgroundDownload];
    [self upload];
    
    TRDownApi *network = [[TRDownApi alloc] initWithFileid:@"1e3044ea2678452289bd15869910aac2"];
    [network startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
    TRUploadApi *upload = [[TRUploadApi alloc] init];
    [upload startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark -
#pragma mark download
// 下载
- (void)download {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_03.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 只有在下载完成后才会回调
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"location:%@", location);
        if (!error) {
            NSLog(@"response:%@", response);
        } else {
            NSLog(@"error:%@", error);
        }
    }];
    [task resume];
}

// 后台下载
- (void)backgroundDownload {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"test"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_03.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"back location:%@", location);
        if (!error) {
            NSLog(@"back response:%@", response);
        } else {
            NSLog(@"back error:%@", error);
        }
    }];
    [task resume];
}

// 多任务下载

// 断点下载

#pragma mark -
#pragma mark 上传
- (void)upload {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url =[NSURL URLWithString:@"http://120.25.226.186:32812/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 设置请求头
    NSString *header = @"multipart/form-data";
    [request setValue:header forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:[self getBody]];
    [task resume];
    
}

// 设置请求体
- (NSData *)getBody {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"docx"];
    NSURL *fileUrl = [NSURL fileURLWithPath:path];
    
    NSMutableData *fileData = [NSMutableData data];
    
    // 文件参数
    [fileData appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"123.png\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[NSData dataWithContentsOfURL:fileUrl]];
    return fileData;
}


#pragma mark -
#pragma mark delegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"bytesSent:%lld\ntotalBytesSent:%lld\ntotalBytesExpectedToSend:%lld\n", bytesSent, totalBytesSent, totalBytesExpectedToSend);
    self.uploadProgressView.progress = totalBytesSent / totalBytesExpectedToSend;
}

#pragma mark -
#pragma mark Getter
- (UIProgressView *)uploadProgressView {
    if (!_uploadProgressView) {
        _uploadProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 20)];
    }
    return _uploadProgressView;
}


@end

//
//  TRHomeNetwork.m
//  ToolKit
//
//  Created by Tronsis－mac on 2018/4/23.
//  Copyright © 2018年 Kim－pc. All rights reserved.
//

#import "TRHomeNetwork.h"


@implementation TRHomeNetwork

@end

@implementation TRDownApi {
    NSString *_fileid;
}

- (instancetype)initWithFileid:(NSString *)fileId {
    self = [super init];
    if (self) {
        _fileid = fileId;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/files/download/%@", _fileid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end

@implementation TRUploadApi
- (NSString *)requestUrl {
    return @"/upload";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"docx"];
        NSURL *fileUrl = [NSURL fileURLWithPath:path];
        [formData appendPartWithFileURL:fileUrl name:@"text" error:nil];
    };
}
@end

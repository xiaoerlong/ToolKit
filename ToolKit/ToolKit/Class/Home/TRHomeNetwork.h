//
//  TRHomeNetwork.h
//  ToolKit
//
//  Created by Tronsis－mac on 2018/4/23.
//  Copyright © 2018年 Kim－pc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"

@interface TRHomeNetwork : NSObject

@end

@interface TRDownApi : YTKRequest
- (instancetype)initWithFileid:(NSString *)fileId;
@end

@interface TRUploadApi : YTKRequest
@end

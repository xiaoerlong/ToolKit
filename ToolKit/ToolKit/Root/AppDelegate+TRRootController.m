//
//  AppDelegate+TRRootController.m
//  ToolKit
//
//  Created by Tronsis－mac on 2018/4/18.
//  Copyright © 2018年 Kim－pc. All rights reserved.
//

#import "AppDelegate+TRRootController.h"
#import "TRTabBarController.h"

@implementation AppDelegate (TRRootController)
- (void)setRootController {
    TRTabBarController *vc = [TRTabBarController new];
    self.window.rootViewController = vc;
}
@end

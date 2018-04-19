//
//  TRTabBarController.m
//  ToolKit
//
//  Created by Tronsis－mac on 2018/4/18.
//  Copyright © 2018年 Kim－pc. All rights reserved.
//

#import "TRTabBarController.h"
#import "TRNavigationController.h"
#import "TRHomeViewController.h"
#import "TRFunctionViewController.h"

@interface TRTabBarController ()
@property (nonatomic, strong) TRHomeViewController *homevc;
@property (nonatomic, strong) TRFunctionViewController *funcvc;
@end

@implementation TRTabBarController

//+ (void)initialize {
//    UITabBar *tabBar = [UITabBar appearanceWhenContainedIn:[self class], nil];
//
//}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addChildViewController:[[TRNavigationController alloc] initWithRootViewController:self.homevc]];
        [self addChildViewController:[[TRNavigationController alloc] initWithRootViewController:self.funcvc]];
    }
    return self;
}

#pragma mark -
#pragma mark Getter
- (TRHomeViewController *)homevc {
    if (!_homevc) {
        _homevc = [TRHomeViewController new];
        _homevc.tabBarItem.title = @"主页";
        _homevc.navigationItem.title = @"主页";
        _homevc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:0];
    }
    return _homevc;
}

- (TRFunctionViewController *)funcvc {
    if (!_funcvc) {
        _funcvc = [TRFunctionViewController new];
        _funcvc.tabBarItem.title = @"功能";
        _funcvc.navigationItem.title = @"功能";
        _funcvc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:1];
    }
    return _funcvc;
}

@end

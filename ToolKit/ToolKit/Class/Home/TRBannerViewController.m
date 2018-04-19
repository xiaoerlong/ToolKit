//
//  TRBannerViewController.m
//  ToolKit
//
//  Created by Tronsis－mac on 2018/4/19.
//  Copyright © 2018年 Kim－pc. All rights reserved.
//

#import "TRBannerViewController.h"

#import "SDCycleScrollView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TRBannerViewController () <SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) SDCycleScrollView *textScrollView; // 文字滚动
@end

@implementation TRBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.cycleScrollView];
    [self.scrollView addSubview:self.textScrollView];
}

#pragma mark -
#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
}

#pragma mark -
#pragma mark Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    }
    return _scrollView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) delegate:self placeholderImage:[UIImage imageNamed:@"home_banner"]];
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageControlDotSize = CGSizeMake(8, 8);
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        
        _cycleScrollView.localizationImageNamesGroup = @[@"h1.jpg",@"h2.jpg",@"h3.jpg",@"h4.jpg"];
    }
    return _cycleScrollView;
}

- (SDCycleScrollView *)textScrollView {
    if (!_textScrollView) {
        _textScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 210, kScreenWidth, 20) delegate:self placeholderImage:[UIImage imageNamed:@"home_banner"]];
        _textScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _textScrollView.onlyDisplayText = YES;
        [_textScrollView disableScrollGesture];
        _textScrollView.titlesGroup = @[@"2017.11.26 -- 增加滚动到指定index接口", @"2017.10.28 -- 更新对SDWebImage的版本依赖", @"2017.06.23 -- 1.增加支持轮播自定义cell的代理方法 2.增加禁止拖动手势api"];

    }
    return _textScrollView;
}

@end

//
//  TRHomeViewController.m
//  ToolKit
//
//  Created by Tronsis－mac on 2018/4/18.
//  Copyright © 2018年 Kim－pc. All rights reserved.
//

#import "TRHomeViewController.h"

#import "TRScanViewController.h"
#import "TRBannerViewController.h"
#import "TRNetworkViewController.h"

@interface TRHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation TRHomeViewController

#pragma mark -
#pragma mark LifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.dataSource = @[@"QRCode",@"Banner", @"Network"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) { // 二维码扫描
        TRScanViewController *vc = [TRScanViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) { // banner图
        TRBannerViewController *vc = [TRBannerViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) { // 网络层相关
        TRNetworkViewController *vc = [TRNetworkViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -
#pragma mark Private


#pragma mark -
#pragma mark Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 44;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end

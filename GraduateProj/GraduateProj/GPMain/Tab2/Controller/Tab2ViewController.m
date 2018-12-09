//
//  Tab2ViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab2ViewController.h"
#import "CePingHeaderView.h"
#import "CePingFootderView.h"
#import "CePingCell.h"
#import "JiLuCell.h"
#import "CePingData.h"
#import "ZiCeData.h"

@interface Tab2ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) BOOL isCePing; //默认YES
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation Tab2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configUI];
}

- (void)configData {
    self.isCePing = YES;
}

- (void)configUI {
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isCePing) {
        return [CePingData tableView:tableView cellForRowAtIndexPath:indexPath];
    } else {
        return [ZiCeData tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isCePing) {
        return 7;
    } else {
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isCePing) {
        return [CePingData tableView:tableView heightForRowAtIndexPath:indexPath];
    } else {
        return [ZiCeData tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kColor(239, 239, 239, 1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        CePingHeaderView *header = [[CePingHeaderView alloc] init];
        header.frame = CGRectMake(0, 0, kScreenWidth, 230);
        _tableView.tableHeaderView = header;
        __weak typeof(self) weakSelf = self;
        header.leftRightClick = ^(BOOL isLeft) {
            weakSelf.isCePing = isLeft;
            if (!isLeft) {
                UIView *footer = [UIView new];
                footer.frame = CGRectMake(0, 0, kScreenWidth, 50);
                weakSelf.tableView.tableFooterView = footer;
            } else {
                CePingFootderView *footer = [[CePingFootderView alloc] init];
                footer.frame = CGRectMake(0, 0, kScreenWidth, 70);
                weakSelf.tableView.tableFooterView = footer;
            }
            [weakSelf.tableView reloadData];
        };
        
        CePingFootderView *footer = [[CePingFootderView alloc] init];
        footer.frame = CGRectMake(0, 0, kScreenWidth, 70);
        _tableView.tableFooterView = footer;
    }
    return _tableView;
}

@end

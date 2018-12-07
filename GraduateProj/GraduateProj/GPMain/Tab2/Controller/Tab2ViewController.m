//
//  Tab2ViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab2ViewController.h"
#import "CePingHeaderView.h"

@interface Tab2ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation Tab2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //        _tableView.bounces = NO;
        _tableView.backgroundColor = kColor(239, 239, 239, 1);
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.delaysContentTouches = NO;
        _tableView.rowHeight = 80;
//        _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        CePingHeaderView *header = [[CePingHeaderView alloc] init];
        header.frame =CGRectMake(0, 0, kScreenWidth, 220);
        _tableView.tableHeaderView = header;
    }
    return _tableView;
}

@end

//
//  RunListController.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunListController.h"
#import "RunResultController.h"
#import "RunFileUtil.h"
#import "RunRecordModel.h"
#import <BaiduMapAPI_Map/BMKPolyline.h>

@interface RunListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RunListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    self.navigationItem.title = @"跑步记录";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!self.datas.count) {
        cell.textLabel.text = @"还没有跑步记录，赶快去跑吧~";
    } else {
        NSString *str = [NSString stringWithFormat:@"这是第 %td 条记录", indexPath.row + 1];
        cell.textLabel.text = str;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count ? : 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.datas.count) {
        NSData *data = self.datas[indexPath.row];
        RunRecordModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        RunResultController *resultVC = [[RunResultController alloc] init];
        resultVC.lineGroupArray = model.lineGroupArray.mutableCopy;
        resultVC.lineTempArray = model.lineTempArray.mutableCopy;
        resultVC.dataArray = model.dataArray;
        resultVC.startRunTime = model.startRunDate;
        resultVC.isRecordModel = YES;
        [self presentViewController:resultVC animated:YES completion:nil];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end

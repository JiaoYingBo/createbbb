//
//  Tab4ViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab4ViewController.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "NewsViewController.h"
#import "MJRefresh.h"
#import "YLTableViewVC.h"
#import "MyNewsCell.h"
#import "CommunityViewController.h"

@interface Tab4ViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong)UITableView *myTable;
@property (nonatomic,copy)NSArray *dataArray;

@end

@implementation Tab4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self setData];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(shequList)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(videoButtonList)];
}
- (void)shequList {
    CommunityViewController *vc = [[CommunityViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)videoButtonList{
    YLTableViewVC *vc = [[YLTableViewVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)setData{
    _dataArray = @[@"球类运动，总有一款适合你",@"膝关节健康，你不知道的冷知识",@"网球基础知识扫盲",@"关于体测，适当户外运动",@"如何跑步不伤膝盖"];
}
- (void)setUI{
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    _myTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    //_myTable.backgroundColor = [UIColor lightGrayColor];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.tableHeaderView = [self tableViewCycleView];
    _myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"drop-down刷新");
        [_myTable.mj_header endRefreshing];
    }];
    _myTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"pull刷新");
        [_myTable.mj_footer endRefreshingWithNoMoreData];
    }];
    _myTable.estimatedRowHeight = 80;
   
    
    [_myTable.mj_header beginRefreshing];
    [self.view addSubview:_myTable];
}
- (UIView *)tableViewCycleView{
    UIView *bgCycleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)];
    bgCycleView.backgroundColor = [UIColor greenColor];
    
    // 加载 --- 创建不带标题的图片轮播器
    NSArray *imagesURLStrings = @[
                                  @"http://img1.imgtn.bdimg.com/it/u=1349402200,3896862547&fm=200&gp=0.jpg",
                                  @"http://img0.imgtn.bdimg.com/it/u=3116552386,496921412&fm=200&gp=0.jpg",
                                  @"http://img0.imgtn.bdimg.com/it/u=1662485028,3246041710&fm=200&gp=0.jpg"
                                  ];
    
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
    
    [bgCycleView addSubview:cycleScrollView3];
    
    return bgCycleView;
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NewsViewController *vc = [[NewsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellString";
    MyNewsCell *cell = [_myTable cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[MyNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.headLabel.text = [_dataArray objectAtIndex:indexPath.row%5];
    cell.contentLabel.text = @"体测如此可怕，那同学们是不是想不测呢？小编告诉你：不可能！！！体测如此可怕，那同学们是不是想不测呢？小编告诉你：不可能！！！";
    cell.topImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new%ld",indexPath.row%5+1]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
//自适应cell高度
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"news !");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

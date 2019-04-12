//
//  MyHealthView.m
//  GraduateProj
//
//  Created by jay on 2019/2/18.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "MyHealthView.h"
#import "FriendCell.h"
#import "ActivityCell.h"
#import "MyNewsCell.h"

@interface MyHealthView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;

@end

@implementation MyHealthView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self setLeftNavItemToBack];
}
- (void)configUI{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}
#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.myTag == 0) {
        static NSString *threeCell = @"friendCell";
        FriendCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
        if(!cell){
            cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:threeCell];
        }
        [cell.goodButton setSelected:YES];
        cell.goodLabel.text = @"❤️ 6";
        cell.nameLabel.text = @"周同学";
        cell.headImageView.image = [UIImage imageNamed:@"headerImage"];
        cell.wordsLabel.text = @"好几天没运动，这几天开始运动\n体重越来越重。前天46.8，今天48.2.\n这两天到底发生了什么事。。。\n我的目标是44，加油！";
        return cell;
    }else if (self.myTag == 1){
        static NSString *cellID = @"myActivityCell";
        ActivityCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        cell.followerLabel.text = @"丁宁、刘诗雯、马龙、樊振东、王皓、石川佳纯、丁宁、刘诗雯、马龙、樊振东、王皓、石川佳纯、丁宁、刘诗雯、马龙、樊振东、王皓、石川佳纯、周同学";
    
        return cell;
    }else{
        static NSString *cellID = @"myCellString";
        MyNewsCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[MyNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        cell.headLabel.text = @"如何提高引体向上的数量";
        cell.contentLabel.text = @"体测如此可怕，那同学们是不是想不测呢？小编告诉你：不可能！！！体测如此可怕，那同学们是不是想不测呢？小编告诉你：不可能！！！";
        cell.topImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new%ld",indexPath.row%2+4]];
        return cell;
    }
}

@end

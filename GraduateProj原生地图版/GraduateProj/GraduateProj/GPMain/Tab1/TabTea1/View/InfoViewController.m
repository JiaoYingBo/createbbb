//
//  InfoViewController.m
//  GraduateProj
//
//  Created by jay on 2018/11/28.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,copy)NSArray *baseInfoArr;
@property (nonatomic,copy)NSArray *restArr;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self setInfoUI];
}
- (void)setData{
    _baseInfoArr = @[@"学号：2011782738",@"姓名：郭达",@"院（系）：计算机学院",@"班级：通信01"];
    _restArr = @[@"身高：  178cm",@"体重： 70kg",@"BMI：  19.2",@"肺活量：  3000ml",@"50米跑：  17s",@"坐位体前屈：  20cm",@"立定跳远：  2.5m",@"引体向上：  9",@"1000米跑：  3min"];
}
- (void)setInfoUI{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _baseInfoArr.count;
    }else{
        return _restArr.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cellStr";
    UITableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [_baseInfoArr objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [_restArr objectAtIndex:indexPath.row];
    }
    return cell;
}

@end

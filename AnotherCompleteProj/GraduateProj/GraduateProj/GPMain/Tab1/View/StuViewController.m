//
//  StuViewController.m
//  GraduateProj
//
//  Created by jay on 2018/11/27.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "StuViewController.h"
#import "DVPieChart.h"
#import "DVFoodPieModel.h"
#import "IndexTableViewCell.h"

#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width

@interface StuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;
@property (nonatomic,copy)NSArray *dataArr;
@property (nonatomic,copy)NSArray *gradeArr;

@end

@implementation StuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStudentData];
    [self setStudentUI];
    
    
}
- (void)setStudentData{
    _dataArr = @[@"13.4",@"18.1",@"20.3"];
    _gradeArr = @[@"低体重",@"正常",@"超重",@"肥胖"];
}
- (void)setStudentUI{
    _myTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.tableHeaderView = [self myStudentHeaderView];
    _myTable.tableFooterView = [self setStudentFooterView];
//    [_myTable registerClass:[IndexTableViewCell class] forCellReuseIdentifier:@"myCell"];
//    [_myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"systemCell"];
    [self.view addSubview:_myTable];
}

//设置一个表头
- (UIView *)myStudentHeaderView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 264)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 250)];
    chart.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    
    [bgView addSubview:chart];
    
    DVFoodPieModel *model1 = [[DVFoodPieModel alloc] init];
    
    model1.rate = 0.66;
    model1.name = @"1";
    //model1.value = 4;
    
    DVFoodPieModel *model2 = [[DVFoodPieModel alloc] init];
    
    model2.rate = 0.34;
    model2.name = @"1";
    //model2.value = 4;
    
    NSArray *dataArray = @[model1, model2];
    
    chart.dataArray = dataArray;
    
    chart.title = @"达标\n分数：66";
    
    [chart draw];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, k_MainBoundsWidth, 24)];
    infoLabel.text = @"张三  排名27，已超越66%的同学";
    infoLabel.textColor = [UIColor whiteColor];
    //infoLabel.backgroundColor = [UIColor greenColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:infoLabel];
    return bgView;
}
//暂时设置成footerview
- (UIView *)setStudentFooterView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 300)];
    bgView.backgroundColor = [UIColor whiteColor];
    //1
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, k_MainBoundsWidth-20, 30)];
    label1.layer.cornerRadius = 3;
    label1.layer.masksToBounds = YES;
    label1.text = @"项目简介";
    label1.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    [bgView addSubview:label1];
    //2安排
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:15];
    label2.numberOfLines = 0;
    label2.text = self.explainStr;
    label2.textColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    CGRect rect = [label2.text boundingRectWithSize:CGSizeMake(k_MainBoundsWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:label2.font} context:nil];
    label2.frame = CGRectMake(20, 30+10, CGRectGetWidth(rect), CGRectGetHeight(rect));
    //label2.backgroundColor = [UIColor greenColor];
    [bgView addSubview:label2];
    //3
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30+10+10+label2.frame.size.height, k_MainBoundsWidth-20, 30)];
    label3.text = @"测量标准";
    label3.layer.cornerRadius = 3;
    label3.layer.masksToBounds = YES;
    label3.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    [bgView addSubview:label3];
    //4安排
    UILabel *label4 = [[UILabel alloc] init];
    label4.font = [UIFont systemFontOfSize:15];
    label4.numberOfLines = 0;
    label4.text = self.stantardStr;
    label4.textColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    CGRect rect4 = [label4.text boundingRectWithSize:CGSizeMake(k_MainBoundsWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:label4.font} context:nil];
    label4.frame = CGRectMake(20, 30+30+label2.frame.size.height+30, CGRectGetWidth(rect4), CGRectGetHeight(rect4));
    //label4.backgroundColor = [UIColor greenColor];
    [bgView addSubview:label4];
    
    bgView.frame = CGRectMake(0, 0, k_MainBoundsWidth, 60+40+label2.frame.size.height+label4.frame.size.height);
    
    return bgView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indenCell =@"myCell";
    IndexTableViewCell *cell = [_myTable cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
       
        cell = [[IndexTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indenCell];
        cell.dataArray = [NSArray arrayWithArray:_dataArr];
        cell.cellDataArray = [NSArray arrayWithArray:_gradeArr];
        cell.currentValue = @"15.5";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

@end

//
//  TabTea1ViewControlelr.m
//  GraduateProj
//
//  Created by jay on 2018/11/28.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "TabTea1ViewControlelr.h"
#import "DVPieChartTeacher.h"
#import "DVFoodPieModel.h"
#import "InfoViewController.h"
#import "StudentModel.h"

#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width

@interface TabTea1ViewControlelr()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong)NSMutableArray *creatNewArr;
@property (nonatomic,strong)NSMutableArray *personArr;
@property (nonatomic,strong)NSMutableArray *personCopyArr;
@end

@implementation TabTea1ViewControlelr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(sortButtonList)];
    
    [self setData];
    [self setUI];
   
}
- (void)sortButtonList{
    //跟上面的流程差不多，记得要把preferredStyle换成UIAlertControllerStyleAlert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择排序方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"按学号排列" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *newResult =
        [weakSelf.personCopyArr sortedArrayUsingComparator:^(id obj1,id obj2)
         {
             StudentModel *stuOne = obj1;
             StudentModel *stuTwo = obj2;
             
             int num1 = [stuOne.number intValue];
             int num2 = [stuTwo.number intValue];
             
             if (num1 < num2)
             {
                 return (NSComparisonResult)NSOrderedAscending;
             }
             else
             {
                 return (NSComparisonResult)NSOrderedDescending;
             }
             return (NSComparisonResult)NSOrderedSame;
         }];
        [weakSelf.personArr removeAllObjects];
        [weakSelf.personArr addObjectsFromArray:newResult];
        [weakSelf.myTableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"按分数排列" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSArray *newResult =
        [weakSelf.personCopyArr sortedArrayUsingComparator:^(id obj1,id obj2)
         {
             StudentModel *stuOne = obj1;
             StudentModel *stuTwo = obj2;
             
             int num1 = [stuOne.score intValue];
             int num2 = [stuTwo.score intValue];
             
             if (num1 > num2)
             {
                 return (NSComparisonResult)NSOrderedAscending;
             }
             else
             {
                 return (NSComparisonResult)NSOrderedDescending;
             }
             return (NSComparisonResult)NSOrderedSame;
         }];
        [weakSelf.personArr removeAllObjects];
        [weakSelf.personArr addObjectsFromArray:newResult];
        [weakSelf.myTableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"显示不达标人数" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        for (int i =(int)weakSelf.personArr.count-1; i >=0; i--) {
            StudentModel *stu = [weakSelf.personArr objectAtIndex:i];
            if ([stu.score intValue]>=60) {
                [weakSelf.personArr removeObjectAtIndex:i];
            }
        }
        
        [weakSelf.myTableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)setData{
   
    _creatNewArr = [NSMutableArray arrayWithObjects:
  @{@"number":@"2017534001",@"name":@"宋 江",@"grade":@"不及格",@"score":@"52"},
  @{@"number":@"2017534002",@"name":@"卢俊义",@"grade":@"良好",@"score":@"83"},
  @{@"number":@"2017534003",@"name":@"关 胜",@"grade":@"良好",@"score":@"84"},
  @{@"number":@"2017534004",@"name":@"秦 明",@"grade":@"及格",@"score":@"60"},
  @{@"number":@"2017534005",@"name":@"呼延灼",@"grade":@"良好",@"score":@"89"},
  @{@"number":@"2017534006",@"name":@"李 应",@"grade":@"优秀",@"score":@"94"},
  @{@"number":@"2017534007",@"name":@"张 清",@"grade":@"良好",@"score":@"87"},
  @{@"number":@"2017534008",@"name":@"徐 宁",@"grade":@"不及格",@"score":@"54"},
  @{@"number":@"2017534009",@"name":@"戴 宗",@"grade":@"优秀",@"score":@"90"},
  @{@"number":@"2017534010",@"name":@"刘 唐",@"grade":@"及格",@"score":@"74"},
  @{@"number":@"2017534011",@"name":@"穆 弘",@"grade":@"良好",@"score":@"82"},
  @{@"number":@"2017534012",@"name":@"扬 雄",@"grade":@"良好",@"score":@"89"},
  @{@"number":@"2017534013",@"name":@"燕 青",@"grade":@"优秀",@"score":@"98"},
  @{@"number":@"2017534014",@"name":@"朱 武",@"grade":@"不及格",@"score":@"59"},
  @{@"number":@"2017534015",@"name":@"孙 立",@"grade":@"良好",@"score":@"84"},
  @{@"number":@"2017534016",@"name":@"郝思文",@"grade":@"优秀",@"score":@"94"},
  @{@"number":@"2017534017",@"name":@"韩 滔",@"grade":@"及格",@"score":@"64"},
  @{@"number":@"2017534018",@"name":@"邓 飞",@"grade":@"良好",@"score":@"81"},
  @{@"number":@"2017534019",@"name":@"杨 林",@"grade":@"不及格",@"score":@"55"},
  @{@"number":@"2017534020",@"name":@"皇甫端",@"grade":@"良好",@"score":@"88"}, nil];
    
    _personArr = [NSMutableArray array];
    _personCopyArr = [NSMutableArray array];
    for(NSDictionary* dict in _creatNewArr) {
        StudentModel *person = [StudentModel StudentModelWithDict:dict];
        [_personArr addObject:person];
        [_personCopyArr addObject:person];
    }
}

- (void)setUI{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView = [self setTableViewHeader];
    [self.view addSubview:_myTableView];
}
- (UIView *)setTableViewHeader{
    UIView *bgTeacherView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 270+10)];
    bgTeacherView.backgroundColor = [UIColor whiteColor];
    
    DVPieChartTeacher *chart = [[DVPieChartTeacher alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 260)];
    chart.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    
    [bgTeacherView addSubview:chart];
    
    DVFoodPieModel *model1 = [[DVFoodPieModel alloc] init];
    model1.rate = 0.22;
    model1.name = @"优秀";
    
    DVFoodPieModel *model2 = [[DVFoodPieModel alloc] init];
    model2.rate = 0.51;
    model2.name = @"良好";
    
    DVFoodPieModel *model3 = [[DVFoodPieModel alloc] init];
    model3.rate = 0.16;
    model3.name = @"及格";
    
    DVFoodPieModel *model4 = [[DVFoodPieModel alloc] init];
    model4.rate = 0.11;
    model4.name = @"不及格";
   
    
    NSArray *dataArray = @[model1, model2,model3,model4];
    
    chart.dataArray = dataArray;
    
    chart.title = @"成绩";
    
    [chart draw];
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, k_MainBoundsWidth, 20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"学生成绩等级分布图";
    titleLab.textColor = [UIColor whiteColor];
    titleLab.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    [bgTeacherView addSubview:titleLab];
   
    return bgTeacherView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgSectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 30)];
    bgSectionHeaderView.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArr = @[@"学号",@"姓名",@"等级",@"分数"];
    float widthLabel = (k_MainBoundsWidth-2-120)/3;
    for (int i = 0; i<4; i++) {
        UILabel *titleLabel = [[UILabel alloc] init];
        if (i == 0) {
            titleLabel.frame = CGRectMake(0, 1, 119, 29);
        }else{
            titleLabel.frame = CGRectMake(120+(widthLabel+1)*(i-1), 1, widthLabel, 29);
        }
        
        titleLabel.text = [titleArr objectAtIndex:i];
        titleLabel.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [bgSectionHeaderView addSubview:titleLabel];
        
    }
    
//    NSArray *segmentArr = @[@"按学号排序",@"按分数排序"];
//    UISegmentedControl *sortSegment = [[UISegmentedControl alloc] initWithItems:segmentArr];
//    sortSegment.frame = CGRectMake(10, 35,[UIScreen mainScreen].bounds.size.width-20, 25);
//    sortSegment.selectedSegmentIndex = 0;
//    [sortSegment addTarget:self action:@selector(sortButtonList:) forControlEvents:UIControlEventValueChanged];
//    [bgSectionHeaderView addSubview:sortSegment];
    
    return bgSectionHeaderView;
}
//- (void)sortButtonList:(UISegmentedControl *)sender{
//    if (sender.selectedSegmentIndex == 0) {
//        NSLog(@"学号");
//    }else{
//         NSLog(@"分数");
//    }
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _personArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifyTeacher = @"teacherCell";
    UITableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifyTeacher];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    StudentModel *person = [_personArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@      %@",person.number,person.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@             %@",person.grade,person.score];
    float scores = [person.score floatValue];
    if (scores < 60) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InfoViewController *vc = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

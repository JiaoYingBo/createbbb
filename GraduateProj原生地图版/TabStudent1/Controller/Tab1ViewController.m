//
//  Tab1ViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab1ViewController.h"
#import "OneTableViewCell.h"
#import "MyReputationView.h"
#import "SecInfoViewController.h"
#import "StarProgressView.h"


@interface Tab1ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * myTableView;
@property (nonatomic,strong)NSMutableArray * dataArray;//项目
@property (nonatomic,strong)NSMutableArray * gradeArray;//分数
@property (nonatomic,strong)NSMutableArray * rangeArray;//等级
@property (nonatomic,strong)NSArray *assessArr;//star评估结果，身体机能
@property (nonatomic,strong)NSArray *starNumberArr;//star number
@property (nonatomic,strong)NSMutableArray * headPicArray;//头像图片
@property (nonatomic,strong)NSMutableArray * numberArray;//学生名次


@end

@implementation Tab1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self setUI];
}
- (void)setData{
    _dataArray = [NSMutableArray arrayWithObjects:@"身高:",@"体重:",@"BMI:",@"肺活量:",@"50米跑:",@"坐位体前屈:",@"立定跳远:",@"引体向上:",@"1000米跑:", nil];
    _rangeArray = [NSMutableArray arrayWithObjects:@" ",@" ",@"优秀",@"良好",@"良好",@"优秀",@"优秀",@"良好",@"优秀", nil];
    _gradeArray = [NSMutableArray arrayWithObjects:@"180cm",@"80kg",@"15.5",@"4000ml",@"50s",@"50cm",@"2.30m",@"15",@"4min", nil];
    _assessArr = @[@"身体形态 :",@"身体机能 :",@"反应能力 :",@"柔韧性 :",@"下肢爆发力 :",@"上肢肌肉 :",@"耐力 :"];
    _starNumberArr = @[@"5",@"4",@"3",@"4",@"2",@"1",@"3"];
    _headPicArray = [NSMutableArray arrayWithObjects:@"jay",@"sijiali",@"lijian",@"mingren",@"kakaxi",@"kobe", nil];
    _numberArray = [NSMutableArray arrayWithObjects:@"张三",@"李四",@"王五",@"赵六",@"孙七",@"王八",@"刘九",@"钱十",@"刘十三",@"周杰伦", nil];
    
}
- (void)setUI{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _myTableView.showsVerticalScrollIndicator = NO;//隐藏滚动条
    //隐藏cell中间的分割线
   _myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    //这里自定义一个headerview
    
    _myTableView.tableHeaderView = [self myTableHeaderView];
    _myTableView.tableFooterView = [self myTableFooterView];
    
    [self.view addSubview:_myTableView];
}
//定义顶部的headerview
- (UIView *)myTableHeaderView{
    UIView * myHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    myHeaderView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    //myHeaderView.backgroundColor = [UIColor yellowColor];
    
    UILabel * reputationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, [UIScreen mainScreen].bounds.size.width, 20)];
    reputationLabel.text = @"     荣誉榜单 :";
    //reputationLabel.font = [UIFont systemFontOfSize:10];
    reputationLabel.textColor = [UIColor colorWithRed:0/255.0f green:205/255.0f blue:133/255.0f alpha:1];
    reputationLabel.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    
    //6个label，一个显示分数，一个显示等级，一个显示排名，放在一个背景view上
    //bg
    UIView * bgView= [[UIView alloc] initWithFrame:CGRectMake(10, 10,  [UIScreen mainScreen].bounds.size.width-20, 160)];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [UIColor colorWithRed:0/255.0f green:205/255.0f blue:133/255.0f alpha:1];
    //bgView.backgroundColor = [UIColor whiteColor];
    
    float bgWidth = [UIScreen mainScreen].bounds.size.width-20;
    float labelWidth = (bgWidth-60)/3;
    //1
    UILabel * overallLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, labelWidth, 55)];
    overallLabel.textAlignment = NSTextAlignmentCenter;
    overallLabel.text = @"总分";
    overallLabel.textColor = [UIColor whiteColor];
    overallLabel.font = [UIFont boldSystemFontOfSize:40];
    //overallLabel.backgroundColor = [UIColor yellowColor];
    //1:1
    UILabel * downOverallLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+65, labelWidth, 55)];
    downOverallLabel.textAlignment = NSTextAlignmentCenter;
    downOverallLabel.text = @"89分";
    downOverallLabel.textColor = [UIColor whiteColor];
    downOverallLabel.font = [UIFont boldSystemFontOfSize:30];
   // downOverallLabel.backgroundColor = [UIColor yellowColor];
    
    
    //2
    UILabel * goodLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+labelWidth+10, 20, labelWidth, 55)];
    goodLabel.textAlignment = NSTextAlignmentCenter;
    goodLabel.text = @"等级";
    goodLabel.textColor = [UIColor whiteColor];
    goodLabel.font = [UIFont boldSystemFontOfSize:40];
    //2:2
    UILabel * downGoodLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+labelWidth+10, 20+65, labelWidth, 55)];
    downGoodLabel.textAlignment = NSTextAlignmentCenter;
    downGoodLabel.text = @"良好";
    downGoodLabel.textColor = [UIColor whiteColor];
    downGoodLabel.font = [UIFont boldSystemFontOfSize:30];
    
    //3
    UILabel * rangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+(labelWidth+10)*2, 20, labelWidth, 55)];
    rangeLabel.textAlignment = NSTextAlignmentCenter;
    rangeLabel.text = @"排名";
    rangeLabel.textColor = [UIColor whiteColor];
    rangeLabel.font = [UIFont boldSystemFontOfSize:40];
   // rangeLabel.backgroundColor = [UIColor grayColor];
    
    //3:3
    UILabel * downRangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+(labelWidth+10)*2, 20+65, labelWidth, 55)];
    downRangeLabel.textAlignment = NSTextAlignmentCenter;
    downRangeLabel.text = @"15";
    downRangeLabel.textColor = [UIColor whiteColor];
    downRangeLabel.font = [UIFont boldSystemFontOfSize:30];
   
    
    //overallLabel.backgroundColor = [UIColor yellowColor];
    
   
    [bgView addSubview:overallLabel];
    [bgView addSubview:downOverallLabel];
    [bgView addSubview:goodLabel];
    [bgView addSubview:downGoodLabel];
    [bgView addSubview:rangeLabel];
    [bgView addSubview:downRangeLabel];
    
    [myHeaderView addSubview:bgView];
    
    [myHeaderView addSubview:reputationLabel];
    
    return myHeaderView;
}

//设置footerview
- (UIView *)myTableFooterView{
    
    UIView * myFooterView = [[UIView alloc] init];
    myFooterView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    
    //这里添加评估结果view（star）
    UIView * bgStarView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 30*_assessArr.count)];
    bgStarView.layer.cornerRadius = 5;
    bgStarView.layer.masksToBounds = YES;
    bgStarView.backgroundColor =  [UIColor colorWithRed:0/255.0f green:205/255.0f blue:133/255.0f alpha:1];
    
    for (int i = 0; i<_assessArr.count; i++) {
        StarProgressView *starView = [[StarProgressView alloc] initWithFrame:CGRectMake(0, 30*i, [UIScreen mainScreen].bounds.size.width-20, 30)];
        //starView.backgroundColor = [UIColor colorWithRed:0/255.0f green:205/255.0f blue:133/255.0f alpha:1];
        
        
        starView.titleLabel.text = [_assessArr objectAtIndex:i];
        
        starView.starNumber = [[_starNumberArr objectAtIndex:i] intValue];
        [bgStarView addSubview:starView];
    }
    myFooterView.frame  = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _assessArr.count*30);
    
    [myFooterView addSubview:bgStarView];
    return myFooterView;
}


#pragma mark -------tableViewDelegate
//设置cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
//设置section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

// cell重用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"cell";
    //OneTableViewCell * cell = [_myTableView dequeueReusableCellWithIdentifier:identify];
    
     OneTableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    
    if (cell == nil) {
        cell = [[OneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.proLable.text = [_dataArray objectAtIndex:indexPath.row];
        cell.gradeLabel.text = [_gradeArray objectAtIndex:indexPath.row];
        cell.rangeLable.text = [_rangeArray objectAtIndex:indexPath.row];
      
        cell.clipsToBounds = YES;
    }
    //去掉选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//section header  view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerSecView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    //headerSecView.backgroundColor = [UIColor blueColor];//bg
    //there are scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    scrollView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    scrollView.contentSize = CGSizeMake(70*10, 100);
    scrollView.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
    
    // 荣誉榜单：前10名
    for (int i = 0; i<10; i++) {
        MyReputationView *myView = [[MyReputationView alloc] initWithFrame:CGRectMake(10+70*i, 10, 60, 90)];
        myView.headView.image =  [UIImage imageNamed:[_headPicArray objectAtIndex:i%6]];
        
        
       // myView.numberLabel.text = [NSString stringWithFormat:@" 第%d名        %@",i+1,[_numberArray objectAtIndex:i]];
        myView.numberLabel.text = [NSString stringWithFormat:@"第%d名\n%@",i+1,[_numberArray objectAtIndex:i]];
        //myView.numberLabel.text = @" 第一名        周杰伦";
        myView.numberLabel.font = [UIFont systemFontOfSize:10];
        
        [scrollView addSubview:myView];
    }
    
    [headerSecView addSubview:scrollView];
    
    
    return  headerSecView;
}
// 设置表头的高度。如果使用自定义表头，该方法必须要实现，否则自定义表头无法执行，也不会报错
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}
//选中cell跳转
-(void)tableView:(UITableView *)talbeView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row != 0 && indexPath.row != 1) {
        SecInfoViewController *vc = [[SecInfoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
@end

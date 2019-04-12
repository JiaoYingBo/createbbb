//
//  SecInfoViewController.m
//  GraduateProj
//
//  Created by jay on 2018/11/19.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "SecInfoViewController.h"
#import "MyReputationView.h"
#import "IndexTableViewCell.h"


@interface SecInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * myTable;
@property (nonatomic,strong)NSMutableArray * headPicArray;//头像图片
@property (nonatomic,strong)NSMutableArray * numberArray;//学生名次
@property (nonatomic,strong)NSArray *segmentArr;//分数段
@property (nonatomic,strong)NSArray *cellRangeArr;//优秀，良好



@end

@implementation SecInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatas];
    [self setupSubviews];
}

- (void)setupDatas{
    _headPicArray = [NSMutableArray arrayWithObjects:@"jay",@"sijiali",@"lijian",@"mingren",@"kakaxi",@"kobe", nil];
    _numberArray = [NSMutableArray arrayWithObjects:@"张三",@"李四",@"王五",@"赵六",@"孙七",@"王八",@"刘九",@"钱十",@"刘十三",@"周杰伦", nil];
    _segmentArr = @[@"13.4",@"18.1",@"20.3"];
    _cellRangeArr = @[@"低体重",@"正常",@"超重",@"肥胖"];
    
}
- (void)setupSubviews{
    _myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.showsVerticalScrollIndicator = NO;
    //隐藏cell中间的分割线
    _myTable.separatorStyle = UITableViewCellSelectionStyleNone;
    _myTable.tableHeaderView = [self myTableHeaderView];
    _myTable.tableFooterView = [self myTableFooterView];
    [self.view addSubview:_myTable];
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
    overallLabel.text = @"分数";
    overallLabel.textColor = [UIColor whiteColor];
    overallLabel.font = [UIFont boldSystemFontOfSize:40];
    //overallLabel.backgroundColor = [UIColor yellowColor];
    //1:1
    UILabel * downOverallLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20+65, labelWidth, 55)];
    downOverallLabel.textAlignment = NSTextAlignmentCenter;
    downOverallLabel.text = @"75分";
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
    downGoodLabel.text = @"及格";
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
    downRangeLabel.text = @"30";
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
- (UIView *)myTableFooterView{
    
    UIColor * titleBgColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    UIColor * contentBgColor = [UIColor whiteColor];
    UIColor * titleWordColor = [UIColor colorWithRed:0/255.0f green:205/255.0f blue:133/255.0f alpha:1];
    UIColor * contentWordColor = [UIColor lightGrayColor];
    UIFont * titleFont = [UIFont boldSystemFontOfSize:25];
    
    float width = [UIScreen mainScreen].bounds.size.width-20;
    
    UIView * footerView = [[UIView alloc] init];
    footerView.backgroundColor =  titleBgColor;
    
    //放置六个label，分别为标题，内容  1。2。3
    UILabel *titleOne = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, width, 30)];
    titleOne.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    titleOne.textColor = titleWordColor;
    titleOne.font = titleFont;
    titleOne.text = @"项目简介:";
    //1:1
    UILabel *contentOne = [[UILabel alloc]init];
    contentOne.backgroundColor = contentBgColor;
    contentOne.layer.cornerRadius = 5;
    contentOne.layer.masksToBounds = YES;
    NSString *oneString = @"  BMI指数（即身体质量指数，简称体质指数又称体重，英文为Body Mass Index，简称BMI），是用体重公斤数除以身高米数平方得出的数字，是目前国际上常用的衡量人体胖瘦程度以及是否健康的一个标准。主要用于统计用途，当我们需要比较及分析一个人的体重对于不同高度的人所带来的健康影响时，BMI值是一个中立而可靠的指标。";
    //设置文本范围。300代表宽度最大为300，到了300则换到下一行；MAXFLOAT代表长度不限
    /*options属性：
     NSStringDrawingTruncatesLastVisibleLine：
     如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略
     NSStringDrawingUsesLineFragmentOrigin：
     绘制文本时使用 line fragement origin 而不是 baseline origin
     NSStringDrawingUsesFontLeading：
     计算行高时使用行距（译者注：字体大小+行间距=行距）*/
    CGRect oneRect = [oneString boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.f]} context:nil];
    contentOne.frame = CGRectMake(10, 30, width, oneRect.size.height);
    contentOne.text = oneString;
    
    contentOne.textColor = contentWordColor;
    contentOne.numberOfLines = 0;
    //2
    UILabel *titleTwo = [[UILabel alloc]initWithFrame:CGRectMake(10, 30+contentOne.frame.size.height, width, 30)];
    titleTwo.backgroundColor = titleBgColor;
    titleTwo.textColor = titleWordColor;
    titleTwo.font = titleFont;
    titleTwo.text = @"锻炼部位:";
    //2:2
    UILabel *contentTwo = [[UILabel alloc]init];
    contentTwo.backgroundColor = contentBgColor;
    contentTwo.layer.cornerRadius = 5;
    contentTwo.layer.masksToBounds = YES;
    NSString *twoString = @"  BMI值原来的设计是一个用于公众健康研究的统计工具。当我们需要知道肥胖是否对某一疾病的致病原因时，我们可以把病人的身高及体重换算成BMI值，再找出其数值及病发率是否有线性关联。不过，随着科技进步，现时BMI值只是一个参考值。要真正量度病人是否肥胖，还需要利用微电力量度病人的阻抗，以推断病者的脂肪厚度。因此，BMI的角色也慢慢改变，从医学上的用途，变为一般大众的纤体指标。";
    
    CGRect twoRect = [twoString boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil];
    contentTwo.frame = CGRectMake(10, 30*2+contentOne.frame.size.height, width, twoRect.size.height);
    contentTwo.text = twoString;
    contentTwo.textColor = contentWordColor;
    contentTwo.numberOfLines = 0;
    
    //3
    UILabel *titleThree = [[UILabel alloc]initWithFrame:CGRectMake(10, 30*2+contentOne.frame.size.height+contentTwo.frame.size.height, width, 30)];
    titleThree.backgroundColor = titleBgColor;
    titleThree.textColor = titleWordColor;
    titleThree.font = titleFont;
    titleThree.text = @"提高方法:";
    
    //3:3
    UILabel *contentThree = [[UILabel alloc]init];
    contentThree.backgroundColor = contentBgColor;
    contentThree.layer.cornerRadius = 5;
    contentThree.layer.masksToBounds = YES;
    NSString *threeString = @"  首先对肥胖者进行肥胖诊断、肥胖成因检测进而制定出量身定制的多学科减肥方案，运用脂肪能量转化的电脑游戏减脂，对于饮食方面，要强化营养配合结构化膳食。同时关注女性生理周期，把握好最佳减脂时刻，在减肥过程中时刻监测体内的脂代谢变化。通过对棕色细胞刺激激活棕色有利脂肪细胞吞噬白色有害脂肪细胞，与此同时加强肠道蠕动防止便秘的发生。最后对所有减肥者进行心理干预，每天自我监督体重，达到养成良好生活习惯的目的。";
    
    CGRect threeRect = [threeString boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil];
    contentThree.frame = CGRectMake(10, 30*3+contentOne.frame.size.height+contentTwo.frame.size.height, width, threeRect.size.height);
    contentThree.text = threeString;
    contentThree.textColor = contentWordColor;
    contentThree.numberOfLines = 0;
    
    float totalHeight = contentOne.frame.size.height+contentTwo.frame.size.height+contentThree.frame.size.height+30*3;
    
    footerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, totalHeight);
    
    [footerView addSubview:titleOne];
    [footerView addSubview:contentOne];
    [footerView addSubview:titleTwo];
    [footerView addSubview:contentTwo];
    [footerView addSubview:titleThree];
    [footerView addSubview:contentThree];
    
    return footerView;
}
//section header  view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerSecView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    headerSecView.backgroundColor = [UIColor blueColor];
    //there are scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    scrollView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    scrollView.contentSize = CGSizeMake(70*10, 100);
    scrollView.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
    
    // 荣誉榜单：前10名
    for (int i = 0; i<10; i++) {
        MyReputationView *myView = [[MyReputationView alloc] initWithFrame:CGRectMake(10+70*i, 10, 60, 90)];
        myView.headView.image =  [UIImage imageNamed:[_headPicArray objectAtIndex:(i+3)%6]];
        
        
        myView.numberLabel.text = [NSString stringWithFormat:@"第%d名\n%@",i+1,[_numberArray objectAtIndex:i]];
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
#pragma dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
//cell
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * identify = @"cell";
    IndexTableViewCell *cell = [_myTable cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    
    if (cell == nil) {
        cell = [[IndexTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        cell.dataArray = [[NSArray alloc] initWithArray:_segmentArr];
        cell.cellDataArray = [[NSArray alloc] initWithArray:_cellRangeArr];
        cell.currentValue = @"15.5";
        cell.clipsToBounds = YES;
        
    }
    //去掉选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma delegate
-(void)tableView:(UITableView *)talbeView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"hello world!");
    
}


@end

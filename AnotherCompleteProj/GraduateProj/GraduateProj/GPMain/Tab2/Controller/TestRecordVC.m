//
//  TestRecordVC.m
//  GraduateProj
//
//  Created by jay on 2019/1/9.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "TestRecordVC.h"
#import "JHChartHeader.h"
#import "showCell.h"
#import "StuViewController.h"

@interface TestRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *arrayNum;
@property(nonatomic,strong)NSMutableArray *frontArr;
@property(nonatomic,copy)NSArray *scoreArr;
@end

@implementation TestRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"历史记录";
    
    [self setDateSource];
    [self setUI];
    
    //[self showColumnView];

}
- (void)setDateSource{
    _frontArr = [NSMutableArray arrayWithObjects:@50,@51,@52,@52,@60,@59,@58,@50,@58,@60,@61,@62,@59, nil];
    _arrayNum = [NSMutableArray array];
    
    for (int i = 0; i<13; i++) {
        NSNumber *num;
        if(i == self.currentWeight){
            num = [_frontArr objectAtIndex:i];
            [_frontArr replaceObjectAtIndex:i withObject:@0];
        }else{
            num = [NSNumber numberWithInt:0];
        }
        [_arrayNum addObject:num];
    }
    _scoreArr = @[@"身高:\n189cm",@"体重:\n78kg",@"BMI:24\n 78分",@"肺活量:4000ml\n 90分",@"50米跑:10s\n 89分",@"坐位体前屈:26cm\n 98分",@"立定跳远:2.5m\n 79分",@"引体向上:20\n 98分",@"1000米跑:2min\n 89分",@" "];
}
- (void)setUI{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView = [self showColumnView];
    [self.view addSubview:_myTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *recordID = @"recordCell";
    showCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
    if(!cell){
        cell = [[showCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recordID];
        cell.frontView.tag = 3000+indexPath.row*2;
        cell.rearView.tag = 3000+indexPath.row*2+1;
        UITapGestureRecognizer *tapFrontClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
        UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
        cell.frontView.scoreLabel.text = [_scoreArr objectAtIndex:indexPath.row*2];
        cell.rearView.scoreLabel.text = [_scoreArr objectAtIndex:indexPath.row*2+1];
        [cell.frontView addGestureRecognizer:tapFrontClick];
        [cell.rearView addGestureRecognizer:tapClick];
    }
    if (indexPath.row == 4) {
        cell.rearView.alpha = 0;
    }else{
        cell.rearView.alpha = 1;
    }
    return cell;
}
- (void)gestureClick:(UIPanGestureRecognizer *)recognizer{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)recognizer;
    NSInteger tag = tap.view.tag-3000;
    NSLog(@"---%ld",(long)tag);
    StuViewController *vc = [[StuViewController alloc] init];
    if (tag > 1) {
        switch (tag) {
            case 2:
            {
                vc.explainStr = @"BMI指数，用体重公斤数除以身高米数平方得出的数字，是目前国际上常用的衡量人体胖瘦程度以及是否健康的一个标准。";
                vc.stantardStr = @"体质指数（BMI）=体重（kg）➗身高⌃2（m）";
            }
                break;
            case 3:
            {
                vc.explainStr = @"指在不限时间的情况下，一次最大吸气后再尽最大能力所呼出的气体量，这代表肺一次最大的机能活动量，是反映人体生长发育水平的重要机能指标之一。";
                vc.stantardStr = @"受试者呈自然站立位，手握文式管手柄，使导压软管在文式管上方，头部略向后仰，尽力深吸气直到不能吸气为止；然后，将嘴对准口嘴缓慢地呼气，直到不能呼气为止。此时，显示屏上显示的数值即为肺活量值。测试2次，测试人员记录最大值，以毫升为单位，不保留小数。2次测试间隔时间不超过15秒。";
            }
                break;
            case 4:
            {
                vc.explainStr = @"是一个能体现快速跑能力和反应能力的体育项目。";
                vc.stantardStr = @"测试前，应在平坦地面上画长50米、宽1.22米的直线跑道若干条，跑道线要清晰。设一端为起点线，另一端为终点线。受试者至少2人一组，站立式起跑；当听到起跑信号后，立即起跑，全力跑向终点线。";
            }
                break;
            case 5:
            {
                vc.explainStr = @"是大中小学体质健康测试项目，测试目的是测量在静止状态下的躯干、腰、髋等关节可能达到的活动幅度，主要反映这些部位的关节、韧带和肌肉的伸展性和弹性及身体柔韧素质的发展水平。";
                vc.stantardStr = @"受试者面向仪器，坐在软垫上，两腿向前伸直；两足跟并拢，蹬在测试仪的挡板上，脚尖自然分开约10—15厘米。测试时，受试者双手并拢，掌心向下平伸，膝关节伸直，身体前屈，用双手中指指尖匀速推动游标平滑前行，直到不能推动为止。受试者共测试2次，测试人员记录最大值，以厘米为单位，精确到小数点后1位。使用电子测试仪时，受试者按照要求推动游标，显示屏显示测试数值。";
            }
                break;
            case 6:
            {
                vc.explainStr = @"不用助跑从立定姿势开始的跳远，反映人体下肢爆发力水平。";
                vc.stantardStr = @"受试者两脚自然分开，站在起跳线后，双脚原地同时起跳。丈量起跳线后缘至最近着地点后缘之间的垂直距离。测试3次，记录最好成绩。以厘米为单位，保留1位小数。";
            }
                break;
            case 7:
            {
                vc.explainStr = @"主要测试上肢肌肉力量的发展水平，为男性上肢力量的考查项目，是自身力量克服自身重力的悬垂力量练习。是最基本的锻炼背部的方法，也是衡量男性体质的重要参考标准和项目之一。";
                vc.stantardStr = @"受试者面向单杠，自然站立；然后跃起正手握杠，双手分开与肩同宽，身体呈直臂悬垂姿势。待身体停止晃动后，两臂同时用力，向上引体；引体时，身体不得有任何附加动作。当下颌超过横杠上缘时，还原，呈直臂悬垂姿势，为完成1次。测试人员记录受试者完成的次数。以次为单位。";
            }
                break;
            case 8:
            {
                vc.explainStr = @"长时间的连续肌肉活动，主要反映人体耐力水平。";
                vc.stantardStr = @"受试者至少2人一组，站立式起跑。当听到起跑信号后，立即起跑，全力跑向终点线。发令员站在起点线的侧面，在发出起跑信号的同时，挥动发令旗。计时员位于终点线的侧面，视发令旗挥动的同时，开表计时；当受试者跑完全程，胸部到达终点线的垂直面时停表。记录以秒为单位，保留小数点后1位。小数点后第2位数按非“0”进“1”的原则进位。";
            }
                break;
                
            default:
                break;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)showColumnView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 350)];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    titleLab.text = @"  体重历史记录（单位：kg）：";
    [bgView addSubview:titleLab];
    JHColumnChart *column = [[JHColumnChart alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 320)];
    
    /*        Create an array of data sources, each array is a module data. For example, the first array can represent the average score of a class of different subjects, the next array represents the average score of different subjects in another class        */
    column.valueArr = @[
                        @[@[[_frontArr objectAtIndex:0],[_arrayNum objectAtIndex:0]]],//第一组元素 如果有多个元素，往该组添加，每一组只有一个元素，表示是单列柱状图| |
                        @[@[[_frontArr objectAtIndex:1],[_arrayNum objectAtIndex:1]]],
                        @[@[[_frontArr objectAtIndex:2],[_arrayNum objectAtIndex:2]]],
                        @[@[[_frontArr objectAtIndex:3],[_arrayNum objectAtIndex:3]]],
                        @[@[[_frontArr objectAtIndex:4],[_arrayNum objectAtIndex:4]]],
                        @[@[[_frontArr objectAtIndex:5],[_arrayNum objectAtIndex:5]]],
                        @[@[[_frontArr objectAtIndex:6],[_arrayNum objectAtIndex:6]]],
                        @[@[[_frontArr objectAtIndex:7],[_arrayNum objectAtIndex:7]]],
                        @[@[[_frontArr objectAtIndex:8],[_arrayNum objectAtIndex:8]]],
                        @[@[[_frontArr objectAtIndex:9],[_arrayNum objectAtIndex:9]]],
                        @[@[[_frontArr objectAtIndex:10],[_arrayNum objectAtIndex:10]]],
                        @[@[[_frontArr objectAtIndex:11],[_arrayNum objectAtIndex:11]]],
                        @[@[[_frontArr objectAtIndex:12],[_arrayNum objectAtIndex:12]]]
                        ];
    
    //This point represents the distance from the lower left corner of the origin.
    column.originSize = CGPointMake(30, 20);
    /*    The first column of the distance from the starting point     */
    column.drawFromOriginX = 20;
    column.backgroundColor = [UIColor blackColor];
    column.typeSpace = 15;
    column.isShowYLine = YES;
    column.contentInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    /*        Column width         */
    column.columnWidth = 40;
    /*        Column backgroundColor         */
    column.bgVewBackgoundColor = kColor(236, 236, 236, 1);
    /*        X, Y axis font color         */
    column.drawTextColorForX_Y = [UIColor blackColor];
    /*        X, Y axis line color         */
    column.colorForXYLine = [UIColor darkGrayColor];
    /*    Each module of the color array, such as the A class of the language performance of the color is red, the color of the math achievement is green     */
    column.columnBGcolorsArr = @[@[kColor(0, 191, 245, 1),[UIColor greenColor]],@[[UIColor redColor],[UIColor greenColor]],@[kColor(0, 191, 245, 1),[UIColor greenColor]]];//如果为复合型柱状图 即每个柱状图分段 需要传入如上颜色数组 达到同时指定复合型柱状图分段颜色的效果
    /*        Module prompt         */
    column.xShowInfoText = @[@"2018.10.01",@"2018.10.29",@"2018.11.11",@"2018.11.21",@"2018.11.29",@"2018.12.02",@"2018.12.12",@"2018.12.31",@"2019.01.06",@"2019.01.10",@"2019.01.18",@"2019.02.09",@"2019.2.21"];
    column.isShowLineChart = YES;
    column.lineChartPathColor = [UIColor blackColor];
    column.lineChartValuePointColor = [UIColor blackColor];
    column.lineValueArray =  @[@50,@51,@52,@52,@60,@59,@58,@50,@58,@60,@61,@62,@59];
    
    //column.delegate = self;
    /*       Start animation        */
    [column showAnimation];
    [bgView addSubview:column];
    return bgView;
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

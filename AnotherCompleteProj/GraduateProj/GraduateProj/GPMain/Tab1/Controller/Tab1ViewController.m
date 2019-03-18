//
//  Tab1ViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab1ViewController.h"
#import "JHChartHeader.h"
#import "DVPieChart.h"
#import "DVFoodPieModel.h"
#import "StuViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "SingleObj.h"

#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width
#define k_MainBoundsHeight [UIScreen mainScreen].bounds.size.height


@interface Tab1ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,copy)NSArray *proNameArr;
@property (nonatomic,copy)NSArray *scoreArr;

@property (nonatomic,strong)CMPedometer *pedometer;


@end

@implementation Tab1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SingleObj *obj = [SingleObj share];
    
    //步数。。。
    _pedometer = [[CMPedometer alloc] init];// pedometer 计步器
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    //开始日期
    NSDate *startDate = [calendar dateFromComponents:components];
    //结束日期
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    //判断记步功能
    if ([CMPedometer isStepCountingAvailable]) {
        [_pedometer queryPedometerDataFromDate:startDate toDate:endDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error==%@",error);
            }else{
                NSLog(@"bu shu == %@",pedometerData.numberOfSteps);
                NSLog(@"ju li == %@",pedometerData.distance);
                obj.stepsNumber = [pedometerData.numberOfSteps floatValue];
                obj.distance = [pedometerData.distance floatValue];
                //NSLog(@"%@-%@",[pedometerData.numberOfSteps stringValue],obj.distance);
            }
        }];
    }else{
        NSLog(@"don't avaiable");
    }
    
    [self setData];
    [self setUI];
}
- (void)setData{
    _proNameArr = @[@"身高: 175cm",@"体重: 54kg",@"BMI: 20.3",@"肺活量: 2000ml",@"50米跑: 10s",@"坐位体前屈: 20cm",@"立定跳远: 2.5m",@"引体向上: 12",@"1000跑: 3min"];
    _scoreArr = @[@" ",@" ",@"良好   75分",@"优秀   90分",@"优秀   85分",@"良好   75分",@"及格   69分",@"良好   79分",@"优秀   95分",];
}
- (void)setUI{
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    //_myTableView.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.tableHeaderView = [self myHeaderView];
    _myTableView.tableFooterView = [self myFooterView];
    [self.view addSubview:_myTableView];
}
//设置一个表头
- (UIView *)myHeaderView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 264)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 250)];
    chart.backgroundColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    
    [bgView addSubview:chart];
    
    DVFoodPieModel *model1 = [[DVFoodPieModel alloc] init];
    
    model1.rate = 0.78;
    model1.name = @"1";
    //model1.value = 4;
    
    DVFoodPieModel *model2 = [[DVFoodPieModel alloc] init];
    
    model2.rate = 0.22;
    model2.name = @"1";
    //model2.value = 4;
    
    NSArray *dataArray = @[model1, model2];
    
    chart.dataArray = dataArray;
    
    chart.title = @"达标\n总分：78";
    
    [chart draw];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, k_MainBoundsWidth, 24)];
    infoLabel.text = @"张三  排名24，已超越76%的同学";
    infoLabel.textColor = [UIColor whiteColor];
    //infoLabel.backgroundColor = [UIColor greenColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:infoLabel];
    return bgView;
}
- (UIView *)myFooterView{
    UIView *footBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 320)];
    footBgView.backgroundColor = [UIColor redColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, k_MainBoundsWidth, 20)];
    titleLab.text = @"   身体素质七维评估模型";
    titleLab.backgroundColor = [UIColor colorWithRed:239/255.f green:238/255.f blue:244/255.f alpha:1];
    titleLab.textColor = [UIColor colorWithRed:0 green:191/255.f blue:242/255.f alpha:1];
    [footBgView addSubview:titleLab];
    
    JHRadarChart *radarChart = [[JHRadarChart alloc] initWithFrame:CGRectMake(0, 20, k_MainBoundsWidth, 300)];
    radarChart.backgroundColor = [UIColor whiteColor];
    /*       Each point of the description text, according to the number of the array to determine the number of basic modules         */
    radarChart.valueDescArray = @[@"身体形态",@"身体机能",@"反应能力",@"柔韧性",@"下肢爆发力",@"上肢肌肉",@"耐力"];
    
    /*         Number of basic module layers        */
    radarChart.layerCount = 5;
    
    /*        Array of data sources, the need to add an array of arrays         */
   // radarChart.valueDataArray = @[@[@"80",@"40",@"100",@"76",@"75",@"50"],@[@"50",@"80",@"30",@"46",@"35",@"50"]];
     radarChart.valueDataArray = @[@[@"80",@"56",@"90",@"76",@"75",@"66",@"83"]];
    
    /*        Color of each basic module layer         */
    radarChart.layerFillColor = [UIColor colorWithRed:94/ 256.0 green:187/256.0 blue:242 / 256.0 alpha:0.5];
    
    /*        The fill color of the value module is required to specify the color for each value module         */
    radarChart.valueDrawFillColorArray = @[[UIColor colorWithRed:57/ 256.0 green:137/256.0 blue:21 / 256.0 alpha:0.5],[UIColor colorWithRed:149/ 256.0 green:68/256.0 blue:68 / 256.0 alpha:0.5]];
    
    /*       show        */
    [radarChart showAnimation];
    
    [footBgView addSubview:radarChart];
    
    return footBgView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _proNameArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifyCell = @"cellStr";
    UITableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifyCell];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        cell.textLabel.text = [_proNameArr objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [_scoreArr objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = [UIImage imageNamed:@"zhibiao"];
    }
    if (indexPath.row >1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StuViewController *vc = [[StuViewController alloc] init];
    if (indexPath.row > 1) {
        switch (indexPath.row) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

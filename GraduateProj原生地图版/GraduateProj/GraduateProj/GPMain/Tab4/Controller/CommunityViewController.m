//
//  CommunityViewController.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/18.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "CommunityViewController.h"
#import "FriendCell.h"
#import "MapTestViewController.h"
#import "ComHeaderView.h"
#import "DairyViewController.h"
#import "AcivityViewController.h"

#import "ActivityCell.h"

@interface CommunityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dianZanArr;
@property(nonatomic,strong)NSMutableArray *infoArr;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)NSMutableArray *nameArr;
@property(nonatomic,strong)NSMutableArray *numberArr;
@property(nonatomic,copy)NSString *followerStr;

@end

//int seconds,mins,hours;

@implementation CommunityViewController {
    int seconds,mins,hours;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClick)];
    
    [self setData];
    [self setUI];
    [self setLeftNavItemToBack];
}
- (void)addButtonClick{
    
}
- (void)setData{
    _dianZanArr = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0,@0, nil];
    _imageArr = [NSMutableArray arrayWithObjects:@"huo1",@"huo2",@"huo3",@"huo4", nil];
    _nameArr = [NSMutableArray arrayWithObjects:@"鸣人",@"小李",@"二柱子",@"鼬神",@"卡卡西", nil];
    _infoArr = [NSMutableArray arrayWithObjects:@"今天完成了64分钟的训练，死亡腿卡\n深蹲50*4组\n倒蹲80*4组\n坐姿腿屈伸20*4组\n今天小重量，主要训练控制力，慢放快推，酸爽的要哭\n泡沫轴放松后感觉还好，下楼无压力",@"今天完成了51分钟的训练，做了几组负重深蹲，一直左右腿发力不均，需要好好练习下",@"好几天没运动，这几天开始运动，体重越来越重。前天46.8，今天48.2.这两天到底发生了什么事。。。我的目标是44，加油！",@"今天状态4分！\n公司健身房肩部练习\n杠铃前后交替肩举10*5\n前平举12*8\n侧平举12*8\n后平举12*8",@"美国芯片巨头美光部分产品在华遭禁售",@"7 月 3 日福州中级法院裁定对美国芯片巨头美光（Micron）发出“诉中禁令”，美国部分闪存 SSD 和内存条 DRAM 将暂时遭禁止在中国销售，虽不是最终判决，但似乎暗示美光确实有侵权之嫌。",@"美光方面周二表示，尚未收到竞争对手台联电早些时候提到的在中国大陆销售芯片的临时禁令。美光表示，在评估来自福州中级人民法院的文件之前，该公司不会对此置评",@"小米或成史上最快纳入恒生指数的港股，一手中签率100%",@"自小米宣布IPO以来，这家超级独角兽就在不停地创造纪录。",@"先是将成首家同股不同权的港股上市公司;招股书又披露在全球营收超千亿且盈利的互联网公司中，小米增速排名第一;认购结束后，小米录得近10倍超购，打破2011年以来大盘股认购倍数纪录，成为全球最大散户规模的IPO，是香港有史以来规模最大的民营公司IPO，全球第三的科技公司IPO",@"业内人士表示，小米上市后或将在10个交易日后被纳入恒生综合指数，创下港股史上最快纪录",@"此外，香港信报消息显示援引市场消息显示，小米一手中签率100%，逾2.5万人申请一手；至于获分派2手有1.5万人，认购9手稳获2手。至于B组的大户方面，最大一张飞为认购1000万股，获分97.2万股，即4860手。小米将于7月9日挂牌", nil];
    _numberArr = [NSMutableArray arrayWithObjects:@0,@1,@0,@0,@0,@1,@0,@0,@0,@1,@0,@0,@0,@1,@0,@0, nil];
    _followerStr = @"丁宁、刘诗雯、马龙、樊振东、王皓、石川佳纯、丁宁、刘诗雯、马龙、樊振东、王皓、石川佳纯、丁宁、刘诗雯、马龙、樊振东、王皓、石川佳纯";
}
- (void)setUI{
    self.navigationItem.title = @"社区";
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 300;
    
    ComHeaderView *headerView = [[ComHeaderView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 200)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView.diaryBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.trainBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.releaseBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
    
    self.timeView = [[grayTimeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.timeView.alpha = 0;
    [self.timeView.pauseBtn addTarget:self action:@selector(pauseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.timeView.endBtn addTarget:self action:@selector(endBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.timeView.goBtn addTarget:self action:@selector(goBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timeView];
}
-(NSTimer*)timer{
    if (!_timer) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1  target:self  selector:@selector(beginChange) userInfo:nil  repeats:YES];
    }
    return _timer;
}
- (void)beginChange{
    seconds++;
    if (seconds >= 60) {
        seconds = 1;
        mins++;
    }
    if (mins>=60) {
        mins = 1;
        hours++;
    }
    self.timeView.timerLabel.text = [NSString stringWithFormat:@"%02d-%02d-%02d",hours,mins,seconds];
    
}
#pragma mark -- timeView Btn Method
- (void)endBtnClick{
    self.timeView.alpha = 0;
    self.timeView.pauseBtn.alpha = 1;
    self.timeView.endBtn.alpha = 0;
    self.timeView.goBtn.alpha = 0;
    
    [self.timer invalidate];
    self.timer = nil;
    self.timeView.timerLabel.text = @"00-00-00";
    
    DairyViewController *vc = [[DairyViewController alloc] init];
    vc.timeStr = self.timeView.timerLabel.text;
    vc.dairyBlock = ^(NSString * _Nonnull str) {
        [_infoArr insertObject:str atIndex:0];
        [_tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goBtnClick{
    self.timeView.pauseBtn.alpha = 1;
    self.timeView.endBtn.alpha = 0;
    self.timeView.goBtn.alpha = 0;
    [self.timer setFireDate:[NSDate distantPast]];
}
- (void)pauseBtnClick{
    self.timeView.pauseBtn.alpha = 0;
    self.timeView.goBtn.alpha = 1;
    self.timeView.endBtn.alpha = 1;
    [self.timer setFireDate:[NSDate distantFuture]];
}

#pragma mark -- other
- (void)headerBtnClick:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"健康日记"]) {
        DairyViewController *vc = [[DairyViewController alloc] init];
        vc.dairyBlock = ^(NSString * _Nonnull str) {
            [_infoArr insertObject:str atIndex:0];
            [_tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if([sender.currentTitle isEqualToString:@"开始训练"]){
        
        self.timeView.alpha = 1;
        [self.timer fire];
    }else{
        AcivityViewController *vc = [[AcivityViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_numberArr objectAtIndex:indexPath.row] intValue] == 1) {
        static NSString *cellID = @"activityCell";
        ActivityCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        __weak typeof(self) weakSelf = self;
        cell.followerLabel.text = _followerStr;
        cell.addClick = ^(){
            weakSelf.followerStr = [weakSelf.followerStr stringByAppendingString:@"、李健同学"];
            //NSLog(@"add %ld--%@",(long)indexPath.row,weakSelf.followerStr);
            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    }else{
        static NSString *threeCell = @"threeCell";
        FriendCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if(!cell){
            cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:threeCell];
        }
        [cell.goodButton setSelected:([[_dianZanArr objectAtIndex:indexPath.row] intValue]==0)?NO:YES];
        cell.goodLabel.text = [NSString stringWithFormat:@"❤️ %@",[_dianZanArr objectAtIndex:indexPath.row]];
        cell.nameLabel.text = [_nameArr objectAtIndex:indexPath.row%5];
        cell.headImageView.image = [UIImage imageNamed:[_imageArr objectAtIndex:indexPath.row%4]];
        __weak typeof(self) weakSelf = self;
        cell.wordsLabel.text = [_infoArr objectAtIndex:indexPath.row];
        cell.goodClick = ^(){
            NSLog(@"good %ld",(long)indexPath.row);
            if ([[weakSelf.dianZanArr objectAtIndex:indexPath.row] intValue] == 0) {
                [weakSelf.dianZanArr replaceObjectAtIndex:indexPath.row withObject:@1];
            }else{
                [weakSelf.dianZanArr replaceObjectAtIndex:indexPath.row withObject:@0];
            }
            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        
        cell.commentClick = ^(){
            NSLog(@"comment %ld",(long)indexPath.row);
        };
        return cell;
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//     return 120;
//}

@end

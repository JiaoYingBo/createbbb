//
//  RunControlView.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/12.
//  Copyright © 2019 mlg. All rights reserved.
//

/**
 1、已知体重、距离 跑步热量（kcal）＝体重（kg）×距离（公里）×1.036 例如：体重60公斤的人，长跑8公里，那么消耗的热量＝60×8×1.036＝497.28 kcal(千卡)
 
 2、已知体重、速度和时间 跑步热量（kcal）＝体重（kg）×运动时间（分钟）×指数K 一小时8公里 K＝0.1355 一小时12公里 K＝0.1797 一小时15公里 K＝0.1875 体重60公斤的人，长跑1小时，速度为8公里/小时，那么消耗的热量＝60×60×0.1355=487.8kcal(千卡) 需要指出的是以上公式都很粗略，因为它们忽视了年龄、性别、体质和基础代谢率等因素，只是给大家提供一个参考。
 */

#import "RunControlView.h"
#import "RunStateButton.h"

@interface RunControlView ()

@property (nonatomic, strong) UIView *gps1;
@property (nonatomic, strong) UIView *gps2;
@property (nonatomic, strong) UIView *gps3;
@property (nonatomic, strong) RunStateButton *stateBtn1;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int count;
// timer是否是暂停状态
@property (nonatomic, assign) BOOL timerIsPause;

@end

@implementation RunControlView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _timerIsPause = NO;
        [self configUI];
        self.GPSStrength = 0;
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = kColor(51, 51, 68, 1);
    
    UILabel *distanceLab = [UILabel new];
    distanceLab.text = @"公里";
    distanceLab.textColor = [UIColor whiteColor];
    distanceLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:distanceLab];
    [distanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(60);
        make.right.equalTo(self).offset(-90);
    }];
    
    UILabel *distance = [UILabel new];
    distance.text = @"0.00";
    distance.textColor = [UIColor whiteColor];
    distance.font = [UIFont fontWithName:@"Helvetica Neue" size:60];
    [self addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(distanceLab).offset(10);
        make.centerX.equalTo(self);
    }];
    self.distanceLabel = distance;
    
    UILabel *speedLab = [UILabel new];
    speedLab.text = @"公里/小时";
    speedLab.textColor = kColor(129, 129, 129, 1);
    speedLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:speedLab];
    [speedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(190);
        make.left.equalTo(self).offset(20);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = kColor(240, 248, 255, 0.5);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(70);
        make.right.equalTo(self);
        make.top.equalTo(self).offset(110);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *gpsLab = [UILabel new];
    gpsLab.text = @"GPS";
    gpsLab.textColor = kColor(129, 129, 129, 1);
    gpsLab.font = [UIFont boldSystemFontOfSize:13];
    [self addSubview:gpsLab];
    [gpsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(line);
        make.left.equalTo(self).offset(8);
    }];
    
    // 绿色：78, 176, 11
    self.gps1 = [UIView new];
    self.gps1.backgroundColor = kColor(78, 176, 11, 1);
    [self addSubview:self.gps1];
    [self.gps1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gpsLab.mas_right).offset(8);
        make.centerY.equalTo(gpsLab);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(6);
    }];
    self.gps2 = [UIView new];
    self.gps2.backgroundColor = kColor(78, 176, 11, 1);
    [self addSubview:self.gps2];
    [self.gps2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gps1.mas_right).offset(5);
        make.centerY.equalTo(gpsLab);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(6);
    }];
    self.gps3 = [UIView new];
    self.gps3.backgroundColor = kColor(78, 176, 11, 1);
    [self addSubview:self.gps3];
    [self.gps3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gps2.mas_right).offset(5);
        make.centerY.equalTo(gpsLab);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(6);
    }];
    
    UILabel *speed = [UILabel new];
    speed.text = @"--";
    speed.textColor = [UIColor whiteColor];
    speed.font = [UIFont fontWithName:@"Helvetica Neue" size:35];
    [self addSubview:speed];
    [speed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(speedLab.mas_top).offset(-10);
        make.centerX.equalTo(speedLab);
    }];
    self.speedLabel = speed;
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"时间";
    timeLab.textColor = kColor(129, 129, 129, 1);
    timeLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(speedLab);
        make.centerX.equalTo(self);
    }];
    
    UILabel *time = [UILabel new];
    time.text = @"00:00:00";
    time.textColor = [UIColor whiteColor];
    time.font = [UIFont fontWithName:@"Helvetica Neue" size:35];
    [self addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.speedLabel);
        make.centerX.equalTo(timeLab);
    }];
    self.timeLabel = time;
    
    UILabel *calLab = [UILabel new];
    calLab.text = @"消耗/千卡";
    calLab.textColor = kColor(129, 129, 129, 1);
    calLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:calLab];
    [calLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(speedLab);
        make.right.equalTo(self).offset(-20);
    }];
    
    UILabel *cal = [UILabel new];
    cal.text = @"0";
    cal.textColor = [UIColor whiteColor];
    cal.font = [UIFont fontWithName:@"Helvetica Neue" size:35];
    [self addSubview:cal];
    [cal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.speedLabel);
        make.centerX.equalTo(calLab);
    }];
    self.calorieLabel = cal;
    
    RunStateButton *stateBtn1 = [[RunStateButton alloc] initWithFrame:CGRectMake(60, 240, 100, 100)];
    stateBtn1.tintColor = kColor(220, 220, 220, 1); // 灰色
    stateBtn1.title = @"结束";
    stateBtn1.status = RunStateButtonStatusInvalid;
    [self addSubview:stateBtn1];
    self.stateBtn1 = stateBtn1;
    __weak typeof(self)weakSelf = self;
    stateBtn1.didEnd = ^{
        [weakSelf stopTimer];
        if ([weakSelf.delegate respondsToSelector:@selector(runControlViewDidEnd:)]) {
            [weakSelf.delegate runControlViewDidEnd:weakSelf];
        }
    };
    
    RunStateButton *stateBtn2 = [[RunStateButton alloc] initWithFrame:CGRectMake(215, 240, 100, 100)];
    stateBtn2.tintColor = kColor(71, 190, 112, 1); // 绿色
    stateBtn2.title = @"开始";
    stateBtn2.status = RunStateButtonStatusStart;
    [self addSubview:stateBtn2];
    stateBtn2.didStart = ^{
        if (self.timerIsPause) {
            [weakSelf continueTimer];
            if ([weakSelf.delegate respondsToSelector:@selector(runControlViewDidContinue:)]) {
                [weakSelf.delegate runControlViewDidContinue:weakSelf];
            }
        } else {
            if ([weakSelf.delegate respondsToSelector:@selector(runControlViewDidStart:)]) {
                [weakSelf.delegate runControlViewDidStart:weakSelf];
            }
        }
        // 开始和继续的时候让结束按钮不可点击
        weakSelf.stateBtn1.status = RunStateButtonStatusInvalid;
        weakSelf.stateBtn1.tintColor = kColor(220, 220, 220, 1); // 灰色
    };
    stateBtn2.didPause = ^{
        [weakSelf pauseTimer];
        if ([weakSelf.delegate respondsToSelector:@selector(runControlViewDidPause:)]) {
            [weakSelf.delegate runControlViewDidPause:weakSelf];
        }
        // 暂停的时候才能结束跑步
        weakSelf.stateBtn1.status = RunStateButtonStatusEnd;
        weakSelf.stateBtn1.tintColor = kColor(233, 83, 83, 1); // 红色
    };
}

- (void)setGPSStrength:(NSInteger)GPSStrength {
    _GPSStrength = GPSStrength;
    // 0:无效 1:弱 2:强 3:超强
    UIColor *gray = [UIColor lightGrayColor];
    UIColor *green = kColor(78, 176, 11, 1);
    if (GPSStrength == 0) {
        self.gps1.backgroundColor = gray;
        self.gps2.backgroundColor = gray;
        self.gps3.backgroundColor = gray;
    } else if (GPSStrength == 1) {
        self.gps1.backgroundColor = green;
        self.gps2.backgroundColor = gray;
        self.gps3.backgroundColor = gray;
    } else if (GPSStrength == 2) {
        self.gps1.backgroundColor = green;
        self.gps2.backgroundColor = green;
        self.gps3.backgroundColor = gray;
    } else if (GPSStrength == 3) {
        self.gps1.backgroundColor = green;
        self.gps2.backgroundColor = green;
        self.gps3.backgroundColor = green;
    }
}

- (void)updateDistance:(nullable NSString *)distance speed:(nullable NSString *)speed calorie:(nullable NSString *)calorie {
    if (distance == nil) {
        self.speedLabel.text = speed;
    } else {
        self.distanceLabel.text = distance;
        self.speedLabel.text = speed;
        self.calorieLabel.text = calorie;
    }
}

- (void)repeatTime {
    self.count ++;
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",self.count/3600,self.count/60,self.count%60];
}

- (void)timeStart {
    [self startTimer];
}

- (void)startTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.count = 0;
    self.timerIsPause = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatTime) userInfo:nil repeats:YES];
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.runDuration = self.count;
    self.count = 0;
    self.timerIsPause = NO;
}

- (void)pauseTimer {
    [self.timer setFireDate:[NSDate distantFuture]];
    // 暂停后再点继续，timer会立刻调一次函数，会导致秒数立马加一，所以暂停的时候先给它减一
    if (self.count > 0) {
        self.count --;
    }
    self.timerIsPause = YES;
}

- (void)continueTimer {
    [self.timer setFireDate:[NSDate date]];
    self.timerIsPause = NO;
}

@end

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

@implementation RunControlView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = kColor(51, 51, 68, 1);
    
    UILabel *distanceLab = [UILabel new];
    distanceLab.text = @"KM";
    distanceLab.textColor = kColor(129, 129, 129, 1);
    distanceLab.font = [UIFont systemFontOfSize:17];
    [self addSubview:distanceLab];
    [distanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(80);
        make.right.equalTo(self).offset(-100);
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
    speedLab.text = @"配速";
    speedLab.textColor = kColor(129, 129, 129, 1);
    speedLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:speedLab];
    [speedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(190);
        make.left.equalTo(self).offset(40);
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
    timeLab.font = [UIFont systemFontOfSize:16];
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
    calLab.text = @"消耗";
    calLab.textColor = kColor(129, 129, 129, 1);
    calLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:calLab];
    [calLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(speedLab);
        make.right.equalTo(self).offset(-40);
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
    stateBtn1.tintColor = kColor(233, 83, 83, 1);
    stateBtn1.titleLabel.text = @"结束";
    [self addSubview:stateBtn1];
    
    RunStateButton *stateBtn2 = [[RunStateButton alloc] initWithFrame:CGRectMake(215, 240, 100, 100)];
    stateBtn2.tintColor = kColor(71, 190, 112, 1);
    stateBtn2.titleLabel.text = @"开始";
    [self addSubview:stateBtn2];
}

@end

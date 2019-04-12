//
//  ResultView.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

// 分别是：总计时间 全程距离 均速 配速 消耗大卡
- (void)configWithDatas:(NSArray *)array {
    self.timeLabel.text = array[0];
    self.distanceLabel.text = array[1];
    self.junsuLabel.text = array[2];
    self.peisuLabel.text = array[3];
    self.xiaohaoLabel.text = array[4];
}

- (void)configUI {
    self.backgroundColor = [UIColor blackColor];
    
    //设置中文倾斜
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(35 * (CGFloat)M_PI / 180), 1, 0, 0);
    //设置反射倾斜角度
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:[UIFont fontWithName:@"Noteworthy" size:27].fontName matrix:matrix];
    //取得系统字符并设置反射
    UILabel *logo = [UILabel new];
    logo.text = @"校园运动-sport  ";
    logo.textColor = kColor(245, 150, 25, 1);
    logo.font = [UIFont fontWithDescriptor:desc size:13];
    [self addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(8);
    }];
    
    
    UILabel *time = [UILabel new];
    time.text = @"00:00:00";
    time.textColor = [UIColor whiteColor];
    time.font = [UIFont fontWithName:@"DBLCDTempBlack" size:27];
    [self addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(37);
    }];
    self.timeLabel = time;
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"总计时间";
    timeLab.textColor = kColor(129, 129, 129, 1);
    timeLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(time.mas_bottom).offset(3);
    }];
    
    UILabel *distanceLab = [UILabel new];
    distanceLab.text = @"KM";
    distanceLab.textColor = [UIColor whiteColor];
    distanceLab.font = [UIFont fontWithName:@"DBLCDTempBlack" size:25];
    [self addSubview:distanceLab];
    [distanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(38);
        make.right.equalTo(self).offset(-20);
    }];
    
    UILabel *distance = [UILabel new];
    distance.text = @"0.00";
    distance.textColor = [UIColor whiteColor];
    distance.font = [UIFont fontWithName:@"DBLCDTempBlack" size:53];
    [self addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.right.equalTo(distanceLab.mas_left).offset(-3);
    }];
    self.distanceLabel = distance;
    
    UILabel *disLab = [UILabel new];
    disLab.text = @"全程距离";
    disLab.textColor = kColor(129, 129, 129, 1);
    disLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:disLab];
    [disLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(timeLab);
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"Flare"];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(5);
        make.top.equalTo(disLab.mas_bottom).offset(10);
    }];
    
    UILabel *jsLab = [UILabel new];
    jsLab.text = @"均速：公里/时";
    jsLab.textColor = kColor(129, 129, 129, 1);
    jsLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:jsLab];
    [jsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    UILabel *junsu = [UILabel new];
    junsu.text = @"0.00";
    junsu.textColor = [UIColor whiteColor];
    junsu.font = [UIFont fontWithName:@"DBLCDTempBlack" size:27];
    [self addSubview:junsu];
    [junsu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(jsLab);
        make.top.equalTo(img.mas_bottom).offset(12);
    }];
    self.junsuLabel = junsu;
    
    UILabel *psLab = [UILabel new];
    psLab.text = @"配速：分/公里";
    psLab.textColor = kColor(129, 129, 129, 1);
    psLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:psLab];
    [psLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(5);
        make.bottom.equalTo(jsLab);
    }];

    UILabel *peisu = [UILabel new];
    peisu.text = @"00'00''";
    peisu.textColor = [UIColor whiteColor];
    peisu.font = [UIFont fontWithName:@"DBLCDTempBlack" size:27];
    [self addSubview:peisu];
    [peisu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(psLab).offset(3);
        make.top.equalTo(junsu);
    }];
    self.peisuLabel = peisu;

    UILabel *xhLab = [UILabel new];
    xhLab.text = @"消耗：大卡";
    xhLab.textColor = kColor(129, 129, 129, 1);
    xhLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:xhLab];
    [xhLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.bottom.equalTo(jsLab);
    }];

    UILabel *xiaohao = [UILabel new];
    xiaohao.text = @"0";
    xiaohao.textColor = [UIColor whiteColor];
    xiaohao.font = [UIFont fontWithName:@"DBLCDTempBlack" size:27];
    [self addSubview:xiaohao];
    [xiaohao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(xhLab);
        make.top.equalTo(junsu);
    }];
    self.xiaohaoLabel = xiaohao;
}

@end

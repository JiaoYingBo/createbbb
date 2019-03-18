//
//  ComHeaderView.m
//  GraduateProj
//
//  Created by jay on 2019/1/15.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "ComHeaderView.h"

@implementation ComHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self configUI];
    }
    return self;
}

- (void)configUI{
    
    self.daysLabel = [[UILabel alloc] init];
    self.daysLabel.layer.borderColor = kColor(0, 191, 242, 1).CGColor;
    self.daysLabel.layer.borderWidth = 1;
    self.daysLabel.numberOfLines = 2;
    self.daysLabel.textColor = kColor(0, 191, 242, 1);
    self.daysLabel.text = @"打卡天数\n5天";
    self.daysLabel.adjustsFontSizeToFitWidth = YES;
    self.daysLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.daysLabel];
   
    self.allLabel = [[UILabel alloc] init];
    self.allLabel.layer.borderColor = kColor(0, 191, 242, 1).CGColor;
    self.allLabel.layer.borderWidth = 1;
    self.allLabel.numberOfLines = 2;
    self.allLabel.textColor = kColor(0, 191, 242, 1);
    self.allLabel.text = @"总时间\n2.5小时";
    self.allLabel.adjustsFontSizeToFitWidth = YES;
    self.allLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.allLabel];
    
    self.averageLabel = [[UILabel alloc] init];
    self.averageLabel.layer.borderColor = kColor(0, 191, 242, 1).CGColor;
    self.averageLabel.layer.borderWidth = 1;
    self.averageLabel.numberOfLines = 2;
    self.averageLabel.textColor = kColor(0, 191, 242, 1);
    self.averageLabel.text = @"日均时间\n0.5小时";
    self.averageLabel.adjustsFontSizeToFitWidth = YES;
    self.averageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.averageLabel];
   
    [@[self.daysLabel,self.allLabel,self.averageLabel] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:30 tailSpacing:30];
    [@[self.daysLabel,self.allLabel,self.averageLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.height.mas_equalTo(60);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kColor(0, 191, 242, 1);
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.daysLabel.mas_bottom).offset(10);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    self.diaryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.diaryBtn.backgroundColor = kColor(0, 191, 242, 1);
    [self.diaryBtn setTitle:@"健康日记" forState:UIControlStateNormal];
    self.diaryBtn.layer.cornerRadius = 5;
    self.diaryBtn.layer.masksToBounds = YES;
    [self addSubview:self.diaryBtn];
    
    self.trainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.trainBtn.backgroundColor = kColor(0, 191, 242, 1);
    [self.trainBtn setTitle:@"开始训练" forState:UIControlStateNormal];
    self.trainBtn.layer.cornerRadius  = 5;
    self.trainBtn.layer.masksToBounds = YES;
    [self addSubview:self.trainBtn];
    
    
    self.releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.releaseBtn.backgroundColor = kColor(0, 191, 242, 1);
    [self.releaseBtn setTitle:@"发布活动" forState:UIControlStateNormal];
    self.releaseBtn.layer.cornerRadius = 5;
    self.releaseBtn.layer.masksToBounds = YES;
    [self addSubview:self.releaseBtn];
    
    [@[self.diaryBtn,self.trainBtn,self.releaseBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:30 tailSpacing:30];
    [@[self.diaryBtn,self.trainBtn,self.releaseBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
   
    UIImageView *one = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"keben"]];
    [self addSubview:one];
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.diaryBtn.mas_bottom).offset(2);
        make.width.height.mas_equalTo(16);
        make.centerX.equalTo(self.diaryBtn.mas_centerX);
    }];
    UIImageView *two = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yundong"]];
    [self addSubview:two];
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trainBtn.mas_bottom).offset(2);
        make.width.height.mas_equalTo(16);
        make.centerX.equalTo(self.trainBtn.mas_centerX);
    }];
    UIImageView *three = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fabu-copy"]];
    [self addSubview:three];
    [three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.releaseBtn.mas_bottom).offset(2);
        make.width.height.mas_equalTo(16);
        make.centerX.equalTo(self.releaseBtn.mas_centerX);
    }];
    
}
@end

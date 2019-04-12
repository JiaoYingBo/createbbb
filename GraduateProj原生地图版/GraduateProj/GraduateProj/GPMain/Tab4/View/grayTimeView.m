//
//  grayTimeView.m
//  GraduateProj
//
//  Created by jay on 2019/1/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "grayTimeView.h"

@implementation grayTimeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor whiteColor];
        [self configUI];
        
    }
    return self;
}
- (void)configUI{
    
    
//    UIEdgeInsets padding = UIEdgeInsetsMake(20, 10, 20, 10);
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self).with.insets(padding);
//    }];
    
    self.timerLabel = [[UILabel alloc] init];
    self.timerLabel.backgroundColor = [UIColor lightGrayColor];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    self.timerLabel.text = @"00-00-00";
    self.timerLabel.textColor = [UIColor whiteColor];
    self.timerLabel.font = [UIFont boldSystemFontOfSize:40];
    [self addSubview:self.timerLabel];
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.5);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(200);
    }];
    
    self.endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endBtn.backgroundColor = kColor(0, 191, 242, 1);
    [self.endBtn setTitle:@"结束训练" forState:UIControlStateNormal];
    self.endBtn.layer.cornerRadius = 5;
    self.endBtn.layer.masksToBounds = YES;
    self.endBtn.alpha = 0;
    [self addSubview:self.endBtn];
    
    self.pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseBtn.backgroundColor = kColor(0, 191, 242, 1);
    [self.pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    self.pauseBtn.layer.cornerRadius  = 5;
    self.pauseBtn.layer.masksToBounds = YES;
    [self addSubview:self.pauseBtn];
    
    self.goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goBtn.backgroundColor = kColor(0, 191, 242, 1);
    [self.goBtn setTitle:@"继续训练" forState:UIControlStateNormal];
    self.goBtn.layer.cornerRadius = 5;
    self.goBtn.layer.masksToBounds = YES;
    self.goBtn.alpha = 0;
    [self addSubview:self.goBtn];
    
    [@[self.endBtn,self.pauseBtn,self.goBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:30 tailSpacing:30];
    [@[self.endBtn,self.pauseBtn,self.goBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(40);
    }];
}
@end

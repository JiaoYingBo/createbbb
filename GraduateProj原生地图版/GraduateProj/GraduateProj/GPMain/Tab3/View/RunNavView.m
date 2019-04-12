//
//  RunNavView.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunNavView.h"

@implementation RunNavView {
    UIButton *_left;
    UIButton *_right;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        _type = RunNavViewTypeNormal;
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = kColor(51, 51, 68, 1);
    
    UILabel *countLab = [UILabel new];
    countLab.text = @"开始跑步";
    countLab.textColor = [UIColor whiteColor];
    countLab.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(10);
    }];
    self.titleLabel = countLab;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-12);
        make.right.equalTo(self).offset(-20);
        make.width.height.mas_equalTo(21);
    }];
    _right = rightBtn;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setTitle:@"隐藏" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.centerY.equalTo(rightBtn);
    }];
    _left = leftBtn;
}

-(void)setType:(RunNavViewType)type {
    _type = type;
    if (type == RunNavViewTypeNormal) {
        self.titleLabel.text = @"开始跑步";
        _right.hidden = NO;
        _left.hidden = NO;
        [_left setTitle:@"隐藏" forState:UIControlStateNormal];
    } else if (type == RunNavViewTypeRunEnd) {
        self.titleLabel.text = @"跑步结束";
        _right.hidden = YES;
        _left.hidden = NO;
        [_left setTitle:@"不保存" forState:UIControlStateNormal];
    } else if (type == RunNavViewTypeRecord) {
        self.titleLabel.text = @"跑步记录";
        _right.hidden = YES;
        _left.hidden = YES;
    }
}

- (void)leftClick {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    if (self.leftBtnClick) {
        self.leftBtnClick();
    }
}

- (void)rightClick {
    NSLog(@"设置");
}

@end

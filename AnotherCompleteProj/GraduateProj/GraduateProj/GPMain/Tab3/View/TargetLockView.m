//
//  TargetLockView.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/15.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "TargetLockView.h"

@implementation TargetLockView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 3;
    bgView.layer.shadowOpacity = 0.7;
    bgView.layer.shadowOffset = CGSizeMake(0, 1);
    bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"target-lock"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(lockClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(21);
    }];
}

- (void)lockClick {
    if (self.lockBtnClick) {
        self.lockBtnClick();
    }
}

@end

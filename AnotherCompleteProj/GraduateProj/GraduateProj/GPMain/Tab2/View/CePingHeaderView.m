//
//  CePingHeaderView.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/7.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "CePingHeaderView.h"

@implementation CePingHeaderView {
    BOOL _isLeft;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configData];
        [self configUI];
    }
    return self;
}

- (void)configData {
    _isLeft = YES;
}

- (void)configUI {
    UIImageView *bgImg = [[UIImageView alloc] init];
    bgImg.image = [UIImage imageNamed:@"paobu"];
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
    bgImg.layer.masksToBounds = YES;
    [self addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-40);
    }];
    UIView *bgView = [UIView new];
    bgView.backgroundColor = kColor(33, 153, 252, 0.6);
    [bgImg addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgImg);
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"在线自评" forState:UIControlStateNormal];
    [leftBtn setTitleColor:kColor(84, 175, 248, 1) forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImg.mas_bottom);
        make.left.bottom.equalTo(self);
        make.width.mas_equalTo(kScreenWidth/2.0);
    }];
    self.leftBtn = leftBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"自评记录" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImg.mas_bottom);
        make.right.bottom.equalTo(self);
        make.width.mas_equalTo(kScreenWidth/2.0);
    }];
    self.rightBtn = rightBtn;
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.backgroundColor = kColor(84, 175, 248, 1);
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
        make.height.mas_equalTo(3);
    }];
    
    self.headImg = [[UIImageView alloc] init];
    self.headImg.image = [UIImage imageNamed:@"headerImage"];
    self.headImg.contentMode = UIViewContentModeScaleAspectFill;
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = 45;
    self.headImg.layer.borderWidth = 2;
    self.headImg.layer.borderColor = kColor(255, 215, 0, 1).CGColor;
    [self addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(25);
        make.width.height.mas_equalTo(90);
    }];
    
    UIView *sexView = [UIView new];
    sexView.backgroundColor = [UIColor whiteColor];
    sexView.layer.masksToBounds = YES;
    sexView.layer.cornerRadius = 10;
    [self addSubview:sexView];
    [sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(30);
        make.top.equalTo(self).offset(30);
        make.width.height.mas_equalTo(20);
    }];
    self.sexImg = [[UIImageView alloc] init];
    self.sexImg.image = [UIImage imageNamed:@"nan"];
    self.sexImg.contentMode = UIViewContentModeScaleAspectFill;
    [sexView addSubview:self.sexImg];
    [self.sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(sexView);
        make.width.height.mas_equalTo(15);
    }];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.text = @"王库里";
    self.nameLabel.textColor = kColor(255, 215, 0, 1);
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.headImg.mas_bottom).offset(14);
    }];
    
    self.detailLabel = [UILabel new];
    self.detailLabel.text = @"20岁，身高180.2厘米，体重78.5千克";
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
}

- (void)leftClick {
    [self enableButtonDelay];
    [self.leftBtn setTitleColor:kColor(84, 175, 248, 1) forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
        make.height.mas_equalTo(3);
    }];
    if (self.leftRightClick) {
        if (!_isLeft) {
            self.leftRightClick(YES);
        }
    }
    _isLeft = YES;
}

- (void)rightClick {
    [self enableButtonDelay];
    [self.leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kColor(84, 175, 248, 1) forState:UIControlStateNormal];
    [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_centerX);
        make.width.equalTo(self).multipliedBy(0.5);
        make.height.mas_equalTo(3);
    }];
    if (self.leftRightClick) {
        if (_isLeft) {
            self.leftRightClick(NO);
        }
    }
    _isLeft = NO;
}

- (void)enableButtonDelay {
    
    self.leftBtn.enabled = NO;
    self.rightBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.leftBtn.enabled = YES;
        self.rightBtn.enabled = YES;
    });
}

@end

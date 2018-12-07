//
//  CePingHeaderView.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/7.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "CePingHeaderView.h"

@implementation CePingHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    UIImageView *bgImg = [[UIImageView alloc] init];
    bgImg.image = [UIImage imageNamed:@"paobu"];
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
    bgImg.layer.masksToBounds = YES;
    [self addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-30);
    }];
    UIView *bgView = [UIView new];
    bgView.backgroundColor = kColor(33, 153, 252, 0.6);
    [bgImg addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgImg);
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"在线自评" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImg.mas_bottom);
        make.left.bottom.equalTo(self);
        make.width.mas_equalTo(kScreenWidth/2.0);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"自评记录" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImg.mas_bottom);
        make.right.bottom.equalTo(self);
        make.width.mas_equalTo(kScreenWidth/2.0);
    }];
}

@end

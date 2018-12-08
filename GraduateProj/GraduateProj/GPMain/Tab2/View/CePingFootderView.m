//
//  CePingFootderView.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/8.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "CePingFootderView.h"

@implementation CePingFootderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 5*kScreen_W_Scale;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = kColor(67, 149, 247, 1);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17*kScreen_W_Scale];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(40*kScreen_W_Scale);
    }];
}

- (void)submitBtnClick {
    
}

@end

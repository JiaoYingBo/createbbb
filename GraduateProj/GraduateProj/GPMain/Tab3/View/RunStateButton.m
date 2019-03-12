//
//  RunStateButton.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/12.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunStateButton.h"

@implementation RunStateButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    UIView *bgView2 = [UIView new];
    bgView2.backgroundColor = kColor(220, 220, 220, 1);
    bgView2.layer.cornerRadius = (self.bounds.size.width-10)/2;
    [self addSubview:bgView2];
    [bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(5);
        make.bottom.right.equalTo(self).offset(-5);
    }];
    self.contentView = bgView2;
    
    UILabel *countLab = [UILabel new];
    countLab.text = @"开始";
    countLab.textColor = [UIColor whiteColor];
    countLab.font = [UIFont systemFontOfSize:19];
    [self addSubview:countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    self.titleLabel = countLab;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.contentView.backgroundColor = tintColor;
}

@end

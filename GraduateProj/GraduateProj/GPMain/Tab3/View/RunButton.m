//
//  RunButton.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunButton.h"

@interface RunButton ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation RunButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.bgView.backgroundColor = kColor(10, 100, 255, 1);
    self.label.textColor = kColor(230, 230, 250, 1);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    
    self.bgView.backgroundColor = kColor(41, 146, 255, 1);
    self.label.textColor = [UIColor whiteColor];
    if (self.delegate) {
        [self.delegate didClickedRunButton:self];
    }
}

- (void)configUI {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView1 = [UIView new];
    bgView1.backgroundColor = kColor(164, 211, 250, 1);
    bgView1.layer.cornerRadius = self.bounds.size.width/2;
    [self addSubview:bgView1];
    [bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *bgView2 = [UIView new];
    bgView2.backgroundColor = kColor(41, 146, 255, 1);
    bgView2.layer.cornerRadius = (self.bounds.size.width-8)/2;
    [self addSubview:bgView2];
    [bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(4);
        make.bottom.right.equalTo(self).offset(-4);
    }];
    self.bgView = bgView2;
    
    UILabel *countLab = [UILabel new];
    countLab.text = @"开始\n跑步";
    countLab.numberOfLines = 0;
    countLab.textColor = [UIColor whiteColor];
    countLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    self.label = countLab;
}

@end

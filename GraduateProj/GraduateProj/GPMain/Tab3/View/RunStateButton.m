//
//  RunStateButton.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/12.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunStateButton.h"

#define StopDuration 1.0

@interface RunStateButton () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *displayView;

@end

@implementation RunStateButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _status = RunStateButtonStatusInvalid;
        [self configUI];
        [self configGesture];
    }
    return self;
}

- (void)configUI {
    _displayView = [UIView new];
    _displayView.backgroundColor = [UIColor clearColor];
    _displayView.frame = self.bounds;
    [self addSubview:_displayView];
    
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

- (void)configGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
    longPress.minimumPressDuration = 0.3;
    [self addGestureRecognizer:longPress];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.contentView.backgroundColor = tintColor;
}

- (void)tapGesture {
    if (self.status == RunStateButtonStatusInvalid || self.status == RunStateButtonStatusEnd) {
        return;
    }
    
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    
    if (self.status == RunStateButtonStatusStart) {
        self.status = RunStateButtonStatusPause;
        self.tintColor = kColor(255, 182, 22, 1);
        self.titleLabel.text = @"暂停";
        if (self.didStart) {
            self.didStart();
        }
    } else if (self.status == RunStateButtonStatusPause) {
        self.status = RunStateButtonStatusStart;
        self.tintColor = kColor(71, 190, 112, 1);
        self.titleLabel.text = @"继续";
        if (self.didPause) {
            self.didPause();
        }
    }
}

- (void)longGesture:(UILongPressGestureRecognizer *)sender {
    if (self.status != RunStateButtonStatusEnd) {
        return;
    }
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self drawCircle];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        //
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [self clearDisplayView];
    }
}

- (void)drawCircle {
    [self clearDisplayView];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width) cornerRadius:self.frame.size.width/2];
    layer.path = path.CGPath;
    layer.lineWidth = 3;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = kColor(233, 83, 83, 1).CGColor;
    [_displayView.layer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = StopDuration;
    animation.delegate = self;
    [layer addAnimation:animation forKey:nil];
}

- (void)clearDisplayView {
    [_displayView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.didEnd) {
        self.didEnd();
    }
}

@end

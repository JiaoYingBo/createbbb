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
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

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
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [leftBtn setTitle:@"结束" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:kColor(220, 220, 220, 1)];
    leftBtn.layer.cornerRadius = (self.bounds.size.width-10)/2;
    [leftBtn addTarget:self action:@selector(btnClickTouchDown) forControlEvents:UIControlEventTouchDown];
    [leftBtn addTarget:self action:@selector(btnClickTouchUp) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(5);
        make.bottom.right.equalTo(self).offset(-5);
    }];
    self.contentBtn = leftBtn;
}

- (void)btnClickTouchDown {
    if (self.status != RunStateButtonStatusInvalid) {
        [self circleTurnToSmall];
    }
}

- (void)btnClickTouchUp {
    if (self.status == RunStateButtonStatusInvalid || self.status == RunStateButtonStatusEnd) {
        return;
    }
    [self circleTurnToNormal];
    
    self.contentBtn.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.contentBtn.userInteractionEnabled = YES;
    });
    
    if (self.status == RunStateButtonStatusStart) {
        self.status = RunStateButtonStatusPause;
        self.tintColor = kColor(255, 182, 22, 1);
        self.title = @"暂停";
        if (self.didStart) {
            self.didStart();
        }
    } else if (self.status == RunStateButtonStatusPause) {
        self.status = RunStateButtonStatusStart;
        self.tintColor = kColor(71, 190, 112, 1);
        self.title = @"继续";
        if (self.didPause) {
            self.didPause();
        }
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.contentBtn setTitle:title forState:UIControlStateNormal];
}

- (void)setStatus:(RunStateButtonStatus)status {
    _status = status;
    if (status == RunStateButtonStatusInvalid) {
        self.contentBtn.userInteractionEnabled = NO;
        return;
    }
    self.contentBtn.userInteractionEnabled = YES;
    if (status == RunStateButtonStatusStart || status == RunStateButtonStatusPause) {
        [self.contentBtn removeGestureRecognizer:self.longPress];
    } else if (status == RunStateButtonStatusEnd) {
        [self.contentBtn addGestureRecognizer:self.longPress];
    }
}

- (void)configGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
    // 按下0.1秒后响应长按手势
    longPress.minimumPressDuration = 0.1;
    [self.contentBtn addGestureRecognizer:longPress];
    self.longPress = longPress;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self.contentBtn setBackgroundColor:tintColor];
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
        [self circleTurnToNormal];
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
    if (self.didEnd && flag == YES) {
        self.didEnd();
    }
}

- (void)circleTurnToSmall {
    [self.contentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(7);
        make.bottom.right.equalTo(self).offset(-7);
    }];
    self.contentBtn.layer.cornerRadius = (self.bounds.size.width-14)/2;
}

- (void)circleTurnToNormal {
    [self.contentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(5);
        make.bottom.right.equalTo(self).offset(-5);
    }];
    self.contentBtn.layer.cornerRadius = (self.bounds.size.width-10)/2;
}

@end

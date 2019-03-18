//
//  CountDownView.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/13.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "CountDownView.h"

@interface CountDownView ()

@property (nonatomic, copy) void(^didCompletion)(void);

@end

@implementation CountDownView {
    NSTimer *_timer;
    int _count;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _count = 2;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backgroundColor = kColor(255, 124, 93, 1);
    self.alpha = 0;
    
    UILabel *distance = [UILabel new];
    distance.text = @"";
    distance.textColor = [UIColor whiteColor];
    distance.font = [UIFont fontWithName:@"Helvetica Neue" size:210];
    [self addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    self.countLabel = distance;
}

//- (void)show {
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.alpha = 1;
//    } completion:^(BOOL finished) {
//        self.countLabel.text = @"3";
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatTime) userInfo:nil repeats:YES];
//    }];
//}
- (void)showWithDismissCompletion:(void(^)(void))completion {
    _didCompletion = completion;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        self.countLabel.text = @"3";
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatTime) userInfo:nil repeats:YES];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0.2;
    } completion:^(BOOL finished) {
        if (_didCompletion) {
            _didCompletion();
            // 这里怎么解除内存泄漏，这个方法不知是否可行！！！！！！！！！！！！！！
            _didCompletion = nil;
        }
        [self removeFromSuperview];
    }];
}

- (void)repeatTime {
    if (_count > 0) {
        self.countLabel.text = [NSString stringWithFormat:@"%d", _count];
        _count --;
    } else if (_count == 0) {
        self.countLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:170];
        self.countLabel.text = @"GO";
        _count --;
    } else {
        [_timer invalidate];
        _timer = nil;
        [self dismiss];
    }
}

@end

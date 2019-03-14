//
//  RunStateButton.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/12.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RunStateButtonStatus) {
    RunStateButtonStatusEnd     = 0,
    RunStateButtonStatusStart   = 1,
    RunStateButtonStatusPause   = 2,
    RunStateButtonStatusInvalid = 3,
};

@interface RunStateButton : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIColor *tintColor;
// 默认是Invalid，如果是End/Invalid，button单击不会切换状态，Start和Pause会相互切换状态
@property (nonatomic, assign) RunStateButtonStatus status;
// 长按 StopDuration 秒后触发didEnd
@property (nonatomic, copy) void(^didEnd)(void);
@property (nonatomic, copy) void(^didPause)(void);
@property (nonatomic, copy) void(^didStart)(void);

@end

NS_ASSUME_NONNULL_END
